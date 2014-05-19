//
//  RWViewController.m
//  PageFold
//
//  Created by Sam Davies on 19/05/2014.
//  Copyright (c) 2014 RayWenderlich. All rights reserved.
//

#import "RWViewController.h"
#import "RWViewSplitter.h"

@interface RWViewController ()

@property (nonatomic, strong) RWViewSplitter *viewSplitter;

@end

@implementation RWViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.viewSplitter = [[RWViewSplitter alloc] initWithView:self.contentView container:self.view];
    [self.viewSplitter split];
}

@end
