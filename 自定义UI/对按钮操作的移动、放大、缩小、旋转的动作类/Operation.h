//
//  Operation.h
//  对按钮操作的移动、放大、缩小、旋转的动作类
//  在调用该类时，要使用action-target模式
//


#import <UIKit/UIKit.h>

@interface Operation : UIView
-(void)movement:(UIButton *)sender AndView:(UIView *)view;//移动方法
-(void)enlargeAndReduce:(UIButton *)sender AndView:(UIView *)view;//放大和缩小方法
-(void)whirl:(UIButton *)sender AndView:(UIView *)view;//旋转方法
@end
