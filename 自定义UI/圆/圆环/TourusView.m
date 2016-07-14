//
//  TourusView.m


#import "TourusView.h"

@implementation TourusView
/**
 *  实现重写的初始化方法
 *
 *  @param frame 自身子图的坐标及大小
 *  @param color 边框颜色
 *
 *  @return 返回创建的圆环视图对象
 */
-(instancetype)initWithFrame:(CGRect)frame andColor:(UIColor *)color{
    if (self=[super initWithFrame:frame]) {
        self.layer.borderColor=color.CGColor;//设置边框的颜色
        self.layer.borderWidth=4;//设置边框的宽度
        self.layer.cornerRadius=self.frame.size.height/2;//设置为圆
    }
    return self;
}
/**
 *  实现旋转方法（动画）
 *
 */
-(void)rotationAction{
    [UIView animateWithDuration:0.3 animations:^{//0.5秒时间完成动画
        self.transform=CGAffineTransformRotate(self.transform, M_1_PI);//以当前的状态继续完成动画
    }];
}
@end
