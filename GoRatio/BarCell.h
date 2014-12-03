//
//  BarCell.h
//  GoRatio
//
//  Created by Ethan Keiser on 11/30/14.
//  Copyright (c) 2014 Ethan Keiser. All rights reserved.
//
#import "DXStarRatingView.h"
#import <UIKit/UIKit.h>
#import "Bar.h"
@interface BarCell : UITableViewCell
{
    Bar *bar;
    int total;
}
@property (strong, nonatomic) IBOutlet UILabel *barName;
@property (strong, nonatomic) IBOutlet UILabel *address;
@property (strong, nonatomic) IBOutlet UILabel *totalPeopleLabel;
@property (strong, nonatomic) IBOutlet DXStarRatingView *starView;

@property (strong, nonatomic) IBOutlet UIImageView *positiveArrow;
@property (strong, nonatomic) IBOutlet UILabel *tickerNumber;
@property (strong, nonatomic) IBOutlet UILabel *attendanceRange;
@property (strong, nonatomic) IBOutlet UIImageView *negativeArrow;
@property (strong, nonatomic) IBOutlet UIView *tickerOverlay;


-(id)initWithCellId:(NSString *)cellId;
-(void)setBar:(Bar *)bar;

-(void)showPositiveAmount:(int)amount;
-(void)showNegativeAmount:(int)amount;
@end
