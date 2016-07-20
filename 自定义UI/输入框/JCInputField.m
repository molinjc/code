//
//  JCInputField.m
//  56Customer
//
//  Created by 林建川 on 16/7/20.
//  Copyright © 2016年 molin. All rights reserved.
//

#import "JCInputField.h"

@interface JCInputField ()<UITextFieldDelegate>

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UITextField *textField;

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation JCInputField

- (instancetype)initWithImage:(UIImage *)image placeholder:(NSString *)placeholder {
    if (self = [super init]) {
        [self addSubview:self.imageView];
        [self addSubview:self.textField];
        
        self.image = image;
        self.placeholder = placeholder;
        
        [self layoutSubControlWithImage];
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title placeholder:(NSString *)placeholder {
    if (self = [super init]) {
        [self addSubview:self.titleLabel];
        [self addSubview:self.textField];
        
        self.title = title;
        self.placeholder = placeholder;
        [self layoutSubControlWithLabel];
    }
    return self;
}

/**
 *  布局子控件
 */
- (void)layoutSubControlWithImage {
    self.imageView.layoutLeft(17.5).layoutCenterY(0).layoutHeight(23).layoutWidth(15);
    self.textField.layoutAtSameLayerRight(self.imageView,22).layoutTop(0).layoutBottom(0).layoutRight(0);
};

- (void)layoutSubControlWithLabel {
    self.titleLabel.layoutLeft(11.5).layoutCenterY(0).layoutHeight(40).layoutWidth([self.titleLabel calculationTextWidthWithText:self.titleLabel.text font:self.titleLabel.font]);
    self.textField.layoutAtSameLayerRight(self.imageView,22).layoutTop(0).layoutBottom(0).layoutRight(0);
}

/**
 *  回收键盘
 */
- (void)resignTextFieldResponder {
    [self.textField resignFirstResponder];
}

- (void)textFieldWithText:(UITextField *)tf {
    if (self.limitLenght !=0) {
        if (tf.text.length > self.limitLenght) {
            tf.text = [tf.text substringToIndex:self.limitLenght];
        }
    }
    self.text = tf.text;
    // resignFirstResponder
}


#pragma mark - UITextFieldDelegate 

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    return [textField resignFirstResponder];
}

#pragma mark - 外部属性加载

- (void)setImage:(UIImage *)image {
    self.imageView.image = image;
    _image = image;
}

- (void)setPlaceholder:(NSString *)placeholder {
    self.textField.placeholder = placeholder;
    _placeholder = placeholder;
}

- (void)setTitle:(NSString *)title {
    self.titleLabel.text = title;
    _title = title;
}

- (void)setClearButton:(BOOL)clearButton {
    if (clearButton) {
        self.textField.clearButtonMode = UITextFieldViewModeAlways;
    }else {
        self.textField.clearButtonMode = UITextFieldViewModeNever;
    }
    _clearButton = clearButton;
}

- (void)setSecureTextEntry:(BOOL)secureTextEntry {
    self.textField.secureTextEntry = secureTextEntry;
    _secureTextEntry = secureTextEntry;
}

- (void)setKeyboardType:(UIKeyboardType)keyboardType {
    self.textField.keyboardType = keyboardType;
    _keyboardType = keyboardType;
}

#pragma mark - 内部属性加载

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
    }
    return _imageView;
}

- (UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.delegate = self;
        [_textField addTarget:self action:@selector(textFieldWithText:) forControlEvents:UIControlEventEditingChanged];
    }
    return _textField;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLabel;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
