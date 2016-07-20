//
//  JCInputField.h
//  56Customer
//
//  Created by 林建川 on 16/7/20.
//  Copyright © 2016年 molin. All rights reserved.
//

/**
 *  文本输入框
 */
#import <UIKit/UIKit.h>

@interface JCInputField : UIView

@property (nonatomic, strong) UIImage *image;      // icon

@property (nonatomic, copy) NSString *placeholder;   // 提示字符串

@property (nonatomic, copy) NSString *title;         // 标题

@property (nonatomic, copy)   NSString *text;               // 输入的文本
@property (nonatomic, assign) BOOL      clearButton;        // 清楚按钮
@property (nonatomic, assign) BOOL      secureTextEntry;    // 密码输入
@property (nonatomic, assign) NSInteger limitLenght;        // 限制长度
@property (nonatomic, assign) UIKeyboardType keyboardType;      // 键盘类型


/**
 *  初始化方法
 *
 *  @param image       Icon
 *  @param placeholder 提示字符串
 *
 *  @return 对象
 */
- (instancetype)initWithImage:(UIImage *)image placeholder:(NSString *)placeholder;

- (instancetype)initWithTitle:(NSString *)title placeholder:(NSString *)placeholder;

/**
 *  回收键盘
 */
- (void)resignTextFieldResponder;

@end
