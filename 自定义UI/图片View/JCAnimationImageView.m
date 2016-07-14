//
//  JCAnimationImageView.m
//  SvGifSample
//
//  Created by molin on 16/1/13.
//  Copyright © 2016年 smileEvday. All rights reserved.
//

#import "JCAnimationImageView.h"
#import <ImageIO/ImageIO.h>
#import <QuartzCore/CoreAnimation.h>

static NSArray *_NSBundlePreferredScales() {
    static NSArray *scales;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        CGFloat screenScale = [UIScreen mainScreen].scale;
        if (screenScale <= 1) {
            scales = @[@1,@2,@3];
        } else if (screenScale <= 2) {
            scales = @[@2,@3,@1];
        } else {
            scales = @[@3,@2,@1];
        }
    });
    return scales;
}

static NSString *_NSStringByAppendingNameScale(NSString *string, CGFloat scale) {
    if (!string) return nil;
    if (fabs(scale - 1) <= __FLT_EPSILON__ || string.length == 0 || [string hasSuffix:@"/"]) return string.copy;
    return [string stringByAppendingFormat:@"@%@x", @(scale)];
}

@implementation JCAnimationImageView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.imageLayer = [[CALayer alloc] init];
        self.contentMode = JCImageContentModeFull;
        [self addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    [self setLayerFramerWithContetnt:self.contentMode];
}

/**
 *  设定图片
 *
 *  @param name 图片名
 */
- (void)imageNamed:(NSString *)name {
    if (name.length == 0 || [name hasSuffix:@"/"]) {
        return;
    }
    NSString *res = name.stringByDeletingPathExtension;
    NSString *ext = name.pathExtension;
    NSURL *url = nil;
    NSArray *exts = ext.length > 0 ? @[ext] : @[@"", @"png", @"jpeg", @"jpg", @"gif", @"webp", @"apng"];
    NSArray *scales = _NSBundlePreferredScales();
    for (int s = 0; s < scales.count; s++) {
        CGFloat scale = ((NSNumber *)scales[s]).floatValue;
        NSString *scaledName = _NSStringByAppendingNameScale(res, scale);
        for (NSString *e in exts) {
            url = [[NSBundle mainBundle] URLForResource:scaledName withExtension:e];
            if (url) break;
        }
        if (url) break;
    }
    if (url.path.length == 0) return;
    self.imageInfo = [self imageInfoWithURL:(CFURLRef)url];
    [self animationImage:self.imageInfo];
}

/**
 *  根据路径获取图片
 *
 *  @param path 路径
 */
- (void)imagePath:(NSString *)path {
    if (path.length == 0) {
        return;
    }
    NSURL *url = [NSURL fileURLWithPath:path];
    if (url.path.length == 0) {
        return;
    }
    self.imageInfo = [self imageInfoWithURL:(CFURLRef)url];
    [self animationImage:self.imageInfo];
}

/**
 *  获取图片帧信息
 *
 *  @param url 路径
 *
 *  @return JCImageInfo
 */
- (JCImageInfo *)imageInfoWithURL:(CFURLRef)url {
    [self.imageLayer removeAllAnimations];
    [self.imageLayer removeFromSuperlayer];
    CGImageSourceRef imageSourceRef = CGImageSourceCreateWithURL(url, NULL);
    size_t frameCount = CGImageSourceGetCount(imageSourceRef);
    JCImageInfo *imageInfo = [[JCImageInfo alloc]initWithJCImageInfo];
    if (frameCount > 1) {
        for (size_t i = 0; i < frameCount; i++) {
            CGImageRef imageRef = CGImageSourceCreateImageAtIndex(imageSourceRef, i, NULL);
            [imageInfo.imageRefs addObject:(__bridge id)imageRef];
            CGImageRelease(imageRef);
            NSDictionary *dic = (NSDictionary*)CFBridgingRelease(CGImageSourceCopyPropertiesAtIndex(imageSourceRef, i, NULL));
            CGFloat width = [[dic valueForKey:(NSString *)kCGImagePropertyPixelWidth] floatValue];
            CGFloat height = [[dic valueForKey:(NSString *)kCGImagePropertyPixelHeight] floatValue];
            imageInfo.imageSize = CGSizeMake(width, height);
            NSDictionary *gifDict = [dic valueForKey:(NSString*)kCGImagePropertyGIFDictionary];
            [imageInfo.delayTimes addObject:[gifDict valueForKey:(NSString*)kCGImagePropertyGIFDelayTime]];
            imageInfo.totalTime += [[gifDict valueForKey:(NSString*)kCGImagePropertyGIFDelayTime] floatValue];
            CFRelease((__bridge CFTypeRef)(dic));
        }
        if (imageSourceRef) {
            CFRelease(imageSourceRef);
        }
        return imageInfo;
    }else {
        CGImageRef imageRef = CGImageSourceCreateImageAtIndex(imageSourceRef, 0, NULL);
        [imageInfo.imageRefs addObject:(__bridge id)imageRef];
        CGImageRelease(imageRef);
        NSDictionary *dic = (NSDictionary*)CFBridgingRelease(CGImageSourceCopyPropertiesAtIndex(imageSourceRef, 0, NULL));
        CGFloat width = [[dic valueForKey:(NSString *)kCGImagePropertyPixelWidth] floatValue];
        CGFloat height = [[dic valueForKey:(NSString *)kCGImagePropertyPixelHeight] floatValue];
        imageInfo.imageSize = CGSizeMake(width, height);
        return imageInfo;
    }
    return nil;
}

/**
 *  显示画面
 *
 *  @param imageInfo 图片信息
 */
- (void)animationImage:(JCImageInfo *)imageInfo {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"contents"];
    NSMutableArray *times = [NSMutableArray arrayWithCapacity:3];
    CGFloat currentTime = 0;
    int count = imageInfo.delayTimes.count;
    for (int i = 0; i < count; ++i) {
        [times addObject:[NSNumber numberWithFloat:(currentTime / imageInfo.totalTime)]];
        currentTime += [[imageInfo.delayTimes objectAtIndex:i] floatValue];
    }
    [animation setKeyTimes:times];
    
    NSMutableArray *images = [NSMutableArray arrayWithCapacity:3];
    for (int i = 0; i < imageInfo.imageRefs.count; ++i) {
        [images addObject:[imageInfo.imageRefs objectAtIndex:i]];
    }
    
    [animation setValues:images];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    animation.duration = imageInfo.totalTime;
    animation.delegate = self;
    animation.repeatCount = MAXFLOAT;
    [self.imageLayer addAnimation:animation forKey:@"gifAnimation"];
    [self setLayerFramerWithContetnt:self.contentMode];
    [self.layer addSublayer:self.imageLayer];
}

- (void)layerWithImage:(JCImageInfo *)imageInfo {
    self.imageLayer.frame = [self layerFremeFormSize:imageInfo.imageSize];
    self.imageLayer.contents = (id)imageInfo.imageRefs[0];
    [self.layer addSublayer:self.imageLayer];
}

/**
 *  根据CGSize获取CGRect
 *  用于layer的frame
 */
- (CGRect)layerFremeFormSize:(CGSize)size {
    CGFloat width = size.width;
    CGFloat height = size.height;
    if (width > self.frame.size.width) {
        width = self.frame.size.width;
    }
    if (height > self.frame.size.height) {
        height = self.frame.size.height;
    }
    return CGRectMake(self.frame.size.width/2-width/2, self.frame.size.height/2-height/2, width, height);
}

/**
 *  设置图片显示位置
 */
- (void)setContentMode:(JCImageContentMode)contentMode {
    if (self.imageInfo) {
        [self setLayerFramerWithContetnt:contentMode];
    }
    _contentMode = contentMode;
}


- (void)setLayerFramerWithContetnt:(JCImageContentMode)contentMode {
    CGFloat width = self.imageInfo.imageSize.width;
    CGFloat height = self.imageInfo.imageSize.height;
    switch (contentMode) {
        case JCImageContentModeFull: {
            self.imageLayer.frame = self.bounds;
            break;
        }
        case JCImageContentModeOriginalCenter: {
            self.imageLayer.frame = CGRectMake(self.frame.size.width/2-width/2, self.frame.size.height/2-height/2, width, height);
            break;
        }
        case JCImageContentModeOriginalCeterLeft: {
            self.imageLayer.frame = CGRectMake(0, self.frame.size.height/2-height/2, width, height);
            break;
        }
        case JCImageContentModeOriginalCeterRight: {
            self.imageLayer.frame = CGRectMake(self.frame.size.width-width, self.frame.size.height/2-height/2, width, height);
            break;
        }
        case JCImageContentModeOriginalTop: {
            self.imageLayer.frame = CGRectMake(self.frame.size.width/2-width/2, 0, width, height);
            break;
        }
        case JCImageContentModeOriginalTopLeft: {
            self.imageLayer.frame = CGRectMake(0, 0, width, height);
            break;
        }
        case JCImageContentModeOriginalTopRight: {
            self.imageLayer.frame = CGRectMake(self.frame.size.width-self.imageInfo.imageSize.width, 0, self.imageInfo.imageSize.width, self.imageInfo.imageSize.height);
            break;
        }
        case JCImageContentModeOriginalBottom: {
            self.imageLayer.frame = CGRectMake(self.frame.size.width/2-self.imageInfo.imageSize.width/2, self.frame.size.height-self.imageInfo.imageSize.height, self.imageInfo.imageSize.width, self.imageInfo.imageSize.height);
            break;
        }
        case JCImageContentModeOriginalBottomLeft: {
            self.imageLayer.frame = CGRectMake(0, self.frame.size.height-self.imageInfo.imageSize.height, self.imageInfo.imageSize.width, self.imageInfo.imageSize.height);
            break;
        }
        case JCImageContentModeOriginalBottomRight: {
            self.imageLayer.frame = CGRectMake(self.frame.size.width-self.imageInfo.imageSize.width, self.frame.size.height-self.imageInfo.imageSize.height, self.imageInfo.imageSize.width, self.imageInfo.imageSize.height);
            break;
        }
        default: {
            break;
        }
    }

}

@end

@implementation JCImageInfo

/**
 *  初始化
 */
- (instancetype)initWithJCImageInfo {
    if (self = [super init]) {
        self.frameCount = 0;
        self.imageRefs = [NSMutableArray new];
        self.delayTimes = [NSMutableArray new];
        self.totalTime = 0;
        self.form = @"";
        self.imageSize = CGSizeMake(0, 0);
    }
    return self;
}

@end
