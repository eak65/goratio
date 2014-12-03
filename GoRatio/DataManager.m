//
//  DataManager.m
//  GoRatio
//
//  Created by Ethan Keiser on 11/25/14.
//  Copyright (c) 2014 Ethan Keiser. All rights reserved.
//

#import "DataManager.h"
#import <UIKit/UIKit.h>
#import <SSKeychain.h>
@implementation DataManager

static DataManager *manager;
+(DataManager *)shared
{
    if(manager==nil)
    {
        manager=[[DataManager alloc]init];
        [manager loadSetting];
    }
    return manager;
}
-(void)parseUser:(NSDictionary *)dict
{
    self.userId=[NSNumber numberWithInteger:[[dict objectForKey:@"Id"] intValue]];
    NSString *gen=[dict objectForKey:@"Gender"];
    if([gen isEqualToString:@"F"]) // lady
        
    {
        self.gender=[NSNumber numberWithInt:1];
    }
    else // gentleman
    {
        self.gender=[NSNumber numberWithInt:2];
    }
}

-(NSString *)getDUID
{
        NSString *appName=[[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString*)kCFBundleNameKey];
        
        NSString *strApplicationUUID = [SSKeychain passwordForService:appName account:@"incoding"];
        if (strApplicationUUID == nil)
        {
            strApplicationUUID  = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
            [SSKeychain setPassword:strApplicationUUID forService:appName account:@"incoding"];
        }
        
        return strApplicationUUID;
}


-(void)saveSetting
{
    NSUserDefaults * userDefaults=[[NSUserDefaults alloc] init];
    [userDefaults setObject:[DataManager shared].gender forKey:@"Gender"];
    [userDefaults setObject:[DataManager shared].userId forKey:@"UserId"];
    [userDefaults setObject:[DataManager shared].DUID forKey:@"DUID"];


    [userDefaults synchronize];
    
}
-(void)loadSetting
{
    NSUserDefaults * userDefaults=[[NSUserDefaults alloc] init];
    manager.userId=[userDefaults objectForKey:@"UserId"];
    manager.gender=[userDefaults objectForKey:@"Gender"];
    manager.DUID=[userDefaults objectForKey:@"DUID"];
    
}


@end
