//
//  CoreDataManager.h
//  UsedCoreData
//
//  Created by Yuka on 11/02/24.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface CoreDataManager : NSObject

@property (nonatomic, strong, readonly) NSManagedObjectContext       *managedObjectContext_;
@property (nonatomic, strong, readonly) NSManagedObjectModel         *managedObjectModel_;
@property (nonatomic, strong, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator_;

+ (CoreDataManager *)sharedInstance;
- (void)saveContext;

@end
