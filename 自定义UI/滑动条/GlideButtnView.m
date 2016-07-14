//
//  GlideButtnView.m
//  实现方法
//


#import "GlideButtnView.h"

@implementation GlideButtnView
/**
 *  重写初始化方法
 *
 *  @param frame              位置大小
 *  @param text               标题数组
 *  @param newBackgroundColor 按钮背景颜色
 *  @param newGlideBarColor   滑动条颜色
 *  @param newFontColor       按钮字体颜色
 *  @param newNum             按钮个数
 *
 *  @return 方法对象
 */
-(instancetype)initWithFrame:(CGRect)frame andArrayText:(NSArray *)text andBackgroundColor:(UIColor *)newBackgroundColor andGlideBarColor:(UIColor *)newGlideBarColor andFontColor:(UIColor *)newFontColor andButtonNumber:(NSInteger)newNum{
    if (self=[super initWithFrame:frame]) {
        self.num=newNum;
        self.glideBarColor=newGlideBarColor;
        self.fontColor=newFontColor;
        /**
         *  循环创建num个按钮，添加到View中
         */
        for (int i=0; i<self.num; i++) {
            UIButton *btn=[GlideButtnView creatButton:CGRectMake(frame.size.width/self.num*i,0 , frame.size.width/self.num, frame.size.height) andText:text[i] andBackgroundColor:newBackgroundColor andFontColor:newFontColor];
            btn.tag=100+i;
            [self addSubview:btn];
            [btn addTarget:self action:@selector(buttonMoveAction:) forControlEvents:UIControlEventTouchUpInside];//设置按钮点击事件
        }
    }
    self.glideBarView=[GlideButtnView creatGlideBarView:CGRectMake(0, frame.size.height-2, frame.size.width/self.num, 2) andGlideBarColor:newGlideBarColor];//创建滑动条视图
    [self addSubview:self.glideBarView];
    return self;
}
/**
 *  实现创建按钮方法
 *
 *  @param frame              位置大小
 *  @param text               标题
 *  @param newBackgroundColor 按钮背景颜色
 *  @param newFontColor       按钮字体颜色
 *
 *  @return 返回按钮对象
 */
+(UIButton *)creatButton:(CGRect)frame andText:(NSString *)text andBackgroundColor:(UIColor *)newBackgroundColor andFontColor:(UIColor *)newFontColor{
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame=frame;
    btn.backgroundColor=newBackgroundColor;
    [btn setTitle:text forState:UIControlStateNormal];
    [btn setTintColor:newFontColor];
    btn.titleLabel.font=[UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:18];
    return btn;
}
/**
 *  实现创建滑动条视图方法
 *
 *  @param frame         位置大小
 *  @param glideBarColor 背景颜色
 *
 *  @return 方法滑动条对象
 */
+(UIView *)creatGlideBarView:(CGRect)frame andGlideBarColor:(UIColor *)glideBarColor{
    UIView *glideBar=[[UIView alloc]initWithFrame:frame];
    glideBar.backgroundColor=glideBarColor;
    return glideBar;
}
/**
 *  响应按钮的点击事件
 *
 *  @param sender 按钮对象
 */
-(void)buttonMoveAction:(UIButton *)sender{
    UIView *btn;//定义一个视图存放按钮控件
    int count=sender.tag;//获取tag值
    /**
     *  滑动条移动到点击的按钮的位置
     */
    [UIView animateWithDuration:0.1 animations:^{
        self.glideBarView.frame=CGRectMake(sender.frame.origin.x, self.glideBarView.frame.origin.y, self.glideBarView.frame.size.width, self.glideBarView.frame.size.height);
    }];
    sender.tintColor=self.glideBarColor;//将按钮字体的颜色改成跟滑动条的背景颜色一样
    /**
     *  循环将其余按钮字体颜色改为原来的颜色
     */
    for (int i=0; i<self.num; i++) {
        btn=[self viewWithTag:100+i];//获取按钮控件
        if (btn.tag!=count) {//判断除了点击的按钮外的按钮
            btn.tintColor=self.fontColor;//颜色设置回原来的颜色
        }
    }
}
@end
