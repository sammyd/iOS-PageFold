//
//  RWViewController.m
//  PageFold
//
//  Created by Sam Davies on 19/05/2014.
//  Copyright (c) 2014 RayWenderlich. All rights reserved.
//

#import "RWViewController.h"
#import "RWPageFoldRenderer.h"

@interface RWViewController ()

@property (nonatomic, strong) RWPageFoldRenderer *pageFoldRenderer;

@end

@implementation RWViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.contentView.layer.cornerRadius = 30;
}

- (void)viewDidAppear:(BOOL)animated
{
    self.pageFoldRenderer = [[RWPageFoldRenderer alloc] initWithView:self.contentView];
    self.pageFoldRenderer.openProportion = 0.5;
}

- (IBAction)handleCompletionSliderChanged:(UISlider *)sender {
    self.pageFoldRenderer.openProportion = sender.value;
}
@end
