//
//  MainViewController.h
//  GoRatio
//
//  Created by Ethan Keiser on 11/25/14.
//  Copyright (c) 2014 Ethan Keiser. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RequestManager.h"
#import <SVProgressHUD.h>
#import <QuartzCore/QuartzCore.h>
//#import "DoAlertView.h"
#import <FlatUIKit.h>

@interface GenderController : UIViewController
@property (strong, nonatomic) IBOutlet UIButton *Lady;
@property (strong, nonatomic) IBOutlet UIButton *GentlemanButton;
- (IBAction)LadyButton:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *currentSelected;

- (IBAction)GentlemanButton:(id)sender;
-(void)setGender;
@end
