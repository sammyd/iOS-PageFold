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

@end


@implementation RWViewSplitter

- (instancetype)initWithView:(UIView *)view container:(UIView *)container
{
    self = [super init];
    if(self) {
        self.initialView = view;
        self.container = container;
    }
    return self;
}


- (void)setAnimationCompleted:(CGFloat)completion
{
    self.currentProportion = MIN(1, MAX(0, completion));
    
    if(self.currentProportion <= 1E-06) {
        self.leftView.layer.transform = CATransform3DIdentity;
        self.rightView.layer.transform = CATransform3DIdentity;
        [self unsplit];
    } else {
        if(![self.leftView superview]) {
            [self split];
        }
        CATransform3D rotn = CATransform3DMakeRotation(self.currentProportion * M_PI_2, 0, 1, 0);
        self.leftView.layer.transform = rotn;
        rotn = CATransform3DMakeRotation(- self.currentProportion * M_PI_2, 0, 1, 0);
        self.rightView.layer.transform = rotn;
    }
}


- (void)split
{
    if(!self.leftView) {
        [self splitView:self.initialView];
        [self prepareTransforms];
    }
    [self.container addSubview:self.leftView];
    [self.container addSubview:self.rightView];
    [self.initialView removeFromSuperview];
}

- (void)unsplit
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
    right.frame = CGRectOffset(rightRect, view.frame.origin.x, view.frame.origin.y);;
    self.rightView = right;
}

- (void)prepareTransforms
{
    CATransform3D perspectiveTransform = CATransform3DIdentity;
    perspectiveTransform.m34 = -0.002;
    self.container.layer.sublayerTransform = perspectiveTransform;
}


@end
