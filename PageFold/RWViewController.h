//
//  RWViewController.h
//  PageFold
//
//  Created by Sam Davies on 19/05/2014.
//  Copyright (c) 2014 RayWenderlich. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RWViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *contentView;
- (IBAction)handleCompletionSliderChanged:(UISlider *)sender;
- (IBAction)handleOpenButtonPressed:(id)sender;
- (IBAction)handleCloseButtonPressed:(id)sender;



@end
