//
//  AppDelegate.h
//  GoRatio
//
//  Created by Ethan Keiser on 11/25/14.
//  Copyright (c) 2014 Ethan Keiser. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "LocationTracker.h"
#import "GenderController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property(strong,nonatomic )LocationTracker * locationTracker;
@property(strong,nonatomic )NSTimer * locationUpdateTimer;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

-(void)getDeviceToken;
@end

