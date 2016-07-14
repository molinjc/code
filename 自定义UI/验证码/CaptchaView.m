//
//  CaptchaView.m
//  LocalCaptcha
//
//  Created by ibokan on 15/6/30.
//  Copyright (c) 2015年 ibokan. All rights reserved.
//

#import "CaptchaView.h"

// 随机颜色
#define kRandomColor  [UIColor colorWithRed:arc4random() % 256 / 256.0 green:arc4random() % 256 / 256.0 blue:arc4random() % 256 / 256.0 alpha:1.0];
// 线条个数
#define kLineCount 6
// 线条宽度
#define kLineWidth 1.0
// 验证码个数
#define kCharCount 4
// 字体大小
#define kFontSize [UIFont systemFontOfSize:arc4random() % 5 + 15]

@implementation CaptchaView
// 初始化
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        // 设置layer圆角半径
        self.layer.cornerRadius = 5.0;
        // 隐藏边界
        self.layer.masksToBounds = YES;
        // 设置背景颜色
        self.backgroundColor = kRandomColor;
        
        // 显示一个随机验证码
        [self changeCaptcha];
    }
    return self;
}


- (void)changeCaptcha
{
    // 字符数组中随机抽取相应的数量的字符
    self.changeArray = [[NSArray alloc] initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z",@"a",@"b",@"c",@"d",@"e",@"f",@"g",@"h",@"i",@"j",@"k",@"l",@"m",@"n",@"o",@"p",@"q",@"r",@"s",@"t",@"u",@"v",@"w",@"x",@"y",@"z",nil];
    
     //如果能确定最大需要的容量，使用initWithCapacity:来设置，好处是当元素个数不超过容量时，添加元素不需要重新分配内存
    NSMutableString *getStr = [[NSMutableString alloc]initWithCapacity:kCharCount];
    
    self.changeString = [[NSMutableString alloc]initWithCapacity:kCharCount];
    
    // 随机从数组中选取需要个数的字符，拼接成一个字符串
    for (int i = 0; i<kCharCount; i++)
    {
        // 获取数组中随机一个下标
        NSInteger index = arc4random() % ([self.changeArray count] -1);
        // 根据下标获取字符
        getStr = [self.changeArray objectAtIndex:index];
        // 拼接成字符串
        self.changeString = (NSMutableString *)[self.changeString stringByAppendingString:getStr];
        
    }
    
    
    
}

// 点击View时调用该方法(因为当前类自身就是UIView，点击更换验证码可以直接写到这个方法中，不用再额外添加手势)
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // 点击界面，切换验证码
    [self changeCaptcha];
    
    // 调用drawRect:(CGRect)rect方法
    [self setNeedsDisplay];
    
}

// 绘制视图、线条的方法
- (void)drawRect:(CGRect)rect
{
    // 重写父类方法，首先要调用父类的方法
    [super drawRect:rect];
    
    // 设置视图随机背景颜色
    self.backgroundColor = kRandomColor;
    
    // 获得要显示验证码字符串，根据长度，计算每个字符显示的大概位置
    NSString *text = [NSString stringWithFormat:@"%@",self.changeString];
    // 字体的尺寸
    CGSize cSize = [@"S" sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20]}];
    // 获取1/4排除字体后的宽
    int width = rect.size.width / text.length - cSize.width;
    // 获取排除字体后的高
    int height = rect.size.height - cSize.height;
    
    
    CGPoint point;
    
    // 依次绘制每一个字符，可以设置显示的每个字符的字体大小，颜色，样式等
    float pX,pY;
    
    for (int i = 0; i<text.length; i++)
    {
        // 获取字符在视图上X轴的位置
        pX = arc4random() % width + rect.size.width / text.length * i;
        // 获取字符在视图上Y轴的位置
        pY = arc4random() % height;
        // 字符在视图上的位置
        point = CGPointMake(pX , pY );
        // 返回字符（不是字串）
        unichar c = [text characterAtIndex:i];
        // 拼接format要以%C（大写字母C）的形式
        NSString *textC = [NSString stringWithFormat:@"%C",c];
        // 设置位置与大小
        [textC drawAtPoint:point withAttributes:@{NSFontAttributeName:kFontSize}];
    }
    
    // 调用drawRect：之前，系统会向栈中压入一个CGContextRef，调用UIGraphicsGetCurrentContext()会取栈顶的CGContextRef
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 设置画线的宽度
    CGContextSetLineWidth(context, kLineWidth);
    
    // 绘制干扰的彩色直线
    for (int i = 0; i < kLineCount; i++)
    {
        // 设置线条的随机颜色
        UIColor *color = kRandomColor;
        //
        CGContextSetStrokeColorWithColor(context, [color CGColor]);
        
        // 设置线的起点
        pX = arc4random() % (int)rect.size.width;
        pY = arc4random() % (int)rect.size.height;
        //
        CGContextMoveToPoint(context, pX, pY);
        
        // 设置线的终点
        pX = arc4random() % (int)rect.size.width;
        pY = arc4random() % (int)rect.size.height;
        
        CGContextAddLineToPoint(context, pX, pY);
        
        // 连接线
        CGContextStrokePath(context);
        
        
    }
    
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
