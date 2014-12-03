//
//  MessageManager.h
//  GoRatio
//
//  Created by Ethan Keiser on 12/2/14.
//  Copyright (c) 2014 Ethan Keiser. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageManager : NSObject

+(MessageManager *)shared;
-(void)feedUpdate:(id)sender;
@end
