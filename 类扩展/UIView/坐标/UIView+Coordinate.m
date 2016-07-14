//
//  UIView+Coordinate.m
//  JCChat_XMPP
//
//  Created by molin on 15/11/26.
//  Copyright © 2015年 molin. All rights reserved.
//

#import "UIView+Coordinate.h"

@implementation UIView (Coordinate)

// @dynamic告诉编译器,属性的setter与getter方法由用户自己实现，不自动生成
@dynamic x;
@dynamic y;
@dynamic width;
@dynamic height;
@dynamic origin;
@dynamic size;
@dynamic centerX;
@dynamic centerY;
@dynamic right;
@dynamic bottom;
@dynamic edgeInsets;

/**
 *  UILabel计算文本高度
 *
 *  @return 高度
 */
- (void)setLabelHeight {
    if ([self isKindOfClass:[UILabel class]]) {
        UILabel *label = (UILabel *)self;
        self.height = [label.text boundingRectWithSize:CGSizeMake(label.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:label.font} context:nil].size.height;
    }
}

/**
 *  添加View，在代码块里设置坐标
 *
 *  @param view   要添加的View
 *  @param layout 代码块
 */
- (void)addSubview:(UIView *)view setLayout:(void (^)())layout {
    [self addSubview:view];
    layout();
}

/**
 *  添加View和显示位置
 *
 *  @param view 子视图
 *  @param position 位置（枚举）
 */
- (void)addSubview:(UIView *)view position:(UIViewWithSuperPosition)position {
    switch (position) {
        case UIViewWithSuperPositionLeft: {
            view.x = 0;
            break;
        }
        case UIViewWithSuperPositionLeftTop: {
            view.origin = CGPointMake(0, 0);
            break;
        }
        case UIViewWithSuperPositionLeftBottom: {
            view.origin = CGPointMake(0, self.height - view.height);
            break;
        }
        case UIViewWithSuperPositionRight: {
            view.x = self.width - view.width;
            break;
        }
        case UIViewWithSuperPositionRightTop: {
            view.origin = CGPointMake(self.width - view.width, 0);
            break;
        }
        case UIViewWithSuperPositionRightBottom: {
            view.origin = CGPointMake(self.width - view.width, self.height - view.height);
            break;
        }
        case UIViewWithSuperPositionTop: {
            view.y = 0;
            break;
        }
        case UIViewWithSuperPositionBottom: {
            view.y = self.height - view.height;
            break;
        }
        case UIViewWithSuperPositionCenter: {
            view.center = self.center;
            break;
        }
        case UIViewWithSuperPositionLeftCenter: {
            view.x = 0;
            view.centerY = self.centerY;
            break;
        }
        case UIViewWithSuperPositionRightCenter: {
            view.x = self.width - view.width;
            view.centerY = self.centerY;
            break;
        }
        case UIViewWithSuperPositionTopCenter: {
            view.centerX = self.centerX;
            view.y = 0;
            break;
        }
        case UIViewWithSuperPositionBottonCenter: {
            view.centerX = self.centerX;
            view.y = self.height - view.height;
        }
    }
    [self addSubview:view];
}

#pragma mark - 给定大小比例来确定View的frame

/**
 *  在尺寸里显示的坐标换算成屏幕的坐标
 *
 *  @param size  在别的尺寸
 *  @param frame 在别的尺寸里显示的坐标
 */
- (void)inSize:(CGSize)size showFrame:(CGRect)frame {
    CGFloat x = SCREENSIZE.width * frame.origin.x / size.width;
    CGFloat y = SCREENSIZE.height * frame.origin.y / size.height;
    CGFloat w = SCREENSIZE.width * frame.size.width / size.width;
    CGFloat h = SCREENSIZE.height * frame.size.height / size.height;
    self.frame = CGRectMake(x, y, w, h);
}

/**
 *  在尺寸里显示的点换算成屏幕的点
 *
 *  @param size   在别的尺寸
 *  @param origin 在别的尺寸里显示的点
 */
- (void)inSize:(CGSize)size showOrigin:(CGPoint)origin {
    CGFloat x = SCREENSIZE.width * origin.x / size.width;
    CGFloat y = SCREENSIZE.height * origin.y / size.height;
    self.origin = CGPointMake(x, y);
}

/**
 *  在尺寸里显示的大小换算成屏幕的大小
 *
 *  @param size  在别的尺寸
 *  @param frame 在别的尺寸里显示的大小
 */
- (void)inSize:(CGSize)size showSize:(CGSize)showSize {
    CGFloat w = SCREENSIZE.width * showSize.width / size.width;
    CGFloat h = SCREENSIZE.height * showSize.height / size.height;
    self.size = CGSizeMake(w, h);
}

#pragma mark - 根据另一个View来确定显示位置

/**
 *  显示在某个View的左边
 *
 *  @param view    某个视图
 *  @param spacing 间距
 */
- (void)leftForView:(UIView *)view spacing:(CGFloat)spacing {
    CGRect frame = self.frame;
    frame.origin.y = view.y;
    frame.origin.x = view.x - (spacing + frame.size.width);
    self.frame = frame;
}

/**
 *  显示在某个View的右边
 *
 *  @param view    某个视图
 *  @param spacing 间距
 */
- (void)rightForView:(UIView *)view spacing:(CGFloat)spacing {
    CGRect frame = self.frame;
    frame.origin.y = view.y;
    frame.origin.x = view.x + view.width + spacing;
    self.frame = frame;
}

/**
 *  显示在某个View的上边
 *
 *  @param view    某个视图
 *  @param spacing 间距
 */
- (void)topForView:(UIView *)view spacing:(CGFloat)spacing {
    CGRect frame = self.frame;
    frame.origin.x = view.x;
    frame.origin.y = view.y - (frame.size.height + spacing);
    self.frame = frame;
}

/**
 *  显示在某个View的下边
 *
 *  @param view    某个视图
 *  @param spacing 间距
 */
- (void)bottomForView:(UIView *)view spacing:(CGFloat)spacing {
    CGRect frame = self.frame;
    frame.origin.x = view.x;
    frame.origin.y = view.y + view.height + spacing;
    self.frame = frame;
}

#pragma mark - 代码块设置frame

/**
 *  上左下右，设置边距
 */
- (void (^)(UIEdgeInsets))edgeInsets {
    return ^(UIEdgeInsets edge) {
        self.leftSpacing = edge.left;
        self.rightSpacing = edge.right;
        self.topSpacing = edge.top;
        self.bottomSpacing = edge.bottom;
    };
}

/**
 *  上左下右的边距跟另一个View一样
 */
- (void (^)(UIView *view))edgeEqualTo {
    return ^(UIView *view) {
        self.leftSpacing = view.x;
        self.topSpacing = view.y;
        UIView *superView = view.superview;
        self.bottomSpacing = superView.height - view.bottom;
        self.rightSpacing = superView.width - view.right;
    };
}

/**
 *  左边靠某个View（同一级的View）间隔value长
 */
- (void (^)(UIView *view, CGFloat value))leftSpacingByView {
    return ^(UIView *view, CGFloat value) {
        self.x = view.x + view.width + value;
    };
}

/**
 *  右边靠某个View（同一级的View）间隔value长
 */
- (void (^)(UIView *view, CGFloat value))rightSpacingByView {
    return ^(UIView *view, CGFloat value) {
        self.x = view.x - value - self.width;
    };
}

/**
 *  上边靠某个View（同一级的View）间隔value长
 */
- (void (^)(UIView *view, CGFloat value))topSpacingByView {
    return ^(UIView *view, CGFloat value) {
        self.y = view.y + view.height + value;
    };
}

/**
 *  下边靠某个View（同一级的View）间隔value长
 */
- (void (^)(UIView *view, CGFloat value))bottomSpacingByView {
    return ^(UIView *view, CGFloat value) {
        self.y = view.y - value - self.height;
    };
}

/**
 *  参考某一个view进行水平居中
 *  value = 0   centerX一致
 *  value < 0   在view的左边
 *  value > 0   在view的右边
 */
- (void (^)(UIView *view, CGFloat value))xCenterByView {
    return ^(UIView *view, CGFloat value) {
        self.centerX = view.centerX + value;
    };
}

/**
 *  参考某一个view进行垂直居中
 *  value = 0   centerY一致
 *  value < 0   在view的上边
 *  value > 0   在view的下边
 */
- (void (^)(UIView *view, CGFloat value))yCenterByView {
    return ^(UIView *view, CGFloat value) {
        self.centerY = view.centerY + value;
    };
}

/**
 *  参考某一个view进行居中
 *  value = 0   center一致
 *  value < 0   在view的左上边
 *  value > 0   在view的右下边
 */
- (void (^)(UIView *view, CGFloat value))centerByView {
    return ^(UIView *view, CGFloat value) {
        self.center = CGPointMake(view.centerX + value, view.centerY + value);
    };
}

/**
 *  参考某一个view的左边线进行靠左
 *  value = 0   x一致
 *  value < 0   在view的左边
 *  value > 0   在view的右边
 */
- (void (^)(UIView *view, CGFloat value))leftSpacingEqulTo {
    return ^(UIView *view, CGFloat value) {
        self.x = view.x + value;
    };
}

/**
 *  参考某一个view的右边线进行靠左
 *  value = 0   右边线一致（x+width）
 *  value < 0   在view的右边
 *  value > 0   在view的左边
 */
- (void (^)(UIView *view, CGFloat value))rightSpacingEqulTo {
    return ^(UIView *view, CGFloat value) {
        self.x = view.superview.width - (view.rightSpacing + value) - self.width;
    };
}

/**
 *  参考某一个view的上边线进行靠左
 *  value = 0   y一致
 *  value < 0   在view的上边
 *  value > 0   在view的下边
 */
- (void (^)(UIView *view, CGFloat value))topSpacingEqulTo {
    return ^(UIView *view, CGFloat value) {
        self.y = view.y + value;;
    };
}

/**
 *  参考某一个view的下边线进行靠左
 *  value = 0   下边线一致（y+height）
 *  value < 0   在view的下边
 *  value > 0   在view的上边
 */
- (void (^)(UIView *view, CGFloat value))bottomSpacingEqulTo {
    return ^(UIView *view, CGFloat value) {
        self.y = view.superview.height - (view.bottomSpacing + value) - self.height;
    };
}

/**
 *  参考某一个view的width，在这基础上加上value
 */
- (void (^)(UIView *view, CGFloat value))widthEqulTo {
    return ^(UIView *view, CGFloat value) {
        self.width = view.width + value;
    };
}

/**
 *  参考某一个view的height，在这基础上加上value
 */
- (void (^)(UIView *view, CGFloat value))heightEqulTo {
    return ^(UIView *view, CGFloat value) {
        self.height = view.height + value;
    };
}

#pragma mark - Setters

- (void)setLeftSpacing:(CGFloat)leftSpacing {
    self.x = leftSpacing;
}

- (void)setRightSpacing:(CGFloat)rightSpacing {
    UIView *superView = self.superview;
    self.width = superView.width - rightSpacing - self.x;
}

- (void)setTopSpacing:(CGFloat)topSpacing {
    self.y = topSpacing;
}

- (void)setBottomSpacing:(CGFloat)bottomSpacing {
    UIView *superView = self.superview;
    self.height = superView.height - bottomSpacing - self.y;
}

- (void)setX:(CGFloat)x {
    CGRect rect = self.frame;
    rect.origin.x = x;
    self.frame = rect;
}

- (void)setY:(CGFloat)y {
    CGRect rect = self.frame;
    rect.origin.y = y;
    self.frame = rect;
}

- (void)setWidth:(CGFloat)width {
    CGRect rect = self.frame;
    rect.size.width = width;
    self.frame = rect;
}

- (void)setHeight:(CGFloat)height {
    CGRect rect = self.frame;
    rect.size.height = height;
    self.frame = rect;
}

- (void)setSize:(CGSize)size {
    self.width = size.width;
    self.height = size.height;
}

- (void)setOrigin:(CGPoint)origin {
    self.x = origin.x;
    self.y = origin.y;
}

- (void)setCenterX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}

- (void)setCenterY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}

- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

#pragma mark - Getters

- (CGFloat)leftSpacing {
    return self.x;
}

- (CGFloat)rightSpacing {
    UIView *superView = self.superview;
    return superView.width - self.width - self.x;
}

- (CGFloat)topSpacing {
    return self.y;
}

- (CGFloat)bottomSpacing {
    UIView *superView = self.superview;
    return superView.height - self.height - self.y;
}

- (CGFloat)x {
    return self.frame.origin.x;
}

- (CGFloat)y {
    return self.frame.origin.y;
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (CGSize)size {
    return CGSizeMake(self.width, self.height);
}

- (CGPoint)origin {
    return CGPointMake(self.x, self.y);;
}

- (CGFloat)centerX {
    return self.center.x;
}

- (CGFloat)centerY {
    return self.center.y;
}

- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}

- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}

@end