//
//  BarDetailedController.m
//  GoRatio
//
//  Created by Ethan Keiser on 12/2/14.
//  Copyright (c) 2014 Ethan Keiser. All rights reserved.
//

#import "BarDetailedController.h"

@interface BarDetailedController ()

@end

@implementation BarDetailedController


-(id)initWithBar:(Bar * )tempbar
{
    self=[super init];
    bar=tempbar;

    
    
    // example
    bar.maleCount=[NSNumber numberWithInt:75];
    bar.femaleCount=[NSNumber numberWithInt:100];

    
    return  self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.name.text=bar.name;
    self.vicinity.text=bar.vicinity;
    self.rating.text=bar.rating;

double menTotal=([bar.maleCount doubleValue]/([bar.maleCount doubleValue]+[bar.femaleCount doubleValue]))*100;
    
double female=([bar.femaleCount doubleValue]/([bar.femaleCount doubleValue]+[bar.maleCount doubleValue]))*100;
    
    
    self.menCount.text=[NSString stringWithFormat:@"%.0f%%",menTotal];
    self.womanCount.text=[NSString stringWithFormat:@"%.0f%%",female];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



@end
