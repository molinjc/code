//
//  JCAnimationImageView.h
//  SvGifSample
//
//  Created by molin on 16/1/13.
//  Copyright © 2016年 smileEvday. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,JCImageContentMode) {
    JCImageContentModeFull,
    JCImageContentModeOriginalCenter,
    JCImageContentModeOriginalCeterLeft,
    JCImageContentModeOriginalCeterRight,
    JCImageContentModeOriginalTop,
    JCImageContentModeOriginalTopLeft,
    JCImageContentModeOriginalTopRight,
    JCImageContentModeOriginalBottom,
    JCImageContentModeOriginalBottomLeft,
    JCImageContentModeOriginalBottomRight,
};

@class JCImageInfo;

@interface JCAnimationImageView : UIView

- (instancetype)initWithFrame:(CGRect)frame;

- (void)imageNamed:(NSString *)name;

- (void)imagePath:(NSString *)path;

@property (nonatomic, strong) CALayer            *imageLayer;

@property (nonatomic, assign) JCImageContentMode contentMode;

@property (nonatomic, strong) JCImageInfo        *imageInfo;

@end


/**
 *  图片的信息类
 */
@interface JCImageInfo : NSObject

@property (nonatomic, assign) NSUInteger     frameCount;  // 总的帧数

@property (nonatomic, strong) NSMutableArray *imageRefs;  // 单个画面

@property (nonatomic, strong) NSMutableArray *delayTimes; // 每帧的时间

@property (nonatomic, assign) float          totalTime;   // 动画的总时间

@property (nonatomic, copy  ) NSString       *form;       // 格式

@property (nonatomic, assign) CGSize         imageSize;    // 大小

- (instancetype)initWithJCImageInfo;

@end