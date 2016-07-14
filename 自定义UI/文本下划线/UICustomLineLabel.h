//
//  UICustomLineLabel.h
//  UILineLableDemo
//
//  Created by myanycam on 2014/2/25.
//  Copyright (c) 2014年 myanycam. All rights reserved.
//

#import <UIKit/UIKit.h>
//枚举
typedef enum{
    
    LineTypeNone,//没有画线
    LineTypeUp ,// 上边画线
    LineTypeMiddle,//中间画线
    LineTypeDown,//下边画线
    
} LineType ;

@interface UICustomLineLabel : UILabel

@property (assign, nonatomic) LineType lineType;//画线类型
@property (assign, nonatomic) UIColor * lineColor;//画线颜色


@end
