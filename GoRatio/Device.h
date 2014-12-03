//
//  Device.h
//  StudyTree
//
//  Created by Ethan Keiser on 8/15/14.
//  Copyright (c) 2014 Ethan Keiser. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface Device : NSObject
-(id)initWith:(id)dev ;
-(void)setDevice;
@property(nonatomic,retain)NSNumber *DeviceId;
@property(nonatomic,retain)NSNumber *PersonPersonId;

@property(nonatomic,retain)NSString *DeviceToken;
@property(nonatomic,retain)NSString *DeviceType;
@property(nonatomic,assign)BOOL foreground;
-(void)resignDevice;
-(void)becomeActive;
-(void)saveToLocalDB;
@end
