//
//  MainViewController.m
//  GoRatio
//
//  Created by Ethan Keiser on 11/25/14.
//  Copyright (c) 2014 Ethan Keiser. All rights reserved.
//
//#import "DoAlertView.h"
#import "GenderController.h"
#import "DataManager.h"
@interface GenderController ()

@end

@implementation GenderController

-(id)init
{
    return [super initWithNibName:@"GenderController" bundle:nil];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    if([DataManager shared].userId)
    {
        [self setGender];

    }
    else  // if no userid get the token
    {
        
    }
    self.view.backgroundColor=[UIColor midnightBlueColor];
    self.GentlemanButton.layer.cornerRadius = 4;
    self.GentlemanButton.layer.borderWidth = 1;
    self.GentlemanButton.layer.borderColor = [UIColor concreteColor].CGColor;
    
    self.Lady.layer.cornerRadius = 2;
    self.Lady.layer.borderWidth = 1;
    self.Lady.layer.borderColor = [UIColor concreteColor].CGColor;

    
    // Do any additional setup after loading the view from its nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)setGender
{
    if([[DataManager shared].gender intValue]==1)
    {
        self.currentSelected.text=@"Lady";
        self.Lady.backgroundColor=[UIColor belizeHoleColor];

        self.GentlemanButton.backgroundColor=[UIColor clearColor];
    }
    else if([[DataManager shared].gender intValue]==2)
    {
        self.currentSelected.text=@"Gentleman";
        self.GentlemanButton.backgroundColor=[UIColor belizeHoleColor];

        self.Lady.backgroundColor=[UIColor clearColor];

    }
    else
    {
        self.currentSelected.text=@"Select One";
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



- (IBAction)LadyButton:(id)sender {
    
   
    [DataManager shared].gender=[NSNumber numberWithInt:1];
    self.currentSelected.text=@"Lady";
  /*  [[RequestManager shared] updateSettingGendersuccess:^{
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    [self dismissViewControllerAnimated:YES completion:nil];
   */
    
}

- (IBAction)GentlemanButton:(id)sender {
    [DataManager shared].gender=[NSNumber numberWithInt:2];
self.currentSelected.text=@"Gentleman";
  /*  [[RequestManager shared] updateSettingGendersuccess:^{
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    [self dismissViewControllerAnimated:YES completion:nil];
   */

}
@end
