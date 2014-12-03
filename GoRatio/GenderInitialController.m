//
//  GenderIntialController.m
//  GoRatio
//
//  Created by Ethan Keiser on 11/29/14.
//  Copyright (c) 2014 Ethan Keiser. All rights reserved.
//

#import "GenderInitialController.h"
//#import "DoAlertView.h"
#import "AppDelegate.h"
@interface GenderInitialController ()

@end

@implementation GenderInitialController

-(id)init
{
   return [super init];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationItem.leftBarButtonItem=nil;
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createUser
{
 //   DoAlertView * alert=[[DoAlertView alloc]init];
//[alert doAlert:@"Saving" body:@"Setting up.." duration:0.0f done:^(DoAlertView *alertView) {
    
//}];
    [[RequestManager shared] createUsersuccess:^{
   //     [alert hideAlert];
        AppDelegate *appdelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
        [appdelegate.hubConnection start];
        [self.navigationController pushViewController:appdelegate.tabbarController animated:YES];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
  //      [alert hideAlert];
    //    DoAlertView *errorAlert=[[DoAlertView alloc]init];
        //errorAlert.bDestructive=YES;
      //  [errorAlert doYes:@"Error setting up. Try again later." yes:^(DoAlertView *alertView) {
            
        }];
   // }];
    
}
- (IBAction)LadyButton:(id)sender {
    [super LadyButton:sender];
    [self createUser];
}

- (IBAction)GentlemanButton:(id)sender {
    [super GentlemanButton:sender];
    
    [self createUser];

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
