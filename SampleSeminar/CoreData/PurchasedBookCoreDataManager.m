//
//  CdDataCoreData.m
//  Main
//
//  Created by Yuka Wada on 11/11/21.
//  Copyright (c) 2011 CONIT. All rights reserved.
//

#import "PurchasedBookCoreDataManager.h"

@implementation PurchasedBookCoreDataManager {
  __strong NSFetchedResultsController *fetchedResultsController;
}

static PurchasedBookCoreDataManager *instance = nil;

+ (PurchasedBookCoreDataManager *)sharedInstance
{
  @synchronized(self)
  {
    if (instance == nil) {
      instance = [[self alloc] init];
    }
  }
  return(instance);
}

//******************************************************
//name
//	fetchedResultsController
//return
//	(NSFetchedResultsController *)
//******************************************************
- (NSFetchedResultsController *)fetchedResultsController
{
  if (fetchedResultsController != nil) {
    return(fetchedResultsController);
  }

  NSFetchRequest         *fetchRequest = [[NSFetchRequest alloc] init];
  NSManagedObjectContext *context      = self.managedObjectContext_;
  NSEntityDescription    *entity       =
    [NSEntityDescription entityForName:@"Content" inManagedObjectContext:context];

  NSSortDescriptor *sortDescriptor =
    [[NSSortDescriptor alloc] initWithKey:@"purchasedDate" ascending:YES];
  NSArray          *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
  [fetchRequest setSortDescriptors:sortDescriptors];

  [fetchRequest setEntity:entity];
  [fetchRequest setFetchBatchSize:20];

  NSFetchedResultsController *frc =
    [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
     managedObjectContext:self.managedObjectContext_
     sectionNameKeyPath:nil
     cacheName:@"Root"];
  frc.delegate             = self;
  fetchedResultsController = frc;

  return(fetchedResultsController);
}

//******************************************************
//name
//	fetch                   エンティティの取得
//param
//	(NSString *)entityName  エンティティ名
//  limit:(int)limit        取得数
//return
//	(NSArray *)
//******************************************************
- (NSArray *)fetch:(NSString *)aEntityName limit:(int)aLimit
{
  NSManagedObjectContext *context = self.managedObjectContext_;

  // リクエスト生成
  NSFetchRequest      *request = [[NSFetchRequest alloc] init];
  NSEntityDescription *entity  =
    [NSEntityDescription entityForName:aEntityName inManagedObjectContext:context];

  [request setEntity:entity];

  // ソート
  NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"purchasedDate" ascending:NO];
  [request setSortDescriptors:[NSArray arrayWithObject:sort]];

  // 取得数
  [request setFetchLimit:aLimit];

  // 取得実行
  NSError *error               = nil;
  NSArray *mutableFetchResults = [context executeFetchRequest:request error:&error];
  if (!mutableFetchResults) {
    Log(@"    : %@", error);
  }

  return(mutableFetchResults);
}
- (NSArray *)allPurchased:(NSString *)aEntityName
{
  NSManagedObjectContext *context = self.managedObjectContext_;

  // リクエスト生成
  NSFetchRequest      *request = [[NSFetchRequest alloc] init];
  NSEntityDescription *entity  =
    [NSEntityDescription entityForName:aEntityName inManagedObjectContext:context];

  [request setEntity:entity];

  // ソート
  NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"purchasedDate" ascending:NO];
  [request setSortDescriptors:[NSArray arrayWithObject:sort]];

  // 条件
  NSPredicate *predicate =
    [NSPredicate predicateWithFormat:@"purchased == %@", [NSNumber numberWithBool:YES]];

  [request setPredicate:predicate];

  // 取得数
  [request setFetchLimit:0];

  // 取得実行
  NSError *error               = nil;
  NSArray *mutableFetchResults = [context executeFetchRequest:request error:&error];
  if (!mutableFetchResults) {
    Log(@"    : %@", error);
  }

  return(mutableFetchResults);
}

- (NSArray *)all:(NSString *)entityName
{
  return([self fetch:entityName limit:0]);
}

- (id)fetch:(NSString *)aEntityName productId:(NSString *)aProductId
{
  NSManagedObjectContext *context = self.managedObjectContext_;

  // リクエスト生成
  NSFetchRequest      *request = [[NSFetchRequest alloc] init];
  NSEntityDescription *entity  =
    [NSEntityDescription entityForName:aEntityName inManagedObjectContext:context];

  [request setEntity:entity];

  // ソート
  NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"purchasedDate" ascending:NO];
  [request setSortDescriptors:[NSArray arrayWithObject:sort]];

  // 条件
  NSPredicate *predicate = [NSPredicate predicateWithFormat:@"productId == %@", aProductId];
  [request setPredicate:predicate];

  // 取得数
  [request setFetchLimit:1];

  // 取得実行
  NSError *error               = nil;
  NSArray *mutableFetchResults = [context executeFetchRequest:request error:&error];
  if (!mutableFetchResults || mutableFetchResults.count != 1) {
    Log(@"fetch error: %@", error);
    return(nil);
  }
  return([mutableFetchResults objectAtIndex:0]);
}

//******************************************************
//name
//	countEntity             エンティティ数の取得
//param
//	(NSString *)entityName   エンティティ名
//return
//	(NSUInteger)
//******************************************************
- (NSInteger)countEntity:(NSString *)aEntityName
{
  NSManagedObjectContext *context = self.managedObjectContext_;

  NSFetchRequest         *request = [[NSFetchRequest alloc] init];
  NSEntityDescription    *entity  =
    [NSEntityDescription entityForName:aEntityName inManagedObjectContext:context];

  [request setEntity:entity];

  NSError   *error = nil;
  NSInteger count  = [context countForFetchRequest:request error:&error];
  if (count == NSNotFound || error) {
    count = 0;
  }

  return(count);
}

//******************************************************
//name
//	entityForInsert         エンティティの追加
//param
//	(NSString*)entityname   エンティティ名
//return
//	(NSManagedObject *)
//******************************************************
- (NSManagedObject *)entityForInsert:(NSString *)entityname
{
  NSManagedObjectContext *context = self.managedObjectContext_;

  return([NSEntityDescription insertNewObjectForEntityForName:entityname inManagedObjectContext:
          context]);
}

//******************************************************
//name
//	entityForDelete                     エンティティの削除
//param
//	(NSManagedObject *)aManagedObject   削除オブジェクト
//return
//******************************************************
- (void)entityForDelete:(NSManagedObject *)aManagedObject
{
  NSManagedObjectContext *context = self.managedObjectContext_;

  [context deleteObject:aManagedObject];
}

//******************************************************
//name
//	save                    保存
//param
//return
//******************************************************
- (BOOL)save
{
  NSError *error = nil;

  if ([self.managedObjectContext_ save: &error] == NO) {
    Log(@"Unresolved error: %@: %@", error, [error userInfo]);
    return(NO);
  }
  Log(@"Save CoreData");
  return(YES);
}

//******************************************************
//name
//	deleteAll                    全件削除
//param
//return
//******************************************************
- (void)deleteAll:(NSString *)aEntityName
{
  NSArray                *array   = [self all:aEntityName];
  NSManagedObjectContext *context = self.managedObjectContext_;

  for (NSManagedObject *object in array)
  {
    [context deleteObject:object];
  }
}

#pragma mark - NSFetchedResultsControllerDelegate

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
  //操作完了時
  Log(@"%@", @"controllerDidChangeContent");
}

@end
