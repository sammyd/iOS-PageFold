//
//  RWPageFoldRenderer.h
//  PageFold
//
//  Created by Sam Davies on 22/05/2014.
//  Copyright (c) 2014 RayWenderlich. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RWPageFoldRenderer : NSObject

- (instancetype)initWithView:(UIView *)view;

@property (nonatomic, assign) CGFloat openProportion;

@end
