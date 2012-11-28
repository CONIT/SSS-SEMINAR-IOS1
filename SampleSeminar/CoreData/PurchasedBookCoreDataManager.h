//
//  CdDataCoreData.h
//  Main
//
//  Created by Yuka Wada on 11/11/21.
//  Copyright (c) 2011 CONIT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreDataManager.h"

@interface PurchasedBookCoreDataManager : CoreDataManager<NSFetchedResultsControllerDelegate>

+ (PurchasedBookCoreDataManager *)sharedInstance;
- (NSArray *)fetch:(NSString *)aEntityName limit:(int)aLimit;
- (id)fetch:(NSString *)aEntityName productId:(NSString *)aProductId;
- (NSArray *)all:(NSString *)entityName;
- (NSArray *)allPurchased:(NSString *)entityName;
- (NSInteger)countEntity:(NSString *)aEntityName;

- (NSManagedObject *)entityForInsert:(NSString *)entityname;
- (void)entityForDelete:(NSManagedObject *)aManagedObject;
- (void)deleteAll:(NSString *)aEntityName;
- (BOOL)save;

@end
