//
//  Bar.m
//  GoRatio
//
//  Created by Ethan Keiser on 11/30/14.
//  Copyright (c) 2014 Ethan Keiser. All rights reserved.
//

#import "Bar.h"

@implementation Bar


-(id)initWithDictionary:(NSDictionary *)dictionary
{
  self.Id=[NSNumber numberWithInt:[[dictionary objectForKey:@"Id"] intValue]];
    self.name=[dictionary objectForKey:@"Name"];
    self.vicinity=[dictionary objectForKey:@"Vicinity"];
    self.rating=[dictionary objectForKey:@"Rating"];

    self.maleCount=[NSNumber numberWithInt:[[dictionary objectForKey:@"MaleCount"] intValue]];
    self.femaleCount=[NSNumber numberWithInt:[[dictionary objectForKey:@"FemaleCount"] intValue]];

    return self;
}
@end
