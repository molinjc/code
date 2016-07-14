
//
//  JCAlterView.m
//  new
//
//  Created by molin on 15/9/24.
//  Copyright (c) 2015年 chinat2t. All rights reserved.
//

#import "JCAlterView.h"

// 设置提示框的高和宽

#define Alertwidth     ([UIScreen mainScreen].bounds.size.width*910/1080)
#define messageheigth  Alertheigth*0.7

#define WIDTH          [UIScreen mainScreen].bounds.size.width
#define HEIGHT         [UIScreen mainScreen].bounds.size.height

@interface JCAlterView ()

@property (nonatomic, strong) UILabel   *message;          // 文本内容
@property (nonatomic, strong) UILabel   *noPrompt;         // 不再提示
@property (nonatomic, strong) UIButton  *btn_no;           // 不在提示的按钮
@property (nonatomic, strong) UIButton  *btn_sure;         // 确定按钮
@property (nonatomic, strong) UIView    *backimageView;    // 背景

@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) BOOL    isSelect;

@end

@implementation JCAlterView

- (instancetype)initWithMessage:(NSString *)message {
    if (self = [super init]) {
        self.layer.cornerRadius = 5;
        self.backgroundColor = [UIColor whiteColor];
        self.isSelect = YES;
        self.message.text = message;
        CGSize textSize=[message boundingRectWithSize:CGSizeMake(Alertwidth-40, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.message.font} context:nil].size;
        self.message.frame = CGRectMake(self.message.frame.origin.x, self.message.frame.origin.y, self.message.frame.size.width, textSize.height+8);
        [self addSubview:self.message];
        [self addSubview:self.noPrompt];
        [self addSubview:self.btn_no];
        [self addSubview:self.btn_sure];
        
         self.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
    }
    return self;
}

- (void)show {
    self.height = self.message.frame.size.height+self.noPrompt.frame.size.height+self.btn_sure.frame.size.height+41;
    //获取第一响应视图视图
    UIViewController *topVC = [self appRootViewController];
    self.frame = CGRectMake(WIDTH/2-Alertwidth/2, HEIGHT/2-self.height/2-40, Alertwidth, self.height);
    self.alpha=0;
    [topVC.view addSubview:self];
}
- (UIViewController *)appRootViewController{
    
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    while (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    return topVC;
}
- (void)removeFromSuperview
{
    [self.backimageView removeFromSuperview];
    self.backimageView = nil;
    [UIView animateWithDuration:0.3f delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [super removeFromSuperview];
    }];
}
//添加新视图时调用（在一个子视图将要被添加到另一个视图的时候发送此消息）
- (void)willMoveToSuperview:(UIView *)newSuperview
{
    if (newSuperview == nil) {
        return;
    }
    //     获取根控制器
    UIViewController *topVC = [self appRootViewController];
    
    if (!self.backimageView) {
        self.backimageView = [[UIView alloc] initWithFrame:topVC.view.bounds];
        self.backimageView.backgroundColor = [UIColor colorWithWhite:0.529 alpha:1.000];
        self.backimageView.alpha = 0.6f;
    }
    //    加载背景背景图,防止重复点击
    [topVC.view addSubview:self.backimageView];
    
    self.alpha=1;
    [super willMoveToSuperview:newSuperview];
}


#pragma mark - 按钮点击事件

- (void)noPromptAction:(UIButton *)sender {
    if (self.isSelect) {
        [self.btn_no setBackgroundImage:[UIImage imageNamed:@"btn_select_0"] forState:UIControlStateNormal];
        self.isSelect = NO;
    }else {
        [self.btn_no setBackgroundImage:[UIImage imageNamed:@"A"] forState:UIControlStateNormal];
        self.isSelect = YES;
    }
}

#pragma mark - 控件懒加载

- (UILabel *)message {
    if (!_message) {
        _message = [[UILabel alloc]initWithFrame:CGRectMake(20, 20, Alertwidth-40, 0)];
        _message.textAlignment = NSTextAlignmentCenter;
        _message.numberOfLines = 0;
        _message.font = [UIFont systemFontOfSize:18];
        _message.textColor = [UIColor blackColor];
    }
    return _message;
}

- (UILabel *)noPrompt {
    if (!_noPrompt) {
        _noPrompt = [[UILabel alloc]initWithFrame:CGRectMake(Alertwidth/2-10, self.message.frame.size.height+self.message.frame.origin.y+15, Alertwidth/2, 20)];
        _noPrompt.textAlignment = NSTextAlignmentLeft;
        _noPrompt.font = [UIFont systemFontOfSize:15];
        _noPrompt.textColor = [UIColor blackColor];
        _noPrompt.text = @"不再提示";
    }
    return _noPrompt;
}

- (UIButton *)btn_no {
    if (!_btn_no) {
        _btn_no = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _btn_no.backgroundColor = [UIColor whiteColor];
        _btn_no.layer.borderColor = [UIColor colorWithWhite:0.793 alpha:1.000].CGColor;
        _btn_no.layer.borderWidth = 1;
        _btn_no.frame = CGRectMake(Alertwidth/2-40, self.message.frame.size.height+self.message.frame.origin.y+15, 20, 20);
        [_btn_no addTarget:self action:@selector(noPromptAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn_no;
}
- (UIButton *)btn_sure {
    if (!_btn_sure) {
        _btn_sure = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _btn_sure.frame = CGRectMake(0, self.noPrompt.frame.size.height+self.noPrompt.frame.origin.y+6, Alertwidth, 50);
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, _btn_sure.frame.origin.y, Alertwidth, 0.5)];
        line.backgroundColor = [UIColor colorWithWhite:0.769 alpha:1.000];
        [self addSubview:line];
        [_btn_sure setTitle:@"确定" forState:UIControlStateNormal];
        [_btn_sure setTitleColor:[UIColor colorWithRed:0.004 green:0.373 blue:0.996 alpha:1.000] forState:UIControlStateNormal];
        [_btn_sure addTarget:self action:@selector(removeFromSuperview) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn_sure;
}


@end
