//
//  BarCell.m
//  GoRatio
//
//  Created by Ethan Keiser on 11/30/14.
//  Copyright (c) 2014 Ethan Keiser. All rights reserved.
//

#import "BarCell.h"
#import <FlatUIKit.h>

@implementation BarCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(id)initWithCellId:(NSString *)cellId
{
    
        self = [[BarCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        
        NSArray *topLevelObjects=[[NSBundle mainBundle] loadNibNamed:@"BarCell" owner:nil options:nil];
        
        for(id currentObject in topLevelObjects)
            
        {
            
            if([currentObject isKindOfClass:[BarCell class]])
                
            {
                
                self=(BarCell *)currentObject;
                self.negativeArrow.hidden=YES;
                self.positiveArrow.hidden=YES;
                self.clipsToBounds=YES;
                total=0;
                self.tickerOverlay.layer.cornerRadius=.5;
                
                
                
                break;
                
            }
            
        }
    return self;
}

-(void)setBar:(Bar *)tbar
{
    bar=tbar;
    total=bar.total;
    self.barName.text=tbar.name;
    self.address.text=tbar.vicinity;
    self.starView.backgroundColor=[UIColor clearColor];
    self.backgroundColor=[UIColor midnightBlueColor];
    self.tickerNumber.text=[NSString stringWithFormat:@"%d",total ];

//    self.totalPeopleLabel.text=[NSString stringWithFormat:@"%d",total];
    [self setStarValue:[NSNumber numberWithInt:total]];
 
}

-(void)showPositiveAmount:(int)amount
{
    [self showPositiveColor];

    self.tickerNumber.text=[NSString stringWithFormat:@"%d",bar.total ];
    
    self.positiveArrow.hidden=NO;
    self.negativeArrow.hidden=YES;
}
-(void)showNegativeAmount:(int)amount
{
    [self showNegativeColor];
    self.tickerNumber.text=[NSString stringWithFormat:@"%d",bar.total];
    self.positiveArrow.hidden=YES;
    self.negativeArrow.hidden=NO;
}
-(void)showNegativeColor
{
    CABasicAnimation* fade = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    fade.fromValue = (id)[UIColor whiteColor].CGColor;
    fade.toValue = (id)[UIColor pomegranateColor].CGColor;
    [fade setDuration:.5];
    [self.tickerOverlay.layer addAnimation:fade forKey:@"fadeAnimation"];
}
-(void)showPositiveColor
{
    CABasicAnimation* fade = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    fade.fromValue = (id)[UIColor whiteColor].CGColor;
    fade.toValue = (id)[UIColor turquoiseColor].CGColor;
    [fade setDuration:.5];
    [self.tickerOverlay.layer addAnimation:fade forKey:@"fadeAnimation"];
}
-(void)setStarValue:(NSNumber *)num
{
    if([num intValue]>0&&[num intValue]<25)
    {
        [self.starView setStars:1];
    }
    else if([num intValue]>=25&&[num intValue]<50)
    {
        [self.starView setStars:2];

    }
    else if([num intValue]>=50&&[num intValue]<75)
    {
        [self.starView setStars:3];

    }
    else if([num intValue]>=75&&[num intValue]<100)
    {
        [self.starView setStars:4];

    }if([num intValue]>=100&&[num intValue]<150)
    {
        [self.starView setStars:5];

    }
}
@end
