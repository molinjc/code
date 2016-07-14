//
//  ResetTextHeight.h
//  对标签文本计算高，以这个高度重新对标签设置宽高
//


#import <UIKit/UIKit.h>

@interface ResetTextHeight : UIView
+(CGSize)countingTextHeight:(UILabel *)lbl;
-(CGSize)countingTextHeight:(UILabel *)lbl;
@end
