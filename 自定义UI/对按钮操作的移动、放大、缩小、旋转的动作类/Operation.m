//
//  Operation.m
//  实现动作的方法
//  根据按钮的tag值修改switch下的数值
//


#import "Operation.h"

@implementation Operation
/**
 *  移动的实现方法
 *
 *  @param sender 按钮对象
 *  @param view   视图对象
 */
-(void)movement:(UIButton *)sender AndView:(UIView *)view{
    CGRect frame=view.frame;//获取视图的位置
    switch (sender.tag) {//按照按钮的tag值进行移动方向的选择
        case 101://向左移动
            frame.origin.x-=20;//向左移动20单位
            break;
        case 102://向右移动
            frame.origin.x+=20;//向右移动20单位
            break;
        case 103://向上移动
            frame.origin.y-=20;//向上移动20单位
            break;
        case 104://向下移动
            frame.origin.y+=20;//向下移动20单位
            break;
    }
    view.frame=frame;//把移动后的位置(frame)给视图
}
/**
 *  放大和缩小的实现方法
 *
 *  @param sender 按钮对象
 *  @param view   视图对象
 */
-(void)enlargeAndReduce:(UIButton *)sender AndView:(UIView *)view{
    CGRect bounds=view.bounds;//获取视图的大小，若取frame，那么左上角是固定的，右下角变化
    switch (sender.tag) {//按照按钮的tag值进行放大缩小的选择
        case 105://放大
            bounds.size.width+=20;//宽加大20单位
            bounds.size.height+=20;//高加大20单位
            break;
        case 106://缩小
            bounds.size.width-=20;//宽减小20单位
            bounds.size.height-=20;//高减小20单位
            break;
    }
    /**
     *  加动画效果
     */
    [UIView beginAnimations:nil context:nil];//动画开始
    [UIView setAnimationDelay:0.2];//设置动画持续时间
    view.bounds=bounds;//把放大或缩小后的大小(bounds)给视图
    [UIView commitAnimations];//提交动画
}
/**
 *  旋转的实现方法
 *
 *  @param sender 按钮对象
 *  @param view   视图对象
 */
-(void)whirl:(UIButton *)sender AndView:(UIView *)view{
    CGFloat angle = 0.0;//定义一个OC的浮点值的基本类型
    switch (sender.tag) {//按照按钮的tag值进行旋转方向的选择
        case 107://逆时针方向旋转
            angle =-M_PI_2;//旋转角度90°，加上-就会反方向旋转
            break;
        case 108://顺时针方向旋转
            angle =M_PI_2;//旋转角度90°
    }
    view.transform = CGAffineTransformRotate(view.transform, angle);//CGAffineTransformRotate是旋转函数，
}
@end
