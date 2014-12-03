//
//  AppDelegate.m
//  GoRatio
//
//  Created by Ethan Keiser on 11/25/14.
//  Copyright (c) 2014 Ethan Keiser. All rights reserved.
//
#import "DataManager.h"
#import "AppDelegate.h"
#import "BarTableController.h"
#import "RequestManager.h"
#import "Device.h"
#import "InitialLoadingView.h"
#import "MessageManager.h"
//#import "DoAlertView.h"
#import "GenderSetting.h"
#import "constant.h"
@interface AppDelegate ()
{
    BOOL resigned;
}

@end

@implementation AppDelegate

-(void)updateConnectionString:(id) sender
{
    if([DataManager shared].userId){
        
        
        NSString * s=    [[DataManager shared].userId stringValue];
        [self.chat invoke:@"updateConnection" withArgs:@[s] completionHandler:^(id response, NSError *error) {
            
        }];
    }
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self setUpBackGroundLocation];

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    self.tabbarController=[[UITabBarController alloc]init];
    BarTableController * bar =[[BarTableController alloc] init];
    GenderSetting* gender=[[GenderSetting alloc]init];
    
    UINavigationController * nav=[[UINavigationController alloc] initWithRootViewController:bar];
    bar.title=@"Bars";
    gender.title=@"Settings";
    [self.tabbarController setViewControllers:[NSArray arrayWithObjects:gender,nav, nil]];
    self.tabbarController.selectedIndex=1;
    if(![DataManager shared].userId)
    {
        
        InitialLoadingView * initial=[[InitialLoadingView alloc]init];
        
        UINavigationController * nav=[[UINavigationController alloc]initWithRootViewController:initial];
        [nav setNavigationBarHidden:YES];
        self.window.rootViewController=nav;
    }
    else{

    self.window.rootViewController=self.tabbarController;
    }
    [self setUpSignalR];
    //[self getDeviceToken];

    if([DataManager shared].userId) // if userid Exist show load screen
    {
        [self startLocationIntervalUpdate];
        
    }
  
    [self.window makeKeyAndVisible];

    
    

    
    return YES;
}

-(void)setUpSignalR
{
    self.hubConnection = [SRHubConnection connectionWithURLString:KBaseUrl];
    self.hubConnection.delegate=self;
    
    self.chat = [self.hubConnection createHubProxy:@"signalrHub"];
    [self.chat on:@"feedUpdate" perform:[MessageManager shared] selector:@selector(feedUpdate:)];
    [self.chat on:@"updateConnectionString" perform:self selector:@selector(updateConnectionString:)];

   
}



-(void)getDeviceToken
{
    if(IS_OS_8_OR_LATER){
        //Right, that is the point
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeBadge
                                                                                             |UIUserNotificationTypeSound
                                                                                             |UIUserNotificationTypeAlert) categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    }
    else{
        //register to receive notifications
        UIRemoteNotificationType myTypes = UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound;
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:myTypes];
    }
}


- (void)SRConnectionDidOpen:(id <SRConnectionInterface>)connection
{
    NSLog(@"connection Open State Number %d",[connection state]);
    
    if([DataManager shared].userId){
        [self updateConnectionString:nil];
      
    }
    else
    {
        [self.hubConnection stop];
    }
    
}

- (void)SRConnectionWillReconnect:(id <SRConnectionInterface>)connection
{
    NSLog(@"connection will reconnect %d",[connection state]);
    //   [self.hubConnection stop];
    
}

- (void)SRConnectionDidReconnect:(id <SRConnectionInterface>)connection
{
    NSLog(@"connection did Reconnect %d",[connection state]);
    
}
- (void)SRConnection:(id <SRConnectionInterface>)connection didReceiveData:(id)data
{
    NSLog(@"connection did recieve data %d",[connection state]);
    NSLog(@"%@",data);
    
}

- (void)SRConnectionDidClose:(id <SRConnectionInterface>)connection
{    NSLog(@"connection did close %d",[connection state]);
    
    
    //  UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Closed" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
    //   [alert show];
    
    if([DataManager shared].userId&&!resigned){
        //  if(debug==0)
        //  else
        //    [self.hubConnection start];
        //  [self reconnection];
        NSLog(@"DATE TIME : %@",[NSDate date]);
        dispatch_async(dispatch_get_main_queue(), ^{
            self.disconnectTimer = [NSTimer scheduledTimerWithTimeInterval:2.0
                                                                    target:self selector:@selector(reopen) userInfo:nil repeats: NO];
        });
        

    }
    else if(resigned){
        NSLog(@"%@",[DataManager shared].device);
        //[[DataManager shared].device resignForeground];
    }
    
}
-(void)reopen
{
    [self.hubConnection start];
    
}

- (void)SRConnection:(id <SRConnectionInterface>)connection didReceiveError:(NSError *)error
{
    NSLog(@"ERROR MESSAGE SIGNALR %@ %ld",[error.userInfo objectForKey:@"NSLocalizedDescription"],(long)error.code);

    if(error.code==0)
    {

    }
}


- (void)SRConnection:(id <SRConnectionInterface>)connection didChangeState:(connectionState)oldState newState:(connectionState)newState
{
    NSLog(@"old state %d",oldState);
    NSLog(@"%@",[connection connectionId]);
    NSLog(@"new state %d",newState);
    
}

- (void)SRConnectionDidSlow:(id <SRConnectionInterface>)connection
{
    
}

-(void)setUpBackGroundLocation
{
    UIAlertView * alert;
    
    //We have to make sure that the Background App Refresh is enable for the Location updates to work in the background.
    if([[UIApplication sharedApplication] backgroundRefreshStatus] == UIBackgroundRefreshStatusDenied){
        
        alert = [[UIAlertView alloc]initWithTitle:@""
                                          message:@"The app doesn't work without the Background App Refresh enabled. To turn it on, go to Settings > General > Background App Refresh"
                                         delegate:nil
                                cancelButtonTitle:@"Ok"
                                otherButtonTitles:nil, nil];
        [alert show];
        
    }else if([[UIApplication sharedApplication] backgroundRefreshStatus] == UIBackgroundRefreshStatusRestricted){
        
        alert = [[UIAlertView alloc]initWithTitle:@""
                                          message:@"The functions of this app are limited because the Background App Refresh is disable."
                                         delegate:nil
                                cancelButtonTitle:@"Ok"
                                otherButtonTitles:nil, nil];
        [alert show];
        
    } else{
        
        self.locationTracker = [[LocationTracker alloc]init];
        [self.locationTracker startLocationTracking];
        
        //Send the best location to server every 60 seconds
        //You may adjust the time interval depends on the need of your app.
        
    }
    
}
-(void)startLocationIntervalUpdate
{
    [self.locationTracker updateLocationToServer];

    NSTimeInterval time = 60.0;
    self.locationUpdateTimer =
    [NSTimer scheduledTimerWithTimeInterval:time
                                     target:self
                                   selector:@selector(updateLocation)
                                   userInfo:nil
                                    repeats:YES];
}




-(void)updateLocation {
    NSLog(@"updateLocation");
    
    [self.locationTracker updateLocationToServer];
}







#ifdef __IPHONE_8_0
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    //register to receive notifications
    [application registerForRemoteNotifications];
}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void(^)())completionHandler
{
    //handle the actions
    if ([identifier isEqualToString:@"declineAction"]){
    }
    else if ([identifier isEqualToString:@"answerAction"]){
    }
}
#endif

// If I get the token tell the server who I am, get my UserId
- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
    NSLog(@"My token is: %@", deviceToken);
    
    
    
    Device * device= [[Device alloc]init];
    
    device.deviceToken=[NSString stringWithFormat:@"%@",deviceToken ];
    device.deviceType=@"ios";
    device.foreground=YES;
    [[RequestManager shared] sendDeviceToken:device success:^{
        

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error did not send token");
    }];

    //  [self setDevice:device];
    
    //  device.deviceId=[userDefaults objectForKey:@"deviceId"];
    //  if(device.deviceId)
    // {
    //     [DataManager shared].device=[[Device alloc]initWith:userDefaults];
    // }
    // else
    // {
    
    
    //}
    
    
}

- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
    NSLog(@"Failed to get token, error: %@", error);
}
-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    
}

- (void)application:(UIApplication *)app didReceiveLocalNotification:(UILocalNotification *)notif {
    
    
}



















- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    resigned=YES;
    [self.hubConnection stop];

}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    resigned=NO;
    if([DataManager shared].userId)
    {
    [self.hubConnection start];
    [self.locationTracker updateLocationToServer];

    }

}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.ethan.GoRatio" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"GoRatio" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"GoRatio.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
