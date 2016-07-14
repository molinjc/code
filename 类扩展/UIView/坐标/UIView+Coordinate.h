//
//  UIView+Coordinate.h
//  JCChat_XMPP
//
//  Created by molin on 15/11/26.
//  Copyright © 2015年 molin. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SCREENBOUNDS [UIScreen mainScreen].bounds
#define SCREENSIZE   [UIScreen  mainScreen].bounds.size

typedef NS_ENUM(NSInteger,UIViewWithSuperPosition){
    UIViewWithSuperPositionLeft = 1,                // 居左
    UIViewWithSuperPositionLeftTop,                 // 居左上
    UIViewWithSuperPositionLeftBottom,              // 居左下
    UIViewWithSuperPositionRight,                   // 居右
    UIViewWithSuperPositionRightTop,                // 居右上
    UIViewWithSuperPositionRightBottom,             // 居右下
    UIViewWithSuperPositionTop,                     // 居上
    UIViewWithSuperPositionBottom,                  // 居下
    UIViewWithSuperPositionCenter,                  // 居中
    UIViewWithSuperPositionLeftCenter,              // 居左中
    UIViewWithSuperPositionRightCenter,             // 居右中
    UIViewWithSuperPositionTopCenter,               // 居上中
    UIViewWithSuperPositionBottonCenter             // 居下中
};


@interface UIView (Coordinate)

@property (nonatomic, assign) CGFloat x;             // frame.origin.x
@property (nonatomic, assign) CGFloat y;             // frame.origin.y
@property (nonatomic, assign) CGFloat width;         // frame.size.width
@property (nonatomic, assign) CGFloat height;        // frame.size.height
@property (nonatomic, assign) CGPoint origin;        // frame.origin
@property (nonatomic, assign) CGSize  size;          // frame.size
@property (nonatomic, assign) CGFloat centerX;       // center.x
@property (nonatomic, assign) CGFloat centerY;       // center.y
@property (nonatomic, assign) CGFloat right;         // frame.origin.x + frame.size.width
@property (nonatomic, assign) CGFloat bottom;        // frame.origin.y + frame.size.height

@property (nonatomic, assign) CGFloat leftSpacing;   // 左间距
@property (nonatomic, assign) CGFloat rightSpacing;  // 右间距
@property (nonatomic, assign) CGFloat topSpacing;    // 上间距
@property (nonatomic, assign) CGFloat bottomSpacing; // 下间距

@property (nonatomic, copy, readonly) void (^edgeInsets)(UIEdgeInsets edge);  // 上左下右，设置边距

@property (nonatomic, copy, readonly) void (^edgeEqualTo)(UIView *view);  // UIEdgeInsets与另一个View一样

// 左边靠某个View（同一级的View）间隔value长 
@property (nonatomic, copy, readonly) void (^leftSpacingByView)(UIView *view, CGFloat value);

// 右边靠某个View（同一级的View）间隔value长
@property (nonatomic, copy, readonly) void (^rightSpacingByView)(UIView *view, CGFloat value);

// 上边靠某个View（同一级的View）间隔value长
@property (nonatomic, copy, readonly) void (^topSpacingByView)(UIView *view, CGFloat value);

// 下边靠某个View（同一级的View）间隔value长
@property (nonatomic, copy, readonly) void (^bottomSpacingByView)(UIView *view, CGFloat value);

// 参考某一个view进行水平居中；value = 0，centerX一致；value < 0，在view的左边；value > 0，在view的右边
@property (nonatomic, copy, readonly) void (^xCenterByView)(UIView *view, CGFloat value);

// 参考某一个view进行垂直居中；value = 0，centerY一致；value < 0，在view的上边；value > 0，在view的下边
@property (nonatomic, copy, readonly) void (^yCenterByView)(UIView *view, CGFloat value);

// 参考某一个view进行居中；value = 0，center一致；value < 0，在view的左上边；value > 0，在view的右下边
@property (nonatomic, copy, readonly) void (^centerByView)(UIView *view, CGFloat value);

// 参考某一个view的左边线进行靠左；value = 0，x一致；value < 0，在view的左；value > 0，在view的右边
@property (nonatomic, copy, readonly) void (^leftSpacingEqulTo)(UIView *view, CGFloat value);

// 参考某一个view的右边线进行靠左；value = 0，右边线一致(x+width)；value < 0，在view的右边；value > 0，在view的左边
@property (nonatomic, copy, readonly) void (^rightSpacingEqulTo)(UIView *view, CGFloat value);

//参考某一个view的上边线进行靠左；value = 0，y一致；value < 0，在view的上边；value > 0，在view的下边
@property (nonatomic, copy, readonly) void (^topSpacingEqulTo)(UIView *view, CGFloat value);

// 参考某一个view的下边线进行靠左；value = 0，下边线一致（y+height）；value < 0，在view的下边；value > 0，在view的上边
@property (nonatomic, copy, readonly) void (^bottomSpacingEqulTo)(UIView *view, CGFloat value);

// 参考某一个view的width，在这基础上加上value
@property (nonatomic, copy, readonly) void (^widthEqulTo)(UIView *view, CGFloat value);

// 参考某一个view的height，在这基础上加上value
@property (nonatomic, copy, readonly) void (^heightEqulTo)(UIView *view, CGFloat value);

/**
 *  UILabel计算文本高度
 *
 *  @return 高度
 */
- (void)setLabelHeight;

/**
 *  添加View，在代码块里设置坐标
 *
 *  @param view   要添加的View
 *  @param layout 代码块
 */
- (void)addSubview:(UIView *)view setLayout:(void (^)())layout;

/**
 *  添加View和显示位置
 *
 *  @param view 子视图
 *  @param position 位置（枚举）
 */
- (void)addSubview:(UIView *)view position:(UIViewWithSuperPosition)position;

/**
 *  在尺寸里显示的坐标换算成屏幕的坐标
 *
 *  @param size  在别的尺寸
 *  @param frame 在别的尺寸里显示的坐标
 */
- (void)inSize:(CGSize)size showFrame:(CGRect)frame;

/**
 *  在尺寸里显示的点换算成屏幕的点
 *
 *  @param size   在别的尺寸
 *  @param origin 在别的尺寸里显示的点
 */
- (void)inSize:(CGSize)size showOrigin:(CGPoint)origin;

/**
 *  在尺寸里显示的大小换算成屏幕的大小
 *
 *  @param size  在别的尺寸
 *  @param frame 在别的尺寸里显示的大小
 */
- (void)inSize:(CGSize)size showSize:(CGSize)showSize;

/**
 *  显示在某个View的左边
 *
 *  @param view    某个视图
 *  @param spacing 间距
 */
- (void)leftForView:(UIView *)view spacing:(CGFloat)spacing;

/**
 *  显示在某个View的右边
 *
 *  @param view    某个视图
 *  @param spacing 间距
 */
- (void)rightForView:(UIView *)view spacing:(CGFloat)spacing;

/**
 *  显示在某个View的上边
 *
 *  @param view    某个视图
 *  @param spacing 间距
 */
- (void)topForView:(UIView *)view spacing:(CGFloat)spacing;

/**
 *  显示在某个View的下边
 *
 *  @param view    某个视图
 *  @param spacing 间距
 */
- (void)bottomForView:(UIView *)view spacing:(CGFloat)spacing;

@end