//
//  RWPageFoldAnimator.m
//  PageFold
//
//  Created by Sam Davies on 22/05/2014.
//  Copyright (c) 2014 RayWenderlich. All rights reserved.
//

#import "RWPageFoldAnimator.h"
#import <POP/POP.h>

@interface RWPageFoldAnimator ()

@property (nonatomic, strong) RWPageFoldRenderer *renderer;
@property (nonatomic, strong) POPAnimatableProperty *openProportionAnimateableProperty;

@end

@implementation RWPageFoldAnimator

- (instancetype)initWithRenderer:(RWPageFoldRenderer *)renderer
{
    self = [super init];
    if(self) {
        self.renderer = renderer;
        self.openProportionAnimateableProperty =
        [POPAnimatableProperty propertyWithName:@"com.raywenderlich.pagefoldanimator.openproportion"
                                    initializer:^(POPMutableAnimatableProperty *prop) {
             // read value
             prop.readBlock = ^(RWPageFoldRenderer *r, CGFloat values[]) {
                 values[0] = r.openProportion;
             };
             // write value
             prop.writeBlock = ^(RWPageFoldRenderer *r, const CGFloat values[]) {
                 r.openProportion = values[0];
             };
             // dynamics threshold
             prop.threshold = 0.01;
         }];
    }
    return self;
}

- (void)openPage
{
    POPBasicAnimation *anim = [POPBasicAnimation animation];
    anim.property = self.openProportionAnimateableProperty;
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    anim.fromValue = @(self.renderer.openProportion);
    anim.toValue = @0;
    [self.renderer pop_addAnimation:anim forKey:@"OpenProportion"];
}

- (void)closePage
{
    POPSpringAnimation *anim = [POPSpringAnimation animation];
    anim.property = self.openProportionAnimateableProperty;
    anim.fromValue = @(self.renderer.openProportion);
    anim.toValue = @0.45;
    anim.springSpeed = 4.0;
    anim.springBounciness = 12.0;
    [self.renderer pop_addAnimation:anim forKey:@"OpenProportion"];
}

@end
