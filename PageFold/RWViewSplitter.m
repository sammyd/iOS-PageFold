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

@property (nonatomic, strong, readwrite) UIView *leftView;
@property (nonatomic, strong, readwrite) UIView *rightView;

@end


@implementation RWViewSplitter

- (instancetype)initWithView:(UIView *)view
{
    self = [super init];
    if(self) {
        self.initialView = view;
        self.container = [view superview];
    }
    return self;
}

- (void)splitView
{
    if(!self.leftView) {
        [self splitView:self.initialView];
        [self prepareTransforms];
    }
    [self.container addSubview:self.leftView];
    [self.container addSubview:self.rightView];
    [self.initialView removeFromSuperview];
}

- (void)unsplitView
{
    [self.container addSubview:self.initialView];
    [self.leftView removeFromSuperview];
    [self.rightView removeFromSuperview];
    self.leftView = nil;
    self.rightView = nil;
}

#pragma mark - Non-public methods
- (void)splitView:(UIView *)view
{
    CGRect leftRect;
    CGRect rightRect;
    CGFloat width = CGRectGetWidth(view.bounds) / 2.0;
    CGRectDivide(view.bounds, &leftRect, &rightRect, width, CGRectMinXEdge);
    
    UIView *left = [view resizableSnapshotViewFromRect:leftRect
                                    afterScreenUpdates:YES
                                         withCapInsets:UIEdgeInsetsZero];
    left.layer.anchorPoint = CGPointMake(1, 0.5);
    left.frame = CGRectOffset(leftRect, view.frame.origin.x, view.frame.origin.y);
    self.leftView = left;
    UIView *right = [view resizableSnapshotViewFromRect:rightRect
                                     afterScreenUpdates:YES
                                          withCapInsets:UIEdgeInsetsZero];
    right.layer.anchorPoint = CGPointMake(0, 0.5);
    right.frame = CGRectOffset(rightRect, view.frame.origin.x, view.frame.origin.y);
    self.rightView = right;    
}

- (void)prepareTransforms
{
    CATransform3D perspectiveTransform = CATransform3DIdentity;
    perspectiveTransform.m34 = -0.002;
    self.container.layer.sublayerTransform = perspectiveTransform;
}


@end
