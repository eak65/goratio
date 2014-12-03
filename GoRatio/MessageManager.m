//
//  MessageManager.m
//  GoRatio
//
//  Created by Ethan Keiser on 12/2/14.
//  Copyright (c) 2014 Ethan Keiser. All rights reserved.
//

#import "MessageManager.h"

@implementation MessageManager

MessageManager *manager;
+(MessageManager *)shared
{
    if(manager==nil)
    {
        
        manager=[[MessageManager alloc] init];
    }
    return manager;
}

-(void)feedUpdate:(id)sender
{
    if([[sender objectForKey:@"type"]isEqualToString:@"incrementBar"])
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"incrementBar" object:sender];
    }
    else if([[sender objectForKey:@"type"]isEqualToString:@"decrementBar"])
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"decrementBar" object:sender];

    }
}
@end
