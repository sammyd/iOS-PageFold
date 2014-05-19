//
//  RWViewSplitter.m
//  PageFold
//
//  Created by Sam Davies on 19/05/2014.
//  Copyright (c) 2014 RayWenderlich. All rights reserved.
//

#import "RWViewSplitter.h"

@interface RWViewSplitter ()

@property (nonatomic, strong) UIView *initialView;
@property (nonatomic, strong) UIView *container;
@property (nonatomic, assign) CGFloat currentProportion;

@property (nonatomic, strong) UIView *leftView;
@property (nonatomic, strong) UIView *rightView;
@property (nonatomic, strong) UIView *containerView;

@end


@implementation RWViewSplitter

- (instancetype)initWithView:(UIView *)view container:(UIView *)container
{
    self = [super init];
    if(self) {
        self.initialView = view;
        self.container = container;
        [self splitView:view];
    }
    return self;
}


- (void)setAnimationCompleted:(CGFloat)completion
{
    self.currentProportion = MIN(1, MAX(0, completion));
}


#pragma mark - Non-public methods
- (void)splitView:(UIView *)view
{
    CGRect leftRect;
    CGRect rightRect;
    CGFloat width = CGRectGetWidth(view.bounds) / 2.0;
    CGRectDivide(view.bounds, &leftRect, &rightRect, width, CGRectMinXEdge);
    NSLog(@"Left: %@", NSStringFromCGRect(leftRect));
    NSLog(@"Right: %@", NSStringFromCGRect(rightRect));
    
    UIView *left = [view resizableSnapshotViewFromRect:leftRect
                                    afterScreenUpdates:YES
                                         withCapInsets:UIEdgeInsetsZero];
    self.leftView = left;
    UIView *right = [view resizableSnapshotViewFromRect:rightRect
                                     afterScreenUpdates:YES
                                          withCapInsets:UIEdgeInsetsZero];
    right.frame = rightRect;
    self.rightView = right;
}

- (void)split
{
    [self.container addSubview:self.leftView];
    [self.container addSubview:self.rightView];
    [self.initialView removeFromSuperview];
}

- (void)unsplit
{
    [self.container addSubview:self.initialView];
    [self.leftView removeFromSuperview];
    [self.rightView removeFromSuperview];
}


@end
