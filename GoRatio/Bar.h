//
//  Bar.h
//  GoRatio
//
//  Created by Ethan Keiser on 11/30/14.
//  Copyright (c) 2014 Ethan Keiser. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
@interface Bar : NSObject
@property(nonatomic,strong)NSString * name;
@property(nonatomic,strong)NSString * rating;

@property(nonatomic,strong)NSString * vicinity;
@property(nonatomic,strong)NSNumber * maleCount;
@property(nonatomic,strong)NSNumber * Id;
@property(nonatomic,strong)CLLocation * location;
@property(nonatomic,assign)int total;
@property(nonatomic,strong)NSNumber * femaleCount;

-(id)initWithDictionary:(NSDictionary *)dictionary;
@end
