//
//  BarTableController.m
//  GoRatio
//
//  Created by Ethan Keiser on 11/25/14.
//  Copyright (c) 2014 Ethan Keiser. All rights reserved.
//

#import "BarTableController.h"
#import <FlatUIKit.h>
#import "GenderController.h"
#import "BarDetailedController.h"
#import "DataManager.h"
#import "MessageManager.h"
#import "InitialLoadingView.h"
@interface BarTableController ()
{
    NSMutableArray * barArray;
}

@end

@implementation BarTableController




-(void)willRefresh:(id)sender
{
    
   [[RequestManager shared]getBarsAroundMe:^(NSMutableArray *bars) {
      
       barArray=bars;
       [self didRefresh];
       [self.refreshControl endRefreshing];
   } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
       [self.refreshControl endRefreshing];

   }];
    
    
    
}
-(void)didRefresh
{
    [self.tableView reloadData];
    
}
-(void)incrementBar:(NSNotification *)sender
{
  int barId  =[[sender.object objectForKey:@"barId"] intValue];
    int amount =[[sender.object objectForKey:@"amount"]intValue];
   
    [barArray enumerateObjectsWithOptions:NSEnumerationConcurrent
                            usingBlock:^(Bar *item, NSUInteger idx, BOOL *stop)
    {
    
        if([item.Id intValue]==barId)
        {
          BarCell * barcell=  (BarCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForItem:idx inSection:0]];
            item.total+=amount;
            [barcell showPositiveAmount:amount];
            
        }
    }];
    //   sender
}
-(void)decrementbar:(NSNotification*)sender
{
    int barId  =[[sender.object objectForKey:@"barId"] intValue];
    int amount =[[sender.object objectForKey:@"amount"]intValue];
    
    
    [barArray enumerateObjectsWithOptions:NSEnumerationConcurrent
                               usingBlock:^(Bar *item, NSUInteger idx, BOOL *stop)
     {
         
         if([item.Id intValue]==barId)
         {
             BarCell * barcell=  (BarCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForItem:idx inSection:0]];
             item.total-=amount;

             [barcell showNegativeAmount:amount];

             
         }
     }];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(incrementBar:) name:@"incrementBar" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(decrementbar:) name:@"decrementBar" object:nil];

    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor wetAsphaltColor];
    self.refreshControl.tintColor = [UIColor whiteColor];
    [self.refreshControl addTarget:self
                            action:@selector(willRefresh:)
                  forControlEvents:UIControlEventValueChanged];
    
    self.view.backgroundColor=[UIColor groupTableViewBackgroundColor];
    
    [self willRefresh:nil];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated
{
  
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return barArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellId=@"CellId";
    BarCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if(cell==nil)
    {
        cell =[[BarCell alloc]initWithCellId:cellId];
    }
    Bar *bar=[barArray objectAtIndex:indexPath.row];
    [cell setBar:bar];

    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  Bar *bar=  [barArray objectAtIndex:indexPath.row];
    BarDetailedController * barDetail=[[BarDetailedController alloc]initWithBar:bar];
    [self.navigationController pushViewController:barDetail animated:YES];
    
}
-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 95.0f;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
