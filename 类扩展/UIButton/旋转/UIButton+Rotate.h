//
//  UIButton+Rotate.h
//  JC_UIButton
//
//  Created by molin on 15/12/11.
//  Copyright © 2015年 molin. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SPIN_CLOCK_WISE 1
#define SPIN_COUNTERCLOCK_WISE -1

@interface UIButton (Rotate)

- (void)spinButtonWithTime:(CFTimeInterval)inDuration direction:(int)direction;

- (void)spinInfinityButtonWithTime:(CFTimeInterval)inDuration direction:(int)direction;
- (void)stopSpinInfinityButton;

@end
