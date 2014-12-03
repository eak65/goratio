//
//  RequestManager.h
//  GoRatio
//
//  Created by Ethan Keiser on 11/25/14.
//  Copyright (c) 2014 Ethan Keiser. All rights reserved.
//

#import <AFNetworking.h>
#import <Foundation/Foundation.h>
#import "Device.h"
@interface RequestManager : NSObject
{
    NSDictionary * parameters;
    AFHTTPRequestOperationManager * manager;
}
-(void)updatePersonalLocationLatitude:(float)latitude longitude:(float)longitude success:(void (^)())successBlock failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failureBlock;
-(void)updateSettingGendersuccess:(void (^)())successBlock failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failureBlock;

-(void)updateDeviceStatusUserId:(NSNumber *)userId isActive:(BOOL)active success:(void (^)())successBlock failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failureBlock;



-(void)sendDeviceToken:(Device *)device success:(void (^)())successBlock failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failureBlock;

-(void)getUser:(NSString *)duid success:(void (^)(AFHTTPRequestOperation *operation))successBlock failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failureBlock;
-(void)createUsersuccess:(void (^)())successBlock failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failureBlock;


-(void)getBarsAroundMe:(void (^)(NSMutableArray * bars))successBlock failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failureBlock;

+(RequestManager *)shared;
@end
