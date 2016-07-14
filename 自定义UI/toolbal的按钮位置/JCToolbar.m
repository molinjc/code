//
//  JCToolbar.m
//  JianShu
//
//  Created by molin on 16/4/28.
//  Copyright © 2016年 molin. All rights reserved.
//

#import "JCToolbar.h"

@implementation JCToolbar

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat width = self.frame.size.width / self.items.count;
    CGFloat height = self.frame.size.height;
    int i = 0;
    for (UIView *toolbarButton in self.subviews) {
        if (![NSStringFromClass(toolbarButton.class) isEqualToString:@"UIToolbarButton"]) {
            continue;
        }
        toolbarButton.frame = CGRectMake(width * i, 0, width, height);
        i++;
    }
}

- (void)barButtonItemEvent:(UIBarButtonItem *)sender {
    if ([self.delegate_JCToolbar respondsToSelector:@selector(toolbar:DidSelectItemAtTag:)]) {
        [self.delegate_JCToolbar toolbar:self DidSelectItemAtTag:sender.tag];
    }
}

- (void)setImages:(NSArray<UIImage *> *)images {
    NSMutableArray *items = [NSMutableArray new];
    int i = 0;
    for (UIImage *image in images) {
        UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]  style:UIBarButtonItemStylePlain target:self action:@selector(barButtonItemEvent:)];
        barButtonItem.tag = i;
        [items addObject:barButtonItem];
        i++;
    }
    [self setItems:items];
}

- (void)setTitels:(NSArray<NSString *> *)titels {
    NSMutableArray *items = [NSMutableArray new];
    int i = 0;
    for (NSString *titel in titels) {
        UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:titel style:UIBarButtonItemStylePlain target:self action:@selector(barButtonItemEvent:)];
        barButtonItem.tag = i;
        [items addObject:barButtonItem];
        i++;
    }
    [self setItems:items];
}

@end
