//
//  CoreDataManager.m
//  UsedCoreData
//
//  Created by Yuka on 11/02/24.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CoreDataManager.h"

@implementation CoreDataManager

@synthesize managedObjectContext_       = managedObjectContext;
@synthesize managedObjectModel_         = managedObjectModel;
@synthesize persistentStoreCoordinator_ = persistentStoreCoordinator;

static CoreDataManager *instance = nil;

+ (CoreDataManager *)sharedInstance
{
  @synchronized(self)
  {
    if (instance == nil) {
      instance = [[self alloc] init];
    }
  }
  return(instance);
}

- (void)saveContext
{
  NSError                *error   = nil;
  NSManagedObjectContext *context = self.managedObjectContext_;

  if (context != nil) {
    if ([context hasChanges] && ![context save:&error]) {
      /*
       * Replace this implementation with code to handle the error appropriately.
       *
       * abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
       */
      Log(@"Unresolved error %@, %@", error, [error userInfo]);
      abort();
    }
  }
}

/*
 *初期化処理：管理対象オブジェクトコンテキストの生成
 */
- (NSManagedObjectContext *)managedObjectContext_
{
  if (managedObjectContext != nil) {
    return(managedObjectContext);
  }

  NSPersistentStoreCoordinator *coordinator = self.persistentStoreCoordinator_;
  if (coordinator != nil) {
    managedObjectContext = [[NSManagedObjectContext alloc] init];
    [managedObjectContext setPersistentStoreCoordinator:coordinator];
  }
  return(managedObjectContext);
}

/**
 * Returns the managed object model for the application.
 * If the model doesn't already exist, it is created from the application's model.
 *初期化処理：管理対象オブジェクトモデルの生成
 */
- (NSManagedObjectModel *)managedObjectModel_
{
  if (managedObjectModel != nil) {
    return(managedObjectModel);
  }

  NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"SampleSeminar" withExtension:@"momd"];
  managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
  return(managedObjectModel);
}

/**
 * Returns the persistent store coordinator for the application.
 * If the coordinator doesn't already exist, it is created and the application's store added to it.
 *初期化処理：永続ストアコーディネーターの生成
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator_
{
  if (persistentStoreCoordinator != nil) {
    return(persistentStoreCoordinator);
  }

  NSArray  *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                        NSUserDomainMask, YES);
  NSString *documentsDirectory = [paths objectAtIndex:0];
  NSString *myPathDocs         =
    [documentsDirectory stringByAppendingPathComponent:@"SampleSeminar.sqlite"];
  NSURL    *storeURL = [NSURL fileURLWithPath:myPathDocs];

  NSError  *error = nil;
  persistentStoreCoordinator =
    [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel_];
  if (![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil
        URL:storeURL options:nil error:&error]) {
    /*
     * Replace this implementation with code to handle the error appropriately.
     *
     * abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
     *
     * Typical reasons for an error here include:
     * The persistent store is not accessible;
     * The schema for the persistent store is incompatible with current managed object model.
     * Check the error message to determine what the actual problem was.
     *
     *
     * If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
     *
     * If you encounter schema incompatibility errors during development, you can reduce their frequency by:
     * Simply deleting the existing store:
     * [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
     *
     * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
     * [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES],NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
     *
     * Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
     *
     */
    Log(@"Unresolved error %@, %@", error, [error userInfo]);
    abort();
  }

  return(persistentStoreCoordinator);
}

@end
