//
//  TableDataManager.m
//  SampleSeminar
//
//  Created by Kenji Tazawa on 12/07/30.
//  Copyright (c) 2012年 CONIT Co., Ltd. All rights reserved.
//

#import "TableDataManager.h"

@implementation TableDataManager {
  BookDataManager4New   *bookDataManager4New;
  BookDataManager4Rank  *bookDataManager4Rank;
  BookDataManager4Title *bookDataManager4Title;

  BookDataManager       *bookDataManager;
}

- (id)init
{
  self = [super init];
  if (self) {
    bookDataManager4New   = [[BookDataManager4New alloc] init];
    bookDataManager4Rank  = [[BookDataManager4Rank alloc] init];
    bookDataManager4Title = [[BookDataManager4Title alloc] init];

    bookDataManager4New.isFirstLoaded   = NO;
    bookDataManager4Rank.isFirstLoaded  = NO;
    bookDataManager4Title.isFirstLoaded = NO;

    bookDataManager4New.isSelected = YES;
  }
  return(self);
}

#pragma mark - Private Method

- (void)setSelectedId:(NSInteger)newId
{
  switch (newId)
  {
  case SELECTED_NEW:
    bookDataManager                  = bookDataManager4New;
    bookDataManager4New.isSelected   = YES;
    bookDataManager4Rank.isSelected  = NO;
    bookDataManager4Title.isSelected = NO;
    break;

  case SELECTED_RANK:
    bookDataManager                  = bookDataManager4Rank;
    bookDataManager4New.isSelected   = NO;
    bookDataManager4Rank.isSelected  = YES;
    bookDataManager4Title.isSelected = NO;
    break;

  case SELECTED_TITLE:
    bookDataManager                  = bookDataManager4Title;
    bookDataManager4New.isSelected   = NO;
    bookDataManager4Rank.isSelected  = NO;
    bookDataManager4Title.isSelected = YES;
    break;

  default:
    break;
  }
}

- (NSMutableArray *)bookData
{
  return([bookDataManager bookData]);
}

- (void)clear
{
  [bookDataManager clear];
}

- (void)cellForRowWithSegmentedId:(BookCell *)bookCell bookData:(Book *)book
{
  [bookDataManager cellForRowWithSegmentedId:bookCell bookData:book];
}

- (void)obtainBookDataFromSamuraiPurchase
{
  [bookDataManager doRequestBookDataFromSamuraiPurchase];
}

- (BOOL)isFirstLoaded
{
  return(bookDataManager.isFirstLoaded);
}

- (void)setFirstLoaded:(BOOL)isLoaded
{
  bookDataManager.isFirstLoaded = isLoaded;
}

- (BOOL)isFinishLoaded
{
  return(bookDataManager.isFinishLoaded);
}

- (void)setFinishLoaded:(BOOL)isFinishLoaded
{
  bookDataManager.isFinishLoaded = isFinishLoaded;
}

- (BOOL)isLoading
{
  return(bookDataManager.isLoading);
}

- (void)setLoading:(BOOL)isLoading
{
  bookDataManager.isLoading = isLoading;
}

- (void)setDelegate:(id<BookListManagerDelegate> )delgate
{
  bookDataManager4New.delegate   = delgate;
  bookDataManager4Rank.delegate  = delgate;
  bookDataManager4Title.delegate = delgate;
}

- (void)cancelObtainBookDataFromSamuraiPurchase
{
  if (bookDataManager4New) {
    [bookDataManager4New cancelRequestBookDataFromSamuraiPurchase];
  }
  if (bookDataManager4Rank) {
    [bookDataManager4Rank cancelRequestBookDataFromSamuraiPurchase];
  }
  if (bookDataManager4Title) {
    [bookDataManager4Title cancelRequestBookDataFromSamuraiPurchase];
  }
}

@end
