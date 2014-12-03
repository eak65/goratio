//
//  InitialLoadingView.m
//  GoRatio
//
//  Created by Ethan Keiser on 11/25/14.
//  Copyright (c) 2014 Ethan Keiser. All rights reserved.
//

#import "InitialLoadingView.h"
#import "AppDelegate.h"
#import "DataManager.h"
#import <SVProgressHUD.h>
#import "GenderInitialController.h"
#import <SSKeychain.h>
#import "RequestManager.h"
@interface InitialLoadingView ()


@end

@implementation InitialLoadingView

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view from its nib.
}
-(void)viewDidAppear:(BOOL)animated
{
    [SVProgressHUD showWithStatus:@"Loading..."];
   // AppDelegate *delegate=[[UIApplication sharedApplication]delegate];

    [[RequestManager shared] getUser:[[DataManager shared] getDUID] success:^(AFHTTPRequestOperation *operation) {
        [SVProgressHUD dismiss];
        
        if(operation.response.statusCode==202) // userid
        {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        else if(operation.response.statusCode==200) // no userid
        {
            GenderInitialController * main =[[GenderInitialController alloc]init];
            [self.navigationController pushViewController:main animated:YES];
        }
    
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
       
        [SVProgressHUD showErrorWithStatus:@"Could not connect to server try again later!"];

    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)done
{
    [SVProgressHUD showSuccessWithStatus:@"Load Complete"];

    [self dismissViewControllerAnimated:YES completion:nil];
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
