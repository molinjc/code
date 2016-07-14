//
//  UIImageView+JCFaceDetector.m
//  JCFace
//
//  Created by molin on 16/5/19.
//  Copyright © 2016年 molin. All rights reserved.
//

#import "UIImageView+JCFaceDetector.h"

@implementation UIImageView (JCFaceDetector)

- (void)faceDetector {
    //转成CIImage
    CIImage *ciImage = [CIImage imageWithCGImage:self.image.CGImage];
    //拿到所有的脸
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeFace context:nil options:@{CIDetectorAccuracy:CIDetectorAccuracyHigh}];
    NSArray <CIFeature *> *featureArray = [detector featuresInImage:ciImage];
    if (featureArray.count > 0) {
        //遍历
        for (CIFeature *feature in featureArray){
            //将image沿y轴对称
            CGAffineTransform transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, -1);
            //将image往上移动
            CGFloat imageH = ciImage.extent.size.height;
            transform = CGAffineTransformTranslate(transform, 0, -imageH);
            //在image上画出方框
            CGRect feaRect = feature.bounds;
            //调整后的坐标
            CGRect newFeaRect = CGRectApplyAffineTransform(feaRect, transform);
            //调整imageView的frame
            CGFloat imageViewW = self.bounds.size.width;
            CGFloat imageViewH = self.bounds.size.height;
            CGFloat imageW = ciImage.extent.size.width;
            //显示
            CGFloat scale = MIN(imageViewH / imageH, imageViewW / imageW);
            //缩放
            CGAffineTransform scaleTransform = CGAffineTransformMakeScale(scale, scale);
            
            //修正
            newFeaRect = CGRectApplyAffineTransform(newFeaRect, scaleTransform);
            newFeaRect.origin.x += (imageViewW - imageW * scale ) / 2;
            newFeaRect.origin.y += (imageViewH - imageH * scale ) / 2;
            
            //绘画
            UIView *breageView = [[UIView alloc] initWithFrame:newFeaRect];
            breageView.layer.borderColor = [UIColor redColor].CGColor;
            breageView.layer.borderWidth = 1;
            [self addSubview:breageView];
        }
    }
}

@end
