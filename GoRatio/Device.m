//
//  Device.m
//  StudyTree
//
//  Created by Ethan Keiser on 8/15/14.
//  Copyright (c) 2014 Ethan Keiser. All rights reserved.
//
#import "constant.h"
#import "RequestManager.h"
#import <AFNetworking.h>
#import "Device.h"
#import "DataManager.h"
@implementation Device
-(id)initWith:(id)dev
{
    self.deviceId= [dev objectForKey:@"DeviceId"];
    self.deviceToken= [dev objectForKey:@"DeviceToken"];
    self.deviceType=[dev objectForKey:@"DeviceType"];
    self.foreground=[dev boolForKey:@"Foreground"];
    
    return self;
}

-(void)resignDevice
{
    self.foreground=NO;
    
    NSURL *baseUrl =[NSURL URLWithString:KBaseUrl];
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager manager] initWithBaseURL:baseUrl];
    
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    
    


}
-(void)saveToLocalDB
{
    NSUserDefaults * userDefault=[[NSUserDefaults alloc] init];
    [userDefault setObject:self.DeviceId forKey:@"deviceId"];
    [userDefault setObject:self.DeviceToken forKey:@"deviceToken"];
    [userDefault setObject:self.DeviceType forKey:@"deviceType"];
    [userDefault setBool:self.foreground  forKey:@"foreground"];
    [userDefault synchronize];
}
-(void)becomeActive
{

[[RequestManager shared] updateDeviceStatusUserId:[DataManager shared].userId isActive:YES success:^{
    
} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    
}];
    
}
-(void)setDevice
{
    [DataManager shared].device=self;
    
    NSUserDefaults * userDefault=[[NSUserDefaults alloc] init];
    [userDefault setObject:self.DeviceId forKey:@"deviceId"];
    [userDefault setObject:self.DeviceToken forKey:@"deviceToken"];
    [userDefault setObject:self.DeviceType forKey:@"deviceType"];
    [userDefault setBool:self.foreground  forKey:@"foreground"];
    [userDefault synchronize];
}

@end
