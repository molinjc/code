//
//  JCScrollAndPageControlView.m
//  JianShu
//
//  Created by molin on 16/3/2.
//  Copyright © 2016年 molin. All rights reserved.
//

#import "JCScrollAndPageControlView.h"

@interface JCScrollAndPageControlView ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView  *scrollView;

@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic, strong) NSTimer       *rollTimer;

@end

@implementation JCScrollAndPageControlView

- (instancetype)initWithFrame:(CGRect)frame images:(NSMutableArray *)imaages {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.scrollView];
        [self addSubview:self.pageControl];
        
        self.scrollView.frame = self.bounds;
        self.pageControl.frame = CGRectMake(0, self.height - 25, self.width, 20);
        
        self.images = imaages;
        
        [self setRollTimeInterval:15.0];
        
    }
    return self;
}

#pragma mark - 方法

/**
 *  设置定时器
 *
 *  @param ti 时间间隔
 */
- (void)setRollTimeInterval:(NSTimeInterval)ti {
    if (self.rollTimer) {
        [self.rollTimer invalidate];
        self.rollTimer = nil;
    }
    self.rollTimer = [NSTimer scheduledTimerWithTimeInterval:ti target:self selector:@selector(runRollTimer:) userInfo:nil repeats:YES];
    [[NSRunLoop  currentRunLoop] addTimer:self.rollTimer forMode:NSDefaultRunLoopMode];
}

#pragma mark - 定时器调用的方法

- (void)runRollTimer:(NSTimer *)sender {
    NSInteger page = self.pageControl.currentPage;
    page ++;
    [self.scrollView setContentOffset:CGPointMake(self.width * (page + 1), 0) animated:YES];
}

#pragma mark - 点击事件

/**
 *  点击手势imageView调用的方法
 */
- (void)imageViewsClicked:(UITapGestureRecognizer *)sender {
    [self.scrollAndPageControlViewDelegate scrollAndPageControlViewClickedImageWithTag:sender.view.tag];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView != self.scrollView) {
        return;
    }
    
    NSInteger page = scrollView.contentOffset.x / self.width;
    if (page == self.images.count + 1) {
        [self.scrollView setContentOffset:CGPointMake(self.width, 0) animated:NO];
        [self.pageControl setCurrentPage:0];
    }else if(scrollView.contentOffset.x <= 0) {
        [self.scrollView setContentOffset:CGPointMake(self.width * self.images.count, 0) animated:NO];
        [self.pageControl setCurrentPage:self.images.count];
    }else {
        [self.pageControl setCurrentPage:page - 1];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView != self.scrollView) {
        return;
    }
    
    NSInteger page = scrollView.contentOffset.x / self.width;
    if (page == self.images.count + 1) {
        [self.scrollView setContentOffset:CGPointMake(self.width, 0) animated:NO];
        [self.pageControl setCurrentPage:0];
    }else if(scrollView.contentOffset.x <= 0) {
        [self.scrollView setContentOffset:CGPointMake(self.width * self.images.count, 0) animated:NO];
        [self.pageControl setCurrentPage:self.images.count];
    }else {
        [self.pageControl setCurrentPage:page - 1];
    }
}


#pragma mark - get和set

- (void)setImages:(NSMutableArray<NSString *> *)images {
    if (images.count == 0) {
        return;
    }
    
    self.pageControl.numberOfPages = images.count;
    
    self.scrollView.contentSize = CGSizeMake(self.width * (images.count + 2), self.height);
    self.scrollView.contentOffset = CGPointMake(self.width, 0);
    for (int i=0; i<images.count+2; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.width * i, 0, self.width, self.height)];
        if (i == 0) {
            imageView.image = [UIImage imageNamed:images[images.count - 1]];  // 第一个位置放最后一张
            imageView.tag = images.count - 1;
        }else if (i == images.count + 1) {
            imageView.image = [UIImage imageNamed:images[0]];   //最后的位置放第一张
            imageView.tag = 0;
        }else {
            imageView.image = [UIImage imageNamed:images[i-1]];
            imageView.tag = i - 1;
        }
        [self.scrollView addSubview:imageView];
        UITapGestureRecognizer *tapGestureRecongnizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageViewsClicked:)];
        [imageView addGestureRecognizer:tapGestureRecongnizer];
        imageView.userInteractionEnabled = YES;
    }
    _images = images;
}

- (void)setTimeInterval:(NSTimeInterval)timeInterval {
    [self setRollTimeInterval:timeInterval];
    _timeInterval = timeInterval;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]init];
        _scrollView.pagingEnabled = YES;  //设置滚动视图是否整页翻动，能整页翻动
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.delegate = self;
    }
    return _scrollView;
}

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc]init];
        _pageControl.userInteractionEnabled = NO;    //设置控件是否接收用户的事件消息（用户交互），不能
        _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor]; //设置当前页的显示颜色
        _pageControl.pageIndicatorTintColor = [UIColor grayColor];         //设置未使用状态的颜色
    }
    return _pageControl;
}

- (void)setScrollAndPageControlEnabled:(BOOL)scrollAndPageControlEnabled {
    self.scrollView.scrollEnabled = scrollAndPageControlEnabled;
    _scrollAndPageControlEnabled = scrollAndPageControlEnabled;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
