//
//  AVAudioPlayer+JCTime.h
//  JCAudioPlayer
//
//  Created by molin on 16/5/27.
//  Copyright © 2016年 molin. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>

@interface AVAudioPlayer (JCTime)

@property(readonly) NSString *durationString; // 总时长，格式:HH:mm:ss

@property(readonly) NSString *currentTimeString;

@property(readonly) float progress;

@end
