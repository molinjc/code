//
//  PointView.m


#import "PointView.h"

@implementation PointView
/**
 *  实现重写的初始化方法
 *
 *  @param frame 自身的坐标及大小
 *  @param color 背景颜色
 *
 *  @return 返回创建的圆点视图对象
 */
-(instancetype)initWithFrame:(CGRect)frame andColor:(UIColor *)color{
    if (self=[super initWithFrame:frame]) {
        self.backgroundColor=color;//设置背景颜色
        self.layer.cornerRadius=self.frame.size.height/2;//设置圆角，值为半径时，就为圆
    }
    return self;
}
@end
