//
//  JCToolbar.h
//  JianShu
//
//  Created by molin on 16/4/28.
//  Copyright © 2016年 molin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UITextView,UITextField;
@class JCToolbar;
@protocol JCToolbarDelegate <NSObject>
@optional
- (void)toolbar:(JCToolbar * _Nonnull )toolbar DidSelectItemAtTag:(NSInteger)tag;

@end

@interface JCToolbar : UIToolbar

@property (nonatomic, weak) id<JCToolbarDelegate> delegate_JCToolbar;

@property (nullable, nonatomic, copy) NSArray<UIImage *> *images;

@property (nullable, nonatomic, copy) NSArray<NSString *> *titels;

@end
