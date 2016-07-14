//
//  JCDrawPanel.h
//  JCDrawPanel
//
//  Created by molin on 16/5/23.
//  Copyright © 2016年 molin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JCDrawPanel : UIView

@property (nonatomic, assign) CGFloat lineWidth;  // 线宽

@property (nonatomic, copy)   UIColor *lineColor;  // 线的颜色

/***   撤销   ***/
- (void)revoke;

- (void)revokeAll;

/***   恢复   ***/
- (void)recovery;

- (void)recoveryAll;

/**
 *  截图
 *
 *  @return 图片
 */
- (UIImage *)screenshot;

@end
