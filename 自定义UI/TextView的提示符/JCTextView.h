//
//  JCTextView.h
//  JianShu
//
//  Created by molin on 16/4/27.
//  Copyright © 2016年 molin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JCTextView : UITextView

@property (nullable, nonatomic, copy) NSString               *placeholder;

@property (nullable, nonatomic, copy) NSAttributedString     *attributedPlaceholder;

@end
