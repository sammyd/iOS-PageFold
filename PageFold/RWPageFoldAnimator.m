//
//  RWPageFoldAnimator.m
//  PageFold
//
//  Created by Sam Davies on 22/05/2014.
//  Copyright (c) 2014 RayWenderlich. All rights reserved.
//

#import "RWPageFoldAnimator.h"

@interface RWPageFoldAnimator ()

@property (nonatomic, strong) RWPageFoldRenderer *renderer;

@end

@implementation RWPageFoldAnimator

- (instancetype)initWithRenderer:(RWPageFoldRenderer *)renderer
{
    self = [super init];
    if(self) {
        self.renderer = renderer;
    }
    return self;
}

- (void)openPage
{
    self.renderer.openProportion = 0.0;
}

- (void)closePage
{
    self.renderer.openProportion = 0.45;
}

@end
