//
//  AVAudioPlayer+JCTime.m
//  JCAudioPlayer
//
//  Created by molin on 16/5/27.
//  Copyright © 2016年 molin. All rights reserved.
//

#import "AVAudioPlayer+JCTime.h"

@implementation AVAudioPlayer (JCTime)
@dynamic durationString,currentTimeString;

- (NSString *)durationString {
    div_t h = div(self.duration, 3600);
    int hours = h.quot;
    div_t m = div(h.rem, 60);
    int minutes = m.quot;
    int seconds = m.rem;
    if (hours > 0) {
        return [NSString stringWithFormat:@"%d小时%d分%d秒",h,minutes,seconds];
    }else if (minutes > 0) {
        return [NSString stringWithFormat:@"%d分%d秒",minutes,seconds];
    }else if (seconds > 0) {
        return [NSString stringWithFormat:@"%d秒",h,minutes,seconds];
    }
    return nil;
}

- (NSString *)currentTimeString {
    div_t h = div(self.currentTime, 3600);
    int hours = h.quot;
    div_t m = div(h.rem, 60);
    int minutes = m.quot;
    int seconds = m.rem;
    if (hours > 0) {
        return [NSString stringWithFormat:@"%d小时%d分%d秒",h,minutes,seconds];
    }else if (minutes > 0) {
        return [NSString stringWithFormat:@"%d分%d秒",minutes,seconds];
    }else if (seconds > 0) {
        return [NSString stringWithFormat:@"%d秒",h,minutes,seconds];
    }
    return nil;
}

- (float)progress {
    return self.currentTime / self.duration;
}

@end
