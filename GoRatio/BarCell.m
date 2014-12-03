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
            
                break;
                
            }
            
        }
    return self;
}

-(void)setBar:(Bar *)bar
{
    self.barName.text=bar.name;
    self.address.text=bar.vicinity;
    self.starView.backgroundColor=[UIColor clearColor];
    self.backgroundColor=[UIColor midnightBlueColor];
    int total= [bar.maleCount intValue]+[bar.femaleCount intValue];
    total =60;
    self.totalPeopleLabel.text=[NSString stringWithFormat:@"%d",total];
    [self setStarValue:[NSNumber numberWithInt:total]];
 
}

-(void)showPositiveIndicator
{
    [self showPositiveColor];
    self.positiveArrow.hidden=NO;
    self.negativeArrow.hidden=YES;
}
-(void)showNegativeIndicator
{
    [self showNegativeColor];
    self.positiveArrow.hidden=YES;
    self.negativeArrow.hidden=NO;
}
-(void)showNegativeColor
{
    CABasicAnimation* fade = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    fade.fromValue = (id)[UIColor whiteColor].CGColor;
    fade.toValue = (id)[UIColor amethystColor].CGColor;
    [fade setDuration:1];
    [self.layer addAnimation:fade forKey:@"fadeAnimation"];
}
-(void)showPositiveColor
{
    CABasicAnimation* fade = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    fade.fromValue = (id)[UIColor whiteColor].CGColor;
    fade.toValue = (id)[UIColor turquoiseColor].CGColor;
    [fade setDuration:.4];
    [self.layer addAnimation:fade forKey:@"fadeAnimation"];
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
