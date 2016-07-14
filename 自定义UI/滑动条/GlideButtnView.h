//
//  GlideButtnView.h
//  一个View视图做一个滑动条，加多个按钮组合成导航条
//


#import <UIKit/UIKit.h>

@interface GlideButtnView : UIView
@property(nonatomic,strong)UIView *glideBarView;//定义滑动条视图
@property(nonatomic,strong)UIColor *fontColor;//定义字体颜色
@property(nonatomic,strong)UIColor *glideBarColor;//定义滑动条颜色
@property(nonatomic,assign)NSInteger num;//定义按钮个数
-(instancetype)initWithFrame:(CGRect)frame andArrayText:(NSArray *)text andBackgroundColor:(UIColor *)newBackgroundColor andGlideBarColor:(UIColor *)newGlideBarColor andFontColor:(UIColor *)newFontColor andButtonNumber:(NSInteger)newNum;//初始化方法
//+(UIButton *)creatButton:(CGRect)frame andText:(NSString *)text andBackgroundColor:(UIColor *)newBackgroundColor andFontColor:(UIColor *)newFontColor;
//+(UIView *)creatGlideBarView:(CGRect)frame andGlideBarColor:(UIColor *)glideBarColor;
@end
