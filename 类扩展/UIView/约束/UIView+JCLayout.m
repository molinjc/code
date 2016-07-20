//
//  UIView+JCLayout.m
//  JCAutoLayoutTest
//
//  Created by 林建川 on 16/7/19.
//  Copyright © 2016年 molin. All rights reserved.
//

#import "UIView+JCLayout.h"

/**
 *  判断有没设置translatesAutoresizingMaskIntoConstraints，YES是没有设置，就把它设置为NO
 */
#define ENOUGHCONSTRAINTS if (self.translatesAutoresizingMaskIntoConstraints) {\
self.translatesAutoresizingMaskIntoConstraints = NO;\
}

@implementation UIView (JCLayout)

#pragma mark - 参照父视图属性

/**
 *  left，相当于x，参照俯视图的NSLayoutAttributeLeft
 */
- (UIView *(^)(CGFloat layoutLeft))layoutLeft {
    return ^(CGFloat layoutLeft) {
        ENOUGHCONSTRAINTS
        [self addToSuperviewConstraintWithAttribute:NSLayoutAttributeLeft constant:layoutLeft multiplier:1.0f];
        return self;
    };
}

/**
 *  right，与俯视图右边的间距，参照俯视图的NSLayoutAttributeRight
 */
- (UIView *(^)(CGFloat layoutRight))layoutRight {
    return ^(CGFloat layoutRight) {
        ENOUGHCONSTRAINTS
        [self addToSuperviewConstraintWithAttribute:NSLayoutAttributeRight constant:-layoutRight multiplier:1.0f];
        return self;
    };
}

/**
 *  top，相当于y，参照俯视图的NSLayoutAttributeTop
 */
- (UIView *(^)(CGFloat layoutTop))layoutTop {
    return ^(CGFloat layoutTop) {
        ENOUGHCONSTRAINTS
        [self addToSuperviewConstraintWithAttribute:NSLayoutAttributeTop constant:layoutTop multiplier:1.0f];
        return self;
    };
}

/**
 *  bottom，与俯视图底边的间距，参照俯视图的NSLayoutAttributeBottom
 */
- (UIView *(^)(CGFloat layoutBottom))layoutBottom {
    return ^(CGFloat layoutBottom) {
        ENOUGHCONSTRAINTS
        [self addToSuperviewConstraintWithAttribute:NSLayoutAttributeBottom constant:-layoutBottom multiplier:1.0f];
        return self;
    };
}

/**
 *  Width， 无参照物，设置自身的宽，NSLayoutAttributeWidth
 */
- (UIView *(^)(CGFloat layoutWidth))layoutWidth {
    return ^(CGFloat layoutWidth) {
        ENOUGHCONSTRAINTS
        [self addToSelfConstraintWithAttribute:NSLayoutAttributeWidth constant:layoutWidth multiplier:1.0f];
        return self;
    };
}

/**
 *  height，无参照物，设置自身的高，NSLayoutAttributeHeight
 */
- (UIView *(^)(CGFloat layoutHeight))layoutHeight {
    return ^(CGFloat layoutHeight) {
        ENOUGHCONSTRAINTS
        [self addToSelfConstraintWithAttribute:NSLayoutAttributeHeight constant:layoutHeight multiplier:1.0f];
        return self;
    };
}

/**
 *  CenterX，参照父视图的CenterX设置自身的CenterX，NSLayoutAttributeCenterX
 */
- (UIView *(^)(CGFloat layoutCenterX))layoutCenterX {
    return ^(CGFloat layoutCenterX) {
        ENOUGHCONSTRAINTS
        [self addToSuperviewConstraintWithAttribute:NSLayoutAttributeCenterX constant:layoutCenterX multiplier:1.0f];
        return self;
    };
}

/**
 *  CenterY，参照父视图的CenterY设置自身的CenterY，NSLayoutAttributeCenterY
 */
- (UIView *(^)(CGFloat layoutCenterY))layoutCenterY {
    return ^(CGFloat layoutCenterY) {
        ENOUGHCONSTRAINTS
        [self addToSuperviewConstraintWithAttribute:NSLayoutAttributeCenterY constant:layoutCenterY multiplier:1.0f];
        return self;
    };
}

#pragma mark - 参照父视图的属性，是父视图属性的multiplier倍

/**
 *  left，相当于x，参照俯视图的NSLayoutAttributeLeft的multiplier倍
 */
- (UIView *(^)(CGFloat multiplier, CGFloat layoutLeft))layoutLeftWithMultiplier {
    return ^(CGFloat multiplier, CGFloat layoutLeft) {
        ENOUGHCONSTRAINTS
        [self addToSuperviewConstraintWithAttribute:NSLayoutAttributeLeft constant:layoutLeft multiplier:multiplier];
        return self;
    };
}

/**
 *  right，与俯视图右边的间距，参照俯视图的NSLayoutAttributeRight的multiplier倍
 */
- (UIView *(^)(CGFloat multiplier, CGFloat layoutRight))layoutRightWithMultiplier {
    return ^(CGFloat multiplier, CGFloat layoutRight) {
        ENOUGHCONSTRAINTS
        [self addToSuperviewConstraintWithAttribute:NSLayoutAttributeRight constant:-layoutRight multiplier:multiplier];
        return self;
    };
}

/**
 *  top，相当于y，参照俯视图的NSLayoutAttributeTop的multiplier倍
 */
- (UIView *(^)(CGFloat multiplier, CGFloat layoutTop))layoutTopWithMultiplier {
    return ^(CGFloat multiplier, CGFloat layoutTop) {
        ENOUGHCONSTRAINTS
        [self addToSuperviewConstraintWithAttribute:NSLayoutAttributeTop constant:layoutTop multiplier:multiplier];
        return self;
    };
}

/**
 *  bottom，与俯视图底边的间距，参照俯视图的NSLayoutAttributeBottom的multiplier倍
 */
- (UIView *(^)(CGFloat multiplier, CGFloat layoutBottom))layoutBottomWithMultiplier {
    return ^(CGFloat multiplier, CGFloat layoutBottom) {
        ENOUGHCONSTRAINTS
        [self addToSuperviewConstraintWithAttribute:NSLayoutAttributeBottom constant:-layoutBottom multiplier:multiplier];
        return self;
    };
}

/**
 *  Width， 无参照物，设置自身的宽，NSLayoutAttributeWidth的multiplier倍
 */
- (UIView *(^)(CGFloat multiplier, CGFloat layoutWidth))layoutWidthWithMultiplier {
    return ^(CGFloat multiplier, CGFloat layoutWidth) {
        ENOUGHCONSTRAINTS
        [self addToSelfConstraintWithAttribute:NSLayoutAttributeWidth constant:layoutWidth multiplier:multiplier];
        return self;
    };
}

/**
 *  height，无参照物，设置自身的高，NSLayoutAttributeHeight的multiplier倍
 */
- (UIView *(^)(CGFloat multiplier, CGFloat layoutHeight))layoutHeightWithMultiplier {
    return ^(CGFloat multiplier, CGFloat layoutHeight) {
        ENOUGHCONSTRAINTS
        [self addToSelfConstraintWithAttribute:NSLayoutAttributeHeight constant:layoutHeight multiplier:multiplier];
        return self;
    };
}

/**
 *  CenterX，参照父视图的CenterX设置自身的CenterX，NSLayoutAttributeCenterX的multiplier倍
 */
- (UIView *(^)(CGFloat multiplier, CGFloat layoutCenterX))layoutCenterXWithMultiplier {
    return ^(CGFloat multiplier, CGFloat layoutCenterX) {
        ENOUGHCONSTRAINTS
        [self addToSuperviewConstraintWithAttribute:NSLayoutAttributeCenterX constant:layoutCenterX multiplier:multiplier];
        return self;
    };
}

/**
 *  CenterY，参照父视图的CenterY设置自身的CenterY，NSLayoutAttributeCenterY的multiplier倍
 */
- (UIView *(^)(CGFloat multiplier, CGFloat layoutCenterY))layoutCenterYWithMultiplier {
    return ^(CGFloat multiplier, CGFloat layoutCenterY) {
        ENOUGHCONSTRAINTS
        [self addToSuperviewConstraintWithAttribute:NSLayoutAttributeCenterY constant:layoutCenterY multiplier:multiplier];
        return self;
    };
}

#pragma mark - 参照同层级视图相同属性

/**
 *  参照同层级view的left
 */
- (UIView *(^)(UIView *sameLayerView, CGFloat left))layoutSameLayerLeft {
    return ^(UIView *sameLayerView, CGFloat left) {
        ENOUGHCONSTRAINTS
        [self addToSuperviewConstraintWithSameLayerView:sameLayerView attribute:NSLayoutAttributeLeft constant:left multiplier:1.0f];
        return self;
    };
}

/**
 *  参照同层级view的right
 */
- (UIView *(^)(UIView *sameLayerView, CGFloat right))layoutSameLayerRight {
    return ^(UIView *sameLayerView, CGFloat right) {
        ENOUGHCONSTRAINTS
        [self addToSuperviewConstraintWithSameLayerView:sameLayerView attribute:NSLayoutAttributeRight constant:right multiplier:1.0f];
        return self;
    };
}

/**
 *  参照同层级view的top
 */
- (UIView *(^)(UIView *sameLayerView, CGFloat top))layoutSameLayerTop {
    return ^(UIView *sameLayerView, CGFloat top) {
        ENOUGHCONSTRAINTS
        [self addToSuperviewConstraintWithSameLayerView:sameLayerView attribute:NSLayoutAttributeTop constant:top multiplier:1.0f];
        return self;
    };
}

/**
 *  参照同层级view的bottom
 */
- (UIView *(^)(UIView *sameLayerView, CGFloat bottom))layoutSameLayerBottom {
    return ^(UIView *sameLayerView, CGFloat bottom) {
        ENOUGHCONSTRAINTS
        [self addToSuperviewConstraintWithSameLayerView:sameLayerView attribute:NSLayoutAttributeBottom constant:bottom multiplier:1.0f];
        return self;
    };
}

/**
 *  参照同层级view的centerX
 */
- (UIView *(^)(UIView *sameLayerView, CGFloat centerX))layoutSameLayerCenterX {
    return ^(UIView *sameLayerView, CGFloat centerX) {
        ENOUGHCONSTRAINTS
        [self addToSuperviewConstraintWithSameLayerView:sameLayerView attribute:NSLayoutAttributeCenterX constant:centerX multiplier:1.0f];
        return self;
    };
}

/**
 *  参照同层级view的centerY
 */
- (UIView *(^)(UIView *sameLayerView, CGFloat centerY))layoutSameLayerCenterY {
    return ^(UIView *sameLayerView, CGFloat centerY) {
        ENOUGHCONSTRAINTS
        [self addToSuperviewConstraintWithSameLayerView:sameLayerView attribute:NSLayoutAttributeCenterY constant:centerY multiplier:1.0f];
        return self;
    };
}

#pragma mark - 参照同层级视图相同属性，是同层级视图的multiplier倍

/**
 *  参照同层级view的left
 */
- (UIView *(^)(UIView *sameLayerView, CGFloat multiplier, CGFloat left))layoutSameLayerLeftWithMultiplier {
    return ^(UIView *sameLayerView, CGFloat multiplier, CGFloat left) {
        ENOUGHCONSTRAINTS
        [self addToSuperviewConstraintWithSameLayerView:sameLayerView attribute:NSLayoutAttributeLeft constant:left multiplier:multiplier];
        return self;
    };
}

/**
 *  参照同层级view的right
 */
- (UIView *(^)(UIView *sameLayerView, CGFloat multiplier, CGFloat right))layoutSameLayerRightWithMultiplier {
    return ^(UIView *sameLayerView, CGFloat multiplier, CGFloat right) {
        ENOUGHCONSTRAINTS
        [self addToSuperviewConstraintWithSameLayerView:sameLayerView attribute:NSLayoutAttributeRight constant:right multiplier:multiplier];
        return self;
    };
}

/**
 *  参照同层级view的top
 */
- (UIView *(^)(UIView *sameLayerView, CGFloat multiplier, CGFloat top))layoutSameLayerTopWithMultiplier {
    return ^(UIView *sameLayerView, CGFloat multiplier, CGFloat top) {
        ENOUGHCONSTRAINTS
        [self addToSuperviewConstraintWithSameLayerView:sameLayerView attribute:NSLayoutAttributeTop constant:top multiplier:multiplier];
        return self;
    };
}

/**
 *  参照同层级view的bottom
 */
- (UIView *(^)(UIView *sameLayerView, CGFloat multiplier, CGFloat bottom))layoutSameLayerBottomWithMultiplier {
    return ^(UIView *sameLayerView, CGFloat multiplier, CGFloat bottom) {
        ENOUGHCONSTRAINTS
        [self addToSuperviewConstraintWithSameLayerView:sameLayerView attribute:NSLayoutAttributeBottom constant:bottom multiplier:multiplier];
        return self;
    };
}

/**
 *  参照同层级view的centerX
 */
- (UIView *(^)(UIView *sameLayerView, CGFloat multiplier, CGFloat centerX))layoutSameLayerCenterXWithMultiplier {
    return ^(UIView *sameLayerView, CGFloat multiplier, CGFloat centerX) {
        ENOUGHCONSTRAINTS
        [self addToSuperviewConstraintWithSameLayerView:sameLayerView attribute:NSLayoutAttributeCenterX constant:centerX multiplier:multiplier];
        return self;
    };
}

/**
 *  参照同层级view的centerY
 */
- (UIView *(^)(UIView *sameLayerView, CGFloat multiplier, CGFloat centerY))layoutSameLayerCenterYWithMultiplier {
    return ^(UIView *sameLayerView, CGFloat multiplier, CGFloat centerY) {
        ENOUGHCONSTRAINTS
        [self addToSuperviewConstraintWithSameLayerView:sameLayerView attribute:NSLayoutAttributeCenterY constant:centerY multiplier:multiplier];
        return self;
    };
}

#pragma mark - 参照同层级视图相反属性

/**
 *  参照同层级view的left，在同层级view的左边（left），也就是同层级view在self的右边（right）
 */
- (UIView *(^)(UIView *sameLayerView, CGFloat constant))layoutAtSameLayerLeft {
    return ^(UIView *sameLayerView, CGFloat constant) {
        ENOUGHCONSTRAINTS
        [self addToSuperviewConstraintWithSameLayerView:sameLayerView attribute1:NSLayoutAttributeRight attribute2:NSLayoutAttributeLeft constant:constant multiplier:1.0f];
        return self;
    };
}

/**
 *  参照同层级view的right，在同层级view的右边（right），也就是同层级view在self的左边（left）
 */
- (UIView *(^)(UIView *sameLayerView, CGFloat constant))layoutAtSameLayerRight {
    return ^(UIView *sameLayerView, CGFloat constant) {
        ENOUGHCONSTRAINTS
        [self addToSuperviewConstraintWithSameLayerView:sameLayerView attribute1:NSLayoutAttributeLeft attribute2:NSLayoutAttributeRight constant:constant multiplier:1.0f];
        return self;
    };
}

/**
 *  参照同层级view的top，在同层级view的顶边（top），也就是同层级view在self的底边（bottom）
 */
- (UIView *(^)(UIView *sameLayerView, CGFloat constant))layoutAtSameLayerTop {
    return ^(UIView *sameLayerView, CGFloat constant) {
        ENOUGHCONSTRAINTS
        [self addToSuperviewConstraintWithSameLayerView:sameLayerView attribute1:NSLayoutAttributeBottom attribute2:NSLayoutAttributeTop constant:constant multiplier:1.0f];
        return self;
    };
}

/**
 *  参照同层级view的bottom，在同层级view的底边（bottom），也就是同层级view在self的顶边（top）
 */
- (UIView *(^)(UIView *sameLayerView, CGFloat constant))layoutAtSameLayerBottom {
    return ^(UIView *sameLayerView, CGFloat constant) {
        ENOUGHCONSTRAINTS
        [self addToSuperviewConstraintWithSameLayerView:sameLayerView attribute1:NSLayoutAttributeTop attribute2:NSLayoutAttributeBottom constant:constant multiplier:1.0f];
        return self;
    };
}

#pragma mark - 参照同层级视图相反属性，是同层级视图相反属性的multiplier倍

/**
 *  参照同层级view的left，在同层级view的左边（left），也就是同层级view在self的右边（right）
 */
- (UIView *(^)(UIView *sameLayerView, CGFloat multiplier, CGFloat constant))layoutAtSameLayerLeftWithMultiplier {
    return ^(UIView *sameLayerView, CGFloat multiplier, CGFloat constant) {
        ENOUGHCONSTRAINTS
        [self addToSuperviewConstraintWithSameLayerView:sameLayerView attribute1:NSLayoutAttributeRight attribute2:NSLayoutAttributeLeft constant:constant multiplier:1.0f];
        return self;
    };
}

/**
 *  参照同层级view的right，在同层级view的右边（right），也就是同层级view在self的左边（left）
 */
- (UIView *(^)(UIView *sameLayerView, CGFloat multiplier, CGFloat constant))layoutAtSameLayerRightWithMultiplier {
    return ^(UIView *sameLayerView, CGFloat multiplier, CGFloat constant) {
        ENOUGHCONSTRAINTS
        [self addToSuperviewConstraintWithSameLayerView:sameLayerView attribute1:NSLayoutAttributeLeft attribute2:NSLayoutAttributeRight constant:constant multiplier:1.0f];
        return self;
    };
}

/**
 *  参照同层级view的top，在同层级view的顶边（top），也就是同层级view在self的底边（bottom）
 */
- (UIView *(^)(UIView *sameLayerView, CGFloat multiplier, CGFloat constant))layoutAtSameLayerTopWithMultiplier {
    return ^(UIView *sameLayerView, CGFloat multiplier, CGFloat constant) {
        ENOUGHCONSTRAINTS
        [self addToSuperviewConstraintWithSameLayerView:sameLayerView attribute1:NSLayoutAttributeBottom attribute2:NSLayoutAttributeTop constant:constant multiplier:multiplier];
        return self;
    };
}

/**
 *  参照同层级view的bottom，在同层级view的底边（bottom），也就是同层级view在self的顶边（top）
 */
- (UIView *(^)(UIView *sameLayerView, CGFloat multiplier, CGFloat constant))layoutAtSameLayerBottomWithMultiplier {
    return ^(UIView *sameLayerView, CGFloat multiplier, CGFloat constant) {
        ENOUGHCONSTRAINTS
        [self addToSuperviewConstraintWithSameLayerView:sameLayerView attribute1:NSLayoutAttributeTop attribute2:NSLayoutAttributeBottom constant:constant multiplier:multiplier];
        return self;
    };
}

#pragma mark - NSLayoutConstraint

/**
 *  参照物为同层级view,
 *
 *  @param view       同层级view
 *  @param attribute1 约束条件1
 *  @param attribute2 约束条件2
 *  @param constant   常数
 */
- (void)addToSuperviewConstraintWithSameLayerView:(UIView *)view attribute1:(NSLayoutAttribute)attribute1 attribute2:(NSLayoutAttribute)attribute2 constant:(CGFloat)constant multiplier:(CGFloat)multiplier {
    NSLayoutConstraint *layoutConstraint = [NSLayoutConstraint constraintWithItem:self attribute:attribute1 relatedBy:NSLayoutRelationEqual toItem:view attribute:attribute2 multiplier:multiplier constant:constant];
    [self.superview addConstraint:layoutConstraint];
}

/**
 *  参照物为同层级view，该约束被添加到父视图
 *
 *  @param view      同层级view
 *  @param attribute 约束条件
 *  @param constant  常数
 */
- (void)addToSuperviewConstraintWithSameLayerView:(UIView *)view attribute:(NSLayoutAttribute)attribute constant:(CGFloat)constant multiplier:(CGFloat)multiplier {
    NSLayoutConstraint *layoutConstraint = [NSLayoutConstraint constraintWithItem:self attribute:attribute relatedBy:NSLayoutRelationEqual toItem:view attribute:attribute multiplier:multiplier constant:constant];
    [self.superview addConstraint:layoutConstraint];
}

/**
 *  参照物为父视图，该约束被添加到父视图
 *
 *  @param attribute 约束条件
 *  @param constant  常数
 */
- (void)addToSuperviewConstraintWithAttribute:(NSLayoutAttribute)attribute constant:(CGFloat)constant multiplier:(CGFloat)multiplier {
    NSLayoutConstraint *layoutConstraint = [NSLayoutConstraint constraintWithItem:self attribute:attribute relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:attribute multiplier:multiplier constant:constant];
    [self.superview addConstraint:layoutConstraint];
}

/**
 *  参照物无，该约束被添加到自身
 *
 *  @param attribute 约束条件
 *  @param constant  常熟
 */
- (void)addToSelfConstraintWithAttribute:(NSLayoutAttribute)attribute constant:(CGFloat)constant multiplier:(CGFloat)multiplier {
    NSLayoutConstraint *layoutConstraint = [NSLayoutConstraint constraintWithItem:self attribute:attribute relatedBy:NSLayoutRelationEqual toItem:nil attribute:attribute multiplier:multiplier constant:constant];
    [self addConstraint:layoutConstraint];
}

@end