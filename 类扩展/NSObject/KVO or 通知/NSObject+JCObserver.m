//
//  NSObject+JCObserver.m
//  XWEasyKVOBlock
//
//  Created by 林建川 on 16/8/12.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import "NSObject+JCObserver.h"
#import <objc/message.h>

#pragma mark - 键

static void *const JCSemaphoreChangeKey = "JCSemaphoreChangeKey";
static void *const JCChangeKey = "JCChangeKey";

static void *const JCSemaphoreElsewhereKey = "JCSemaphoreElsewhereKey";
static void *const JCChangeElsewhereKey = "JCChangeElsewhereKey";

static void *const JCSemaphoreNotificationKey = "JCSemaphoreNotificationKey";
static void *const JCCallbackkey = "JCCallbackkey";

static void *const JCDeallocHasSwizzledKey = "deallocHasSwizzledKey";

#pragma mark - JCObserverTarget

@interface JCObserverTarget : NSObject

- (void)addTargetBlock:(void(^)(__weak id obj, id oldValue, id newValue))block;

- (void)addElsewhereTargetBlock:(NSString *)mark;

- (void)addNotificationBlock:(void(^)(NSNotification *notification))block;

@end

@implementation JCObserverTarget
{
    NSMutableSet *_targetBlockSet;
    NSMutableSet *_elsewheretargetBlockSet;
    NSMutableSet *_notificationBlockSet;
}
- (instancetype)init {
    if (self = [super init]) {
        _targetBlockSet = [NSMutableSet new];
        _elsewheretargetBlockSet = [NSMutableSet new];
        _notificationBlockSet = [NSMutableSet new];
    }
    return self;
}

- (void)addTargetBlock:(void (^)(__weak id obj, id oldValue, id newValue))block {
    [_targetBlockSet addObject:[block copy]];
}

- (void)addElsewhereTargetBlock:(NSString *)mark {
    [_elsewheretargetBlockSet addObject:mark];
}

- (void)addNotificationBlock:(void(^)(NSNotification *notification))block {
    [_notificationBlockSet addObject:[block copy]];
}

/**
 *  KVO 回调
 */
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    BOOL prior = [[change objectForKey:NSKeyValueChangeNotificationIsPriorKey] boolValue];
    //只接受值改变时的消息
    if (prior) {
        return;
    }
    NSKeyValueChange changeKind = [[change objectForKey:NSKeyValueChangeKindKey] integerValue];
    id newVal = [change objectForKey:NSKeyValueChangeNewKey];
    id oldVal = [change objectForKey:NSKeyValueChangeOldKey];
    if (changeKind != NSKeyValueChangeSetting) {
        return;
    }
    
    // KVO
    if (_targetBlockSet.count) {
        if (oldVal == [NSNull null]) {
            oldVal = nil;
        }
        if (newVal == [NSNull null]) {
            newVal = nil;
        }
        [_targetBlockSet enumerateObjectsUsingBlock:^(void (^block)(__weak id obj, id oldVal, id newVal), BOOL * _Nonnull stop) {
            block(object, oldVal, newVal);
        }];
    }

    // 通知
    if (_elsewheretargetBlockSet.count) {
        NSMutableDictionary *valueDicM = [NSMutableDictionary new];
        if (oldVal != [NSNull null]) {
            valueDicM[@"oblValue"] = oldVal;
        }
        if (newVal != [NSNull null]) {
            valueDicM[@"newValue"] = newVal;
        }
        valueDicM[@"obj"] = object;
        [_elsewheretargetBlockSet enumerateObjectsUsingBlock:^(NSString *mark, BOOL * _Nonnull stop) {
            [[NSNotificationCenter defaultCenter] postNotificationName:mark object:nil userInfo:valueDicM];
        }];
    }
}

/**
 *  通知的回调
 */
- (void)notificationCallback:(NSNotification *)notification {
    if (_notificationBlockSet.count) {
        [_notificationBlockSet enumerateObjectsUsingBlock:^(void (^block)(NSNotification *notification), BOOL * _Nonnull stop) {
            block(notification);
        }];
    }
}

@end

@implementation NSObject (JCObserver)

#pragma mark - KVO

/**
 *  添加监听(KVO)
 *
 *  @param keyPath 要监听的路径
 *  @param change  结果变化的回调
 */
- (void)addKeyPath:(NSString *)keyPath change:(void (^)(id obj, id oldValue, id newValue))change {
    if (!keyPath) {  // 判断监听的路径是否为空；空的就无法监听，直接结束。
        return;
    }
    if (!change) {   // 判断回调是否有；没有的话，结果的变化就没有去处。
        return;
    }
    
    dispatch_semaphore_t semaphore = [self getSemaphoreWithKey:JCSemaphoreChangeKey];
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    
    // 取出存有所有target的字典
    NSMutableDictionary *allTargetDic = objc_getAssociatedObject(self, JCChangeKey);
    if (!allTargetDic) {  // 若没有则创建
        allTargetDic = [NSMutableDictionary new];
        
        // 绑定在该对象里
        objc_setAssociatedObject(self, JCChangeKey, allTargetDic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    // 获取对应keyPath中的所有target
    JCObserverTarget *observerTarget = allTargetDic[keyPath];
    if (!observerTarget) {
        observerTarget = [[JCObserverTarget alloc] init];  // 没有则创建
        allTargetDic[keyPath]= observerTarget; // 保存
        
        // 如果第一次，则注册对keyPath的KVO监听
        [self addObserver:observerTarget forKeyPath:keyPath options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    }
    [observerTarget addTargetBlock:change];
    [self swizzleDealloc];
    dispatch_semaphore_signal(semaphore);
}

/**
 *  提前移除KVO下指定的KeyPath
 */
- (void)removeObserverForKeyPath:(NSString *)keyPath {
    if (!keyPath) {
        return;
    }
    NSMutableDictionary *allTargets = objc_getAssociatedObject(self, JCChangeKey);
    if (!allTargets){
        return;
    }
    JCObserverTarget *target = allTargets[keyPath];
    if (!target) {
        return;
    }
    dispatch_semaphore_t kvoSemaphore = [self getSemaphoreWithKey:JCSemaphoreChangeKey];
    dispatch_semaphore_wait(kvoSemaphore, DISPATCH_TIME_FOREVER);
    [self removeObserver:target forKeyPath:keyPath];
    [allTargets removeObjectForKey:keyPath];
    dispatch_semaphore_signal(kvoSemaphore);
}

/**
 *  清除所有KVO监听
 */
- (void)removeAllObserver {
    NSMutableDictionary *allTargetDic = objc_getAssociatedObject(self, JCChangeKey);
    if (!allTargetDic) {
        return;
    }
    dispatch_semaphore_t semaphore = [self getSemaphoreWithKey:JCSemaphoreChangeKey];
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    [allTargetDic enumerateKeysAndObjectsUsingBlock:^(id key, JCObserverTarget *target, BOOL *stop) {
        [self removeObserver:target forKeyPath:key];
    }];
    [allTargetDic removeAllObjects];
    dispatch_semaphore_signal(semaphore);
}

#pragma mark - 通知

/**
 *  发送通知
 *
 *  @param name     通知名
 *  @param userInfo 要传递的数据
 */
- (void)postNotificationForName:(NSString *)name userInfo:(NSDictionary *)userInfo {
    [[NSNotificationCenter defaultCenter] postNotificationName:name object:nil userInfo:userInfo];
}

/**
 *  添加通知监听
 *
 *  @param name     通知名
 *  @param callback 回调处理
 */
- (void)addNotificationForName:(NSString *)name callback:(void (^)(NSNotification *notification))callback {
    if (!name) {
        return;
    }
    if (!callback) {
        return;
    }
    dispatch_semaphore_t notificationSemaphore = [self getSemaphoreWithKey:JCSemaphoreNotificationKey];
    dispatch_semaphore_wait(notificationSemaphore, DISPATCH_TIME_FOREVER);
    NSMutableDictionary *allTargets = objc_getAssociatedObject(self, JCCallbackkey);
    if (!allTargets) {
        allTargets = @{}.mutableCopy;
        objc_setAssociatedObject(self, JCCallbackkey, allTargets, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    JCObserverTarget *target = allTargets[name];
    if (!target) {
        target = [JCObserverTarget new];
        allTargets[name] = target;
        [[NSNotificationCenter defaultCenter] addObserver:target selector:@selector(notificationCallback:) name:name object:nil];
    }
    [target addNotificationBlock:callback];
    [self swizzleDealloc];
    dispatch_semaphore_signal(notificationSemaphore);
}

/**
 *  清除所有通知
 */
- (void)removeAllNotification {
    NSMutableDictionary *allTargets = objc_getAssociatedObject(self, JCCallbackkey);
    if (!allTargets.count) return;
    dispatch_semaphore_t notificationSemaphore = [self getSemaphoreWithKey:JCSemaphoreNotificationKey];
    dispatch_semaphore_wait(notificationSemaphore, DISPATCH_TIME_FOREVER);
    [allTargets enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, JCObserverTarget *target, BOOL * _Nonnull stop) {
        [[NSNotificationCenter defaultCenter] removeObserver:target];
    }];
    [allTargets removeAllObjects];
    dispatch_semaphore_signal(notificationSemaphore);
}

/**
 *  清除指定的通知
 *
 *  @param name 通知名
 */
- (void)removeNotificationForName:(NSString *)name {
    if (!name) {
        return;
    }
    NSMutableDictionary *allTargets = objc_getAssociatedObject(self, JCCallbackkey);
    if (!allTargets.count) return;
    JCObserverTarget *target = allTargets[name];
    if (!target) {
        return;
    }
    dispatch_semaphore_t notificationSemaphore = [self getSemaphoreWithKey:JCSemaphoreNotificationKey];
    dispatch_semaphore_wait(notificationSemaphore, DISPATCH_TIME_FOREVER);
    [[NSNotificationCenter defaultCenter] removeObserver:target];
    [allTargets removeObjectForKey:name];
    dispatch_semaphore_signal(notificationSemaphore);
}

#pragma mark - KVO or 通知

/**
 *  添加监听属性路径，用通知来回调
 *
 *  @param keyPath 属性
 *  @param mark    通知名
 */
- (void)addKeyPath:(NSString *)keyPath elsewhereObserveForMark:(NSString *)mark {
    if (!keyPath) {
        return;
    }
    if (!mark) {
        return;
    }
    dispatch_semaphore_t semaphore = [self getSemaphoreWithKey:JCSemaphoreElsewhereKey];
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    NSMutableDictionary *allTargetDic = objc_getAssociatedObject(self, JCChangeKey);
    if (!allTargetDic) {
        allTargetDic = [NSMutableDictionary new];
        objc_setAssociatedObject(self, JCChangeKey, allTargetDic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    JCObserverTarget *observerTarget = allTargetDic[keyPath];
    if (!observerTarget) {
        observerTarget = [[JCObserverTarget alloc] init];  // 没有则创建
        allTargetDic[keyPath]= observerTarget; // 保存
        
        // 如果第一次，则注册对keyPath的KVO监听
        [self addObserver:observerTarget forKeyPath:keyPath options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    }
    [observerTarget addElsewhereTargetBlock:mark];
    [self swizzleDealloc];
    dispatch_semaphore_signal(semaphore);
}

/**
 *  接收通知消息
 *
 *  @param mark   通知名
 *  @param change 回调
 */
- (void)addObserveFromMark:(NSString *)mark change:(void (^)(id obj, id oldValue, id newValue))change {
    [self addNotificationForName:mark callback:^(NSNotification *notification) {
        id obj = notification.userInfo[@"obj"];
        id newValue = notification.userInfo[@"newValue"];
        id oblValue = notification.userInfo[@"oblValue"];
        if (!obj) {
            obj = nil;
        }
        if (!newValue) {
            newValue = nil;
        }
        if (!oblValue) {
            oblValue = nil;
        }
        change(obj,oblValue,newValue);
    }];
}

/**
 *  提前移除回调方法为通知的KVO下指定的KeyPath
 */
- (void)removeElsewhereObserverForKeyPath:(NSString *)keyPath {
    if (!keyPath) {
        return;
    }
    NSMutableDictionary *allTargets = objc_getAssociatedObject(self, JCChangeKey);
    if (!allTargets){
        return;
    }
    JCObserverTarget *target = allTargets[keyPath];
    if (!target) {
        return;
    }
    dispatch_semaphore_t kvoSemaphore = [self getSemaphoreWithKey:JCSemaphoreElsewhereKey];
    dispatch_semaphore_wait(kvoSemaphore, DISPATCH_TIME_FOREVER);
    [self removeObserver:target forKeyPath:keyPath];
    [allTargets removeObjectForKey:keyPath];
    dispatch_semaphore_signal(kvoSemaphore);
}

/**
 *  清除回调方式通知的所有KVO监听
 */
- (void)removeAllElsewhereObserver {
    NSMutableDictionary *allTargets = objc_getAssociatedObject(self, JCChangeElsewhereKey);
    if (!allTargets.count) return;
    dispatch_semaphore_t notificationSemaphore = [self getSemaphoreWithKey:JCSemaphoreElsewhereKey];
    dispatch_semaphore_wait(notificationSemaphore, DISPATCH_TIME_FOREVER);
    [allTargets enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, JCObserverTarget *target, BOOL * _Nonnull stop) {
        [self removeObserver:target forKeyPath:key];
    }];
    [allTargets removeAllObjects];
    dispatch_semaphore_signal(notificationSemaphore);
}

#pragma mark - dealloc

- (void)swizzleDealloc {
    //我们给每个类绑定上一个值来判断dealloc方法是否被调剂过，如果调剂过了就无需再次调剂了
    BOOL swizzled = [objc_getAssociatedObject(self.class, JCDeallocHasSwizzledKey) boolValue];
    
    //如果调剂过则直接返回
    if (swizzled) {
        return;
    }
    
    //开始调剂
    Class swizzleClass = self.class;
    @synchronized(swizzleClass) {
        //获取原有的dealloc方法
        SEL deallocSelector = sel_registerName("dealloc");
        //初始化一个函数指针用于保存原有的dealloc方法
        __block void (*originalDealloc)(__unsafe_unretained id, SEL) = NULL;
        //实现我们自己的dealloc方法，通过block的方式
        id newDealloc = ^(__unsafe_unretained id objSelf){
            //在这里我们移除所有的KVO
            [objSelf removeAllObserver];
            [objSelf removeAllElsewhereObserver];
            [objSelf removeAllNotification];
            //根据原有的dealloc方法是否存在进行判断
            if (originalDealloc == NULL) {//如果不存在，说明本类没有实现dealloc方法，则需要向父类发送dealloc消息(objc_msgSendSuper)
                //构造objc_msgSendSuper所需要的参数，.receiver为方法的实际调用者，即为类本身，.super_class指向其父类
                struct objc_super superInfo = {
                    .receiver = objSelf,
                    .super_class = class_getSuperclass(swizzleClass)
                };
                //构建objc_msgSendSuper函数
                void (*msgSend)(struct objc_super *, SEL) = (__typeof__(msgSend))objc_msgSendSuper;
                //向super发送dealloc消息
                msgSend(&superInfo, deallocSelector);
            }else{//如果存在，表明该类实现了dealloc方法，则直接调用即可
                //调用原有的dealloc方法
                originalDealloc(objSelf, deallocSelector);
            }
        };
        //根据block构建新的dealloc实现IMP
        IMP newDeallocIMP = imp_implementationWithBlock(newDealloc);
        //尝试添加新的dealloc方法，如果该类已经复写的dealloc方法则不能添加成功，反之则能够添加成功
        if (!class_addMethod(swizzleClass, deallocSelector, newDeallocIMP, "v@:")) {
            //如果没有添加成功则保存原有的dealloc方法，用于新的dealloc方法中
            Method deallocMethod = class_getInstanceMethod(swizzleClass, deallocSelector);
            originalDealloc = (void(*)(__unsafe_unretained id, SEL))method_getImplementation(deallocMethod);
            originalDealloc = (void(*)(__unsafe_unretained id, SEL))method_setImplementation(deallocMethod, newDeallocIMP);
        }
        //标记该类已经调剂过了
        objc_setAssociatedObject(self.class, JCDeallocHasSwizzledKey, @(YES), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

#pragma mark - Semaphore(信号量)

- (dispatch_semaphore_t)getSemaphoreWithKey:(void *)key {
    dispatch_semaphore_t semaphore = objc_getAssociatedObject(self, key);
    if (!semaphore) {
        semaphore = dispatch_semaphore_create(1);
        objc_setAssociatedObject(semaphore, key, semaphore, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return semaphore;
}

@end


