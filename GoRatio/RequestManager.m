//
//  RequestManager.m
//  GoRatio
//
//  Created by Ethan Keiser on 11/25/14.
//  Copyright (c) 2014 Ethan Keiser. All rights reserved.
//

#import "RequestManager.h"
#import "constant.h"
#import "DataManager.h"
#import "LocationTracker.h"
#import "Bar.h"
@implementation RequestManager

static RequestManager *manager;
+(RequestManager *)shared
{
    if(manager==nil)
    {
        manager = [[RequestManager alloc]init];
    }
    
    
    return manager;
}


-(void)setUpManger
{
    NSURL *baseUrl=[NSURL URLWithString:KBaseUrl];
    manager = [[AFHTTPRequestOperationManager manager]initWithBaseURL:baseUrl];
    
    manager.requestSerializer=[AFJSONRequestSerializer serializer];

}


-(void)updatePersonalLocationLatitude:(float)latitude longitude:(float)longitude success:(void (^)())successBlock failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failureBlock
{
    [self setUpManger];

    NSString *location=[NSString stringWithFormat:@"POINT(%f %f)",longitude,latitude];

    parameters=[NSDictionary dictionaryWithObjectsAndKeys:[DataManager shared].userId,@"userId",location,@"location", nil];
    
    [manager PUT:@"/api/Location/PutUpdateLocation" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Location Updated Success");

        successBlock();
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error Could not update location");
        failureBlock(operation,error);
    }];
}
-(void)updateSettingGendersuccess:(void (^)())successBlock failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failureBlock
{
    [self setUpManger];

    parameters=[NSDictionary dictionaryWithObjectsAndKeys:[DataManager shared].gender,@"gender",[DataManager shared].userId,@"userId", nil];
    [manager PUT:@"/api/User/PutSetting" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [[DataManager shared] saveSetting];
        successBlock();
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failureBlock(operation,error);
    }];
}



-(void)updateDeviceStatusUserId:(NSNumber *)userId isActive:(BOOL)active success:(void (^)())successBlock failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failureBlock
{
    [self setUpManger];

parameters=[[NSDictionary alloc]initWithObjectsAndKeys:[DataManager shared].userId,@"userId",[NSNumber numberWithBool:active],@"Foreground", nil];

//    [manager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@",[DataManager shared].Token ] forHTTPHeaderField:@"Authorization"];
[manager PUT:@"api/Device/PutDeviceForeground" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {

    
} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    NSLog(@"Error  did not set new deivce, controller api/Device/PostDevice");
    
}];
}

-(void)sendDeviceToken:(Device *)device success:(void (^)())successBlock failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failureBlock
{
    [self setUpManger];

    parameters=[[NSDictionary alloc]initWithObjectsAndKeys:device
                .DeviceToken,@"deviceToken",device.DeviceType,@"deviceType",[DataManager shared].gender,@"gender", nil];
    
    //    [manager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@",[DataManager shared].Token ] forHTTPHeaderField:@"Authorization"];
    [manager POST:@"api/Device/PostDeviceToken" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [DataManager shared].userId=[responseObject objectForKey:@"userId"];
        [[DataManager shared] saveSetting];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error  did not set new deivce, controller api/Device/PostDevice");
        
    }];
}

-(void)createUsersuccess:(void (^)())successBlock failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failureBlock
{
    [self setUpManger];

    
    
    //    [manager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@",[DataManager shared].Token ] forHTTPHeaderField:@"Authorization"];
    NSString *duid=[[DataManager shared] getDUID];
    CLLocation * location=[LocationTracker sharedLocationManager].location;
    NSString *locationString=[NSString stringWithFormat:@"POINT(%f %f)",location.coordinate.longitude,location.coordinate.latitude];
    parameters=[[NSDictionary alloc]initWithObjectsAndKeys:[DataManager shared].gender,@"gender",duid,@"DUID",locationString,@"location", nil];

    [manager POST:@"api/User/PostCreateUser" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [[DataManager shared] parseUser:responseObject];
        [[DataManager shared] saveSetting];
        successBlock();
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error  did not set new deivce, controller api/Device/PostDevice");
        failureBlock(operation,error);
        
    }];
}
-(void)getUser:(NSString *)duid success:(void (^)(AFHTTPRequestOperation *operation))successBlock failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failureBlock
{
    parameters=[[NSDictionary alloc]initWithObjectsAndKeys:duid,@"DUID", nil];
    [self setUpManger];
    //    [manager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@",[DataManager shared].Token ] forHTTPHeaderField:@"Authorization"];
    [manager GET:@"api/User/GetUser" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if(operation.response.statusCode==202){ // got user
            [[DataManager shared] parseUser:responseObject];
        [[DataManager shared] saveSetting];
        
        }
        else if(operation.response.statusCode==200) // user does not exist m/f
        {
            
        }
        successBlock(operation);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error  did not set new deivce, controller api/Device/PostDevice");
        failureBlock(operation,error);
        
    }];

}


-(void)getBarsAroundMe:(void (^)(NSMutableArray * bars))successBlock failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failureBlock
{
    [self setUpManger];
    parameters=[[NSDictionary alloc]initWithObjectsAndKeys:[DataManager shared].userId,@"userId", nil];
    [manager GET:@"api/Bar/GetBarsAroundMe" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSMutableArray * bars=[NSMutableArray array];
        for(NSDictionary * dictionary in responseObject)
        {
            [bars addObject:[[Bar alloc] initWithDictionary:dictionary]];
        }
        successBlock(bars);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error  did not set new deivce, controller api/Device/PostDevice");
        failureBlock(operation,error);
        
    }];
    
}
@end
