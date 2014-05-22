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

@property (nonatomic, strong) CAGradientLayer *rightGradientLayer;
@property (nonatomic, strong) CAGradientLayer *leftGradientLayer;

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
        [CATransaction begin];
        [CATransaction setDisableActions:YES];
        CATransform3D transform = CATransform3DMakeTranslation(0, 0, self.currentProportion * -500);
        transform = CATransform3DRotate(transform, self.currentProportion * M_PI_2, 0, 1, 0);
        self.leftView.layer.transform = transform;
        transform = CATransform3DMakeTranslation(0, 0, self.currentProportion * -500);
        transform = CATransform3DRotate(transform, self.currentProportion * - M_PI_2, 0, 1, 0);
        self.rightView.layer.transform = transform;
        self.rightGradientLayer.opacity = self.currentProportion;
        self.leftGradientLayer.opacity = self.currentProportion;
        [CATransaction commit];
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
    right.frame = CGRectOffset(rightRect, view.frame.origin.x, view.frame.origin.y);
    self.rightView = right;
    
    self.rightGradientLayer = [CAGradientLayer layer];
    self.rightGradientLayer.bounds = self.rightView.bounds;
    self.rightGradientLayer.position = CGPointMake(self.rightView.bounds.size.width / 2,
                                                   self.rightView.bounds.size.height / 2);
    self.rightGradientLayer.colors = @[
                                       (id)[[UIColor blackColor] colorWithAlphaComponent:0.3].CGColor,
                                       (id)[[UIColor blackColor] colorWithAlphaComponent:0.2].CGColor
                                       ];
    self.rightGradientLayer.locations = @[@0, @1];
    self.rightGradientLayer.startPoint = CGPointMake(0, 0.5);
    self.rightGradientLayer.endPoint = CGPointMake(1, 0.5);
    
    self.leftGradientLayer = [CAGradientLayer layer];
    self.leftGradientLayer.bounds = self.leftView.bounds;
    self.leftGradientLayer.position = CGPointMake(self.leftView.bounds.size.width / 2,
                                                  self.leftView.bounds.size.height / 2);
    self.leftGradientLayer.colors = @[
                                      (id)[[UIColor blackColor] colorWithAlphaComponent:0.1].CGColor,
                                      (id)[[UIColor blackColor] colorWithAlphaComponent:0.2].CGColor
                                      ];
    self.leftGradientLayer.locations = @[@0, @1];
    self.leftGradientLayer.startPoint = CGPointMake(0, 0.5);
    self.leftGradientLayer.endPoint = CGPointMake(1, 0.5);
    
    [self.rightView.layer addSublayer:self.rightGradientLayer];
    [self.leftView.layer addSublayer:self.leftGradientLayer];
    
    
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    self.rightGradientLayer.opacity = 0.0;
    self.leftGradientLayer.opacity = 0.0;
    [CATransaction commit];
}

- (void)prepareTransforms
{
    CATransform3D perspectiveTransform = CATransform3DIdentity;
    perspectiveTransform.m34 = -0.002;
    self.container.layer.sublayerTransform = perspectiveTransform;
}


@end
