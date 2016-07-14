//
//  ResetTextHeight.m
//  实现
//


#import "ResetTextHeight.h"

@implementation ResetTextHeight
/**
 *  类方法（类调用）
 *  计算文本要摆放多大的空间（.width--文本的宽，.height--文本的高）
 *  CGSize 表示一个矩形的宽度和高度
 *
 *  @param lbl UILabel 对象
 *
 *  @return 返回CGSize
 */
+(CGSize)countingTextHeight:(UILabel *)lbl{
    CGSize textSize=[lbl.text boundingRectWithSize:CGSizeMake(lbl.frame.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:lbl.font} context:nil].size;
    return textSize;
}
/**
 *  实例方法（对象调用）
 *  计算文本要摆放多大的空间（.width--文本的宽，.height--文本的高）
 *  CGSize 表示一个矩形的宽度和高度
 *
 *  @param lbl UILabel 对象
 *
 *  @return 返回CGSize
 */
-(CGSize)countingTextHeight:(UILabel *)lbl{
    CGSize textSize=[lbl.text boundingRectWithSize:CGSizeMake(lbl.frame.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:lbl.font} context:nil].size;
    return textSize;
}
@end
