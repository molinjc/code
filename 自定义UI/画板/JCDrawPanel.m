//
//  JCDrawPanel.m
//  JCDrawPanel
//
//  Created by molin on 16/5/23.
//  Copyright © 2016年 molin. All rights reserved.
//

#import "JCDrawPanel.h"

@interface JCDrawPanel ()

@property (nonatomic, strong) NSMutableArray *recordPointArray; // 记录触摸点

@property (nonatomic, strong) NSMutableArray *recoveryPointArray; // 撤销的点（可恢复的点）

@end

@implementation JCDrawPanel

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.lineColor = [UIColor blackColor];
        self.lineWidth = 5.0;
    }
    return self;
}

#pragma mark - 画线

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    path.lineWidth = self.lineWidth;
    path.lineJoinStyle = kCGLineJoinRound;
    [self.lineColor set];
    [self.recordPointArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSMutableArray *arr = obj;
        for (int i=0; i<arr.count; i++) {
            CGPoint point = CGPointFromString(arr[i]);
            if (i == 0) {
                [path moveToPoint:point];
            }else {
                [path addLineToPoint:point];
            }
        }
    }];
    [path stroke];
    
    
    
    
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSetLineWidth(context, 5.0);
//    CGContextSetLineCap(context, kCGLineCapRound);
//    [[UIColor greenColor] set];
//    
//    for (int i=1; i<self.recordPointArray.count;) {
//        CGPoint point1 = CGPointFromString(self.recordPointArray[i-1]);
//        CGPoint point2 = CGPointFromString(self.recordPointArray[i]);
//        CGContextMoveToPoint(context, point1.x, point1.y);
//        CGContextAddLineToPoint(context, point2.y, point2.y);
//        CGContextStrokePath(context);
//        i += 1;
//    }
    
//    [self.recordPointArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        CGPoint point = CGPointFromString(obj);
//        NSLog(@"%@",obj);
//        CGContextMoveToPoint(context, point.x, point.y);
//        CGContextAddLineToPoint(context, point.y, point.y);
//        CGContextStrokePath(context);
//    }];
}

#pragma mark - 触摸方法

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    UITouch *touch = [[event allTouches] anyObject];
    NSMutableArray *points = [NSMutableArray new];
    [points addObject:NSStringFromCGPoint([touch locationInView:self])];
    if (self.recordPointArray.count == 0) {
        [self.recoveryPointArray removeAllObjects];
    }
    [self.recordPointArray addObject:points];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    UITouch *touch = [[event allTouches] anyObject];
    if (touch.force > 0) {
        self.lineWidth *= touch.force;
    }
    NSMutableArray *points = [self.recordPointArray lastObject];
    [points addObject:NSStringFromCGPoint([touch locationInView:self])];
    [self setNeedsDisplay];
}

/***  撤销 ***/
- (void)revoke {
    if (self.recordPointArray.count == 0) {
        return;
    }
    [self.recoveryPointArray addObject:self.recordPointArray.lastObject];
    [self.recordPointArray removeLastObject];
    [self setNeedsDisplay];
}

- (void)revokeAll {
    if (self.recordPointArray.count == 0) {
        return;
    }
    for (NSString *strPoint in self.recordPointArray) {
        [self.recoveryPointArray insertObject:strPoint atIndex:0];
    }
    [self.recordPointArray removeAllObjects];
    [self setNeedsDisplay];
}

/***  恢复 ***/
- (void)recovery {
    if (self.recoveryPointArray.count == 0) {
        return;
    }
    [self.recordPointArray addObject:self.recoveryPointArray.lastObject];
    [self.recoveryPointArray removeLastObject];
    [self setNeedsDisplay];
}

- (void)recoveryAll {
    if (self.recoveryPointArray.count == 0) {
        return;
    }
    for (NSString *strPoint in self.recoveryPointArray) {
        [self.recordPointArray addObject:strPoint];
    }
    [self.recoveryPointArray removeAllObjects];
    [self setNeedsDisplay];
}

- (UIImage *)screenshot {
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(self.frame.size.width, self.frame.size.height), NO, [[UIScreen mainScreen] scale]);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

#pragma mark - set/get

- (NSMutableArray *)recordPointArray {
    if (!_recordPointArray) {
        _recordPointArray = [NSMutableArray new];
    }
    return _recordPointArray;
}

- (NSMutableArray *)recoveryPointArray {
    if (!_recoveryPointArray) {
        _recoveryPointArray = [NSMutableArray new];
    }
    return _recoveryPointArray;
}

@end
