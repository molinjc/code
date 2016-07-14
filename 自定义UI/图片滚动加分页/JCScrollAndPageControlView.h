//
//  JCScrollAndPageControlView.h
//  JianShu
//
//  Created by molin on 16/3/2.
//  Copyright © 2016年 molin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JCScrollAndPageControlViewDelegate <NSObject>

- (void)scrollAndPageControlViewClickedImageWithTag:(NSInteger)tag;

@end

@interface JCScrollAndPageControlView : UIView

@property (nonatomic, strong) NSMutableArray<NSString *> *images; // 图片组

@property (nonatomic, assign) NSTimeInterval             timeInterval; // 时间间隔

@property (nonatomic, assign) BOOL                       scrollAndPageControlEnabled; // 设置是否可拖动

@property (nonatomic, weak) id<JCScrollAndPageControlViewDelegate> scrollAndPageControlViewDelegate;

- (instancetype)initWithFrame:(CGRect)frame images:(NSMutableArray *)imaages;

@end
