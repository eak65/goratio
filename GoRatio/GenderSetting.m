//
//  GenderSetting.m
//  GoRatio
//
//  Created by Ethan Keiser on 12/1/14.
//  Copyright (c) 2014 Ethan Keiser. All rights reserved.
//

#import "GenderSetting.h"
#import "DataManager.h"
@interface GenderSetting ()

@end

@implementation GenderSetting

-(id)init
{
    return [super init];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated
{
    [SVProgressHUD dismiss];
}
- (IBAction)LadyButton:(id)sender {
    if([[DataManager shared].gender integerValue]!=1)
    {
    [super LadyButton:sender];
    [SVProgressHUD showWithStatus:@"Submitting"];
    [self setGender];
  [[RequestManager shared] updateSettingGendersuccess:^{
     
      [SVProgressHUD showSuccessWithStatus:@"Saved!"];
      
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         [SVProgressHUD showErrorWithStatus:@"Error, Could not save!"];

     }];
  
    }
}

- (IBAction)GentlemanButton:(id)sender {
    if([[DataManager shared].gender integerValue]!=2)
    {
    [super GentlemanButton:sender];
    
    [SVProgressHUD showWithStatus:@"Submitting"];
    [self setGender];

     [[RequestManager shared] updateSettingGendersuccess:^{
         [SVProgressHUD showSuccessWithStatus:@"Saved!"];

     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         [SVProgressHUD showErrorWithStatus:@"Error, Could not save!"];

     }];
    
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

@end
