//
//  BookDataManager.m
//  SampleSeminar
//
//  Created by Kenji Tazawa on 12/07/30.
//  Copyright (c) 2012年 CONIT Co., Ltd. All rights reserved.
//

#import "BookDataManager.h"
#import "BookListDao.h"
#import "SPProductParam.h"

@interface BookDataManager ()

/*
 * エラー発生時の共通処理です。処理結果のフラグ管理とUI描画の通知を行います。
 */
- (void) didErrorCommon;
@end

@implementation BookDataManager {
  /*SramuraiPurchaseへのデータアクセスオブジェクト*/
  BookListDao *bookListDao;

  /*書籍データ*/
  NSMutableArray *bookArray;
}

@synthesize delegate;
@synthesize isFirstLoaded  = _isFirstLoaded;
@synthesize offset         = _offset;
@synthesize isFinishLoaded = _isFinishLoaded;
@synthesize isLoading      = _isLoading;
@synthesize isSelected     = _isSelected;

- (id)init
{
  self = [super init];
  if (self) {
    bookArray            = [[NSMutableArray alloc] init];
    bookListDao          = [[BookListDao alloc] init];
    bookListDao.delegate = self;
  }
  return(self);
}

#pragma mark - Public Method
- (void)addBookData:(NSMutableArray *)obtainedBookArray
{
  for (Book *book in obtainedBookArray)
  {
    [bookArray  addObject:book];
  }
}

- (NSMutableArray *)bookData
{
  return([[NSMutableArray alloc] initWithArray:bookArray]);
}

- (void)clear
{
  self.offset         = 0;
  self.isFirstLoaded  = NO;
  self.isFinishLoaded = NO;
  self.isLoading      = NO;
  //ViewContlloerでどのリストが表示されているか必要なため対象外とする
  //self.isSelected     = NO;

  [bookArray removeAllObjects];
}

- (void)doRequestBookDataFromSamuraiPurchase
{
  [bookListDao bookListWithSPparam:[self generateSPPParam]];
}

- (void)cancelRequestBookDataFromSamuraiPurchase
{
  [bookListDao cancelConnection];
}

- (void)cellForRowWithSegmentedId:(BookCell *)bookCell bookData:(Book *)book
{
  //継承先で実装
}

- (SPProductParam *)generateSPPParam
{
  //継承先で実装
  return([[SPProductParam alloc] init]);
}

#pragma mark - Private Method
- (void) didErrorCommon
{
  self.isLoading = NO;
  if ([self isSelected]) {
    [(id < BookListManagerDelegate >) delegate didError];
  }
};

#pragma mark - BookListDaoDelegate
- (void)didFinishBookList:(NSMutableArray *)bookListArray
{
  [self addBookData:bookListArray];
  self.offset = self.offset + UNIT_COUNT;

  if ([self isSelected]) {
    [(id < BookListManagerDelegate >) delegate didFinishBookList:bookListArray];
  }else {
    //ViewControllerに反映しない場合はフラグの更新のみを行なう
    if (!self.isFirstLoaded) {
      self.isFirstLoaded = YES;
    }
    if ([bookListArray count] == 0) {
      self.isFinishLoaded = YES;
    }
    self.isLoading = NO;
  }
}

- (void)didFailWithAPIError:(NSString *)status message:(NSString *)message
{
  Log(@"%@ %@", status, message);
  [self didErrorCommon];
}

- (void)didFailWithNetworkError:(NSError *)error
{
  NSString *err = [NSString stringWithFormat : @"%d", error.code];

  Log(@"Connection failed! Error - %@ %@ :code:%@",
      [error localizedDescription],
      [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey], err);
  [self didErrorCommon];
}

@end
