//
//  RWPageFoldAnimator.h
//  PageFold
//
//  Created by Sam Davies on 22/05/2014.
//  Copyright (c) 2014 RayWenderlich. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RWPageFoldRenderer.h"

@interface RWPageFoldAnimator : NSObject

- (instancetype)initWithRenderer:(RWPageFoldRenderer *)renderer;

- (void)openPage;
- (void)closePage;

@end
