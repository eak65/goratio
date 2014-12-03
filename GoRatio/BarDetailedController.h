//
//  BarDetailedController.h
//  GoRatio
//
//  Created by Ethan Keiser on 12/2/14.
//  Copyright (c) 2014 Ethan Keiser. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Bar.h"

@interface BarDetailedController : UIViewController
{
    Bar *bar;
}
@property (strong, nonatomic) IBOutlet UILabel *vicinity;
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *rating;
@property (strong, nonatomic) IBOutlet UILabel *menCount;
@property (strong, nonatomic) IBOutlet UILabel *womanCount;
-(id)initWithBar:(Bar * )tempbar;
@end
