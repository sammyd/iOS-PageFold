//
//  RWPageFoldRenderer.m
//  PageFold
//
//  Created by Sam Davies on 22/05/2014.
//  Copyright (c) 2014 RayWenderlich. All rights reserved.
//

#import "RWPageFoldRenderer.h"
#import "RWViewSplitter.h"

@interface RWPageFoldRenderer ()

@property (nonatomic, strong) RWViewSplitter *viewSplitter;
@property (nonatomic, strong) CAGradientLayer *leftGradientLayer;
@property (nonatomic, strong) CAGradientLayer *rightGradientLayer;

@end


@implementation RWPageFoldRenderer

- (instancetype)initWithView:(UIView *)view
{
    self = [super init];
    if(self) {
        self.viewSplitter = [[RWViewSplitter alloc] initWithView:view];
    }
    return self;
}

#pragma mark - Override setter
- (void)setOpenProportion:(CGFloat)openProportion
{
    _openProportion = MIN(1, MAX(0, openProportion));
    
    if(self.openProportion <= 1E-06) {
        self.viewSplitter.leftView.layer.transform = CATransform3DIdentity;
        self.viewSplitter.rightView.layer.transform = CATransform3DIdentity;
        [self.viewSplitter unsplitView];
    } else {
        if(![self.viewSplitter.leftView superview]) {
            [self.viewSplitter splitView];
            [self createGradientLayers];
        }
        [CATransaction begin];
        [CATransaction setDisableActions:YES];
        CATransform3D transform = CATransform3DMakeTranslation(0, 0, self.openProportion * -500);
        transform = CATransform3DRotate(transform, self.openProportion * M_PI_2, 0, 1, 0);
        self.viewSplitter.leftView.layer.transform = transform;
        transform = CATransform3DMakeTranslation(0, 0, self.openProportion * -500);
        transform = CATransform3DRotate(transform, self.openProportion * - M_PI_2, 0, 1, 0);
        self.viewSplitter.rightView.layer.transform = transform;
        self.rightGradientLayer.opacity = self.openProportion;
        self.leftGradientLayer.opacity = self.openProportion;
        [CATransaction commit];
    }
}

#pragma mark - Utility methods
- (void)createGradientLayers
{
    if([self.rightGradientLayer superlayer]) {
        [self.rightGradientLayer removeFromSuperlayer];
    }
    self.rightGradientLayer = [CAGradientLayer layer];
    self.rightGradientLayer.bounds = self.viewSplitter.rightView.bounds;
    self.rightGradientLayer.position = CGPointMake(self.viewSplitter.rightView.bounds.size.width / 2,
                                                   self.viewSplitter.rightView.bounds.size.height / 2);
    self.rightGradientLayer.colors = @[
                                       (id)[[UIColor blackColor] colorWithAlphaComponent:0.3].CGColor,
                                       (id)[[UIColor blackColor] colorWithAlphaComponent:0.2].CGColor
                                       ];
    self.rightGradientLayer.locations = @[@0, @1];
    self.rightGradientLayer.startPoint = CGPointMake(0, 0.5);
    self.rightGradientLayer.endPoint = CGPointMake(1, 0.5);
    
    if([self.leftGradientLayer superlayer]) {
        [self.leftGradientLayer removeFromSuperlayer];
    }
    
    self.leftGradientLayer = [CAGradientLayer layer];
    self.leftGradientLayer.bounds = self.viewSplitter.leftView.bounds;
    self.leftGradientLayer.position = CGPointMake(self.viewSplitter.leftView.bounds.size.width / 2,
                                                  self.viewSplitter.leftView.bounds.size.height / 2);
    self.leftGradientLayer.colors = @[
                                      (id)[[UIColor blackColor] colorWithAlphaComponent:0.1].CGColor,
                                      (id)[[UIColor blackColor] colorWithAlphaComponent:0.2].CGColor
                                      ];
    self.leftGradientLayer.locations = @[@0, @1];
    self.leftGradientLayer.startPoint = CGPointMake(0, 0.5);
    self.leftGradientLayer.endPoint = CGPointMake(1, 0.5);
    
    [self.viewSplitter.rightView.layer addSublayer:self.rightGradientLayer];
    [self.viewSplitter.leftView.layer addSublayer:self.leftGradientLayer];
    
    
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    self.rightGradientLayer.opacity = 0.0;
    self.leftGradientLayer.opacity = 0.0;
    [CATransaction commit];
}


@end
