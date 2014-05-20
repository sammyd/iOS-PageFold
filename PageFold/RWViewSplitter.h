//
//  RWViewSplitter.h
//  PageFold
//
//  Created by Sam Davies on 19/05/2014.
//  Copyright (c) 2014 RayWenderlich. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RWViewSplitter : NSObject

- (instancetype)initWithView:(UIView *)view container:(UIView *)container;
- (void)setAnimationCompleted:(CGFloat)completion;

@end
