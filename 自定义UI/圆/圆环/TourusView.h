//
//  TourusView.h

/**
 *   圆环视图
 */
#import <UIKit/UIKit.h>

@interface TourusView : UIView
-(instancetype)initWithFrame:(CGRect)frame andColor:(UIColor *)color;//声明重写控件的初始化方法
-(void)rotationAction;//创建旋转方法声明
@end
