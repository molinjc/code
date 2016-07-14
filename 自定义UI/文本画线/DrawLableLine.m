//
//  DrawLableLine.m
//  ShoppingTest
//
//  Created by ibokan on 15/3/1.
//  Copyright (c) 2015年 ibokan. All rights reserved.
//

#import "DrawLableLine.h"

@implementation DrawLableLine

- (void)drawRect:(CGRect)rect {
    
    [super drawRect:rect];
    
    //根据文本的内容及字体大小获取size,从而得到宽
    CGSize textSize = [[self text] sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10]}];
    //得到文本的宽
    CGFloat strikeWidth = textSize.width;
    //要画的线的大小矩形
    CGRect lineRect;
    //画线的起始点x，y轴
    CGFloat origin_x;
    CGFloat origin_y;
    
    //判断文本设置是不是靠右
    if ([self textAlignment] == NSTextAlignmentRight)
    {
        //文本框的总宽-文本内容的宽＝起始点的x轴
        origin_x = rect.size.width - strikeWidth;
    }
    else if ([self textAlignment] == NSTextAlignmentCenter) //中间居中
    {
        origin_x = (rect.size.width - strikeWidth)/2 ;
    }
    else//靠左边
    {
        origin_x = 0;
    }
    //标签的中间y（调整画线在蚊子的中间）
    origin_y =  rect.size.height/2.0-2;
    //设置画线的矩形
    lineRect = CGRectMake(origin_x , origin_y, strikeWidth, 0.5);
    //获取上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    //颜色：红，绿，蓝   透明度
    CGFloat R, G, B, A;
    //灰色
    UIColor *uiColor = [UIColor grayColor];
    CGColorRef color = [uiColor CGColor];
    
    //获取当前设置的颜色有几个元素（R，G，B，A)(4个)
    int numComponents =(int) CGColorGetNumberOfComponents(color);
    
    if( numComponents == 4)
    {
        const CGFloat *components = CGColorGetComponents(color);
        R = components[0];
        G = components[1];
        B = components[2];
        A = components[3];
        
        //设置画线颜色
        CGContextSetRGBFillColor(context, R, G, B, A);
    }
    //开始画线
    CGContextFillRect(context, lineRect);

}


@end
