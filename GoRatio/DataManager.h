//
//  DataManager.h
//  GoRatio
//
//  Created by Ethan Keiser on 11/25/14.
//  Copyright (c) 2014 Ethan Keiser. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Device.h"
@interface DataManager : NSObject

@property(nonatomic, strong)NSNumber *gender;
@property(nonatomic, strong)Device *device;
@property(nonatomic, strong)NSNumber *userId;
@property(nonatomic, strong)NSString *DUID;

-(void)saveSetting;
-(void)loadSetting;
-(void)parseUser:(NSDictionary *)dict;
-(NSString*)getDUID;
+(DataManager *)shared;



@end
