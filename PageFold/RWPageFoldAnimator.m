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
    POPPropertyAnimation *anim = [self proportionAnimation];
    anim.toValue = @0.0;
    [self.renderer pop_addAnimation:anim forKey:@"OpenProportion"];
}

- (void)closePage
{
    POPPropertyAnimation *anim = [self proportionAnimation];
    anim.toValue = @0.45;
    [self.renderer pop_addAnimation:anim forKey:@"OpenProportion"];
}


#pragma mark - Utility methods
- (POPPropertyAnimation *)proportionAnimation
{
    POPSpringAnimation *anim = [POPSpringAnimation animation];
    anim.property = self.openProportionAnimateableProperty;
    anim.springBounciness = 12;
    anim.springSpeed = 4;
    anim.fromValue = @(self.renderer.openProportion);
    return anim;
}

@end
