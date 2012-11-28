//
//  PruchaseViewController.m
//  SampleSeminar
//
//  Created by Kenji Tazawa on 12/07/23.
//  Copyright (c) 2012年 CONIT Co., Ltd. All rights reserved.
//

#import "PruchaseViewController.h"
#import "Book.h"
#import "DownloadFile.h"
#import "FileListDao.h"
#import "FileDownloadDao.h"
#import "CustomIndicator.h"
#import "ReadBookViewController.h"
#import "PurchasedBookCoreDataManager.h"
#import "PurchasedBook.h"
#import "StoreKitManager.h"

@interface PruchaseViewController ()

/*
 * 前画面に戻ります。
 */
- (void) back:(id)sender;

/*
 * NavigationBarを初期化（カスタマイズ）します。
 */
- (void) customiseNavigationItem;

/*
 * SamuraiPurchaseからファイルリストを取得します。
 * @param 無料:nil 有料:必須
 */
- (void) fileListWithReceipt:(NSString *)receipt;

/*
 *ダウンロード処理を実行します。
 */
- (void) startDownload:(DownloadFile *)downloadFile;

/*
 *購入ボタンのタイトルを読むに変更します。
 */
- (void) setPurchaseBtnRead;

/*
 *インジケータを非表示にします。
 */
- (void) dismissIndicator;

/*
 *書籍データ(htmlファイル)の有無を確認します。
 */
- (BOOL) isHtmlFileExists;

/*
 *書籍のダウンロード処理のキャンセル、デリゲートの破棄を行います。
 */
- (void) clearDao;

- (void) appDidEnterBackground:(NSNotification *)notification;


/*
 * 書籍購入情報をアップデートします。（有料書籍対象メソッド）
 */
- (void)updatePurcahsedBook;

/*
 * 書籍購入情報をインサートします。
 * 無料書籍はaReceiptにnil指定して下さい。
 */
- (void)insertPurcahsedBook:(NSData *)aReceipt;

@end

@implementation PruchaseViewController {
  CustomIndicator *customIndicator;
  FileListDao     *fileListDao;
  FileDownloadDao *fileDownloadDao;
  StoreKitManager *storeKitManager;
}

@synthesize book          = _book;
@synthesize purchaseTitle = _purchaseTitle;
@synthesize purchaseAutor = _purchaseAutor;
@synthesize purchaseBtn   = _purchaseBtn;

- (id)initWithCoder:(NSCoder *)aDecoder
{
  if ((self = [super initWithCoder:aDecoder])) {
    fileListDao               = [[FileListDao alloc] init];
    fileListDao.delegate      = self;
    fileDownloadDao           = [[FileDownloadDao alloc] init];
    fileDownloadDao.delegate  = self;
    storeKitManager           = [[StoreKitManager alloc] init];
    storeKitManager.delegate_ = self;
  }
  return(self);
}

- (void)viewDidLoad
{
  [super viewDidLoad];

  //バックグラウンド移行処理
  if (&UIApplicationDidEnterBackgroundNotification) {
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(appDidEnterBackground:)
     name:UIApplicationDidEnterBackgroundNotification
     object:[UIApplication sharedApplication]];
  }

  customIndicator = [[CustomIndicator alloc] init];

  self.purchaseTitle.text = self.book.title;
  self.purchaseAutor.text = self.book.outline;
  if (self.book.isFree) {
    [self.purchaseBtn setTitle:@"ダウンロード" forState:UIControlStateNormal];
  }else {
    [self.purchaseBtn setTitle:@"有料" forState:UIControlStateNormal];
  }
  self.navigationItem.title = self.book.title;

  [self customiseNavigationItem];

  //ボタンタイトルの設定
  if ([self isHtmlFileExists]) {
    [self setPurchaseBtnRead];
    return;
  }

  //レシート取得後、ネットワークエラーなどでダウンロードできなかったまたはキャンセルしたケースを考慮
  //DBから該当プロダクトIDを条件にデータを取得、取得したデータがレシートを保持している場合は「ダウンロード」ボタンにする
  PurchasedBookCoreDataManager *manager = [PurchasedBookCoreDataManager sharedInstance];
  PurchasedBook                *pb      =
    (PurchasedBook *)[manager fetch:PURCHASED_BOOK_ENTITY_NAME productId:self.book.productId];

  if (pb != nil) {
    if ([pb.purchased isEqualToNumber:[NSNumber numberWithInt:1]]) {
      [self setPurchaseBtnRead];
    }else {
      [self.purchaseBtn setTitle:@"ダウンロード" forState:UIControlStateNormal];
    };

    return;
  }
}

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
}

- (void)viewDidUnload
{
  Log(@"viewDidUnload");
  [self setPurchaseTitle:nil];
  [self setPurchaseAutor:nil];
  [self setPurchaseBtn:nil];
  customIndicator = nil;

  [super viewDidUnload];
}

- (void)dealloc
{
  [self clearDao];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
  return(interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
  if ([[segue identifier] isEqualToString:@"readBookSegue"]) {
    ReadBookViewController *controller = [segue destinationViewController];
    controller.bookPath =
      [FileManageUtil getCachePathWithSPDirectoryHtmlFileName:self.book.productId];
  }
}

#pragma mark - Storyborad Method
- (IBAction)purchase:(id)sender
{
  if (![self isHtmlFileExists]) {
    [self.purchaseBtn setEnabled:NO];

    if (self.book.isFree) {
      [self fileListWithReceipt:nil];
    }else {
      PurchasedBookCoreDataManager *manager = [PurchasedBookCoreDataManager sharedInstance];
      PurchasedBook                *pb      =
        (PurchasedBook *)[manager fetch:PURCHASED_BOOK_ENTITY_NAME productId:self.book.productId];

      if (pb.receipt == nil) {
        [IndicatorUtil showCustomIndicator:customIndicator parentView:self.view];
        NSSet *productSet = [NSSet setWithObject:self.book.productId];
        [storeKitManager requestProduct:productSet];
      }else {
        [self fileListWithReceipt:[DataUtil base64WithData:pb.receipt]];
      }
    }
  }else {
    //読む画面に遷移
    [self performSegueWithIdentifier:@"readBookSegue" sender:self];
  }
}

#pragma mark - Private Method

- (void)customiseNavigationItem
{
  //戻るボタン生成
  UIImage  *backImg = [UIImage imageNamed:@"icon_back.png"];
  UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];

  [backBtn setImage:backImg forState:UIControlStateNormal];
  [backBtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchDown];
  self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
}

- (void)fileListWithReceipt:(NSString *)receipt
{
  [IndicatorUtil showCustomIndicator:customIndicator parentView:self.view];
  [fileListDao filelistWithProductId:self.book.productId receipt:receipt];
}

- (void)back:(id)sender
{
  [self.navigationController popViewControllerAnimated:YES];
}

- (void)startDownload:(DownloadFile *)downloadFile
{
  [fileDownloadDao fileWithDownloadUrl:downloadFile];
}

- (BOOL)isHtmlFileExists
{
  NSString *filePath = [FileManageUtil getCachePathWithSPDirectoryHtmlFileName:self.book.productId];

  return([FileManageUtil isFileExists:filePath]);
}

- (void)setPurchaseBtnRead
{
  [self.purchaseBtn setTitle:@"読む" forState:UIControlStateNormal];
}

- (void)dismissIndicator
{
  [IndicatorUtil dismissCustomIndicator:customIndicator];
}

- (void)clearDao
{
  if (fileListDao != nil) {
    [fileListDao cancelConnection];
    fileDownloadDao.delegate = nil;
  }
  if (fileDownloadDao != nil) {
    [fileDownloadDao cancelConnection];
    fileDownloadDao.delegate = nil;
  }
}

- (void)appDidEnterBackground:(NSNotification *)notification
{
  if (fileListDao) {
    [fileListDao cancelConnection];
  }
  if (fileDownloadDao) {
    [fileDownloadDao cancelConnection];
  }
  [self.purchaseBtn setEnabled:YES];
  [self dismissIndicator];
}

- (void)insertPurcahsedBook:(NSData *)aReceipt
{
  PurchasedBookCoreDataManager *manager = [[PurchasedBookCoreDataManager alloc] init];

  PurchasedBook                *pb =
    (PurchasedBook *)[manager entityForInsert:PURCHASED_BOOK_ENTITY_NAME];

  pb.productId     = self.book.productId;
  pb.title         = self.book.title;
  pb.author        = self.book.outline;
  pb.purchasedDate = [NSDate date];
  pb.payment       = [[NSNumber alloc] initWithBool:self.book.isFree];
  pb.purchased     = [NSNumber numberWithBool:YES];
  if (aReceipt != nil && !self.book.isFree) {
    pb.receipt = aReceipt;
  }
  [manager save];
}

- (void)updatePurcahsedBook
{
  PurchasedBookCoreDataManager *manager = [[PurchasedBookCoreDataManager alloc] init];

  PurchasedBook                *pb =
    (PurchasedBook *)[manager fetch:PURCHASED_BOOK_ENTITY_NAME productId:self.book.productId];

  pb.title         = self.book.title;
  pb.author        = self.book.outline;
  pb.purchasedDate = [NSDate date];
  pb.payment       = [[NSNumber alloc] initWithBool:self.book.isFree];
  pb.purchased     = [NSNumber numberWithBool:YES];

  [manager save];
}

#pragma mark - FileListDaoDelegate Method

- (void)didFinishFileList:(NSMutableArray *)fileListArray
{
//当アプリケーションでは取得できるファイルが１つのみとした前提で実装しています
  DownloadFile *downloadFile = [fileListArray objectAtIndex:0];

  [self startDownload:downloadFile];
}

- (void)didFailWithAPIError:(NSString *)status message:(NSString *)message
{
  NSLog(@"%@ %@", status, message);
  [self dismissIndicator];
  [self.purchaseBtn setEnabled:YES];
  [AlertViewUtil showErrorAlertView:@"書籍のダウンロードに失敗しました。"];
}

- (void)didFailWithNetworkError:(NSError *)error
{
  NSString *err = [NSString stringWithFormat : @"%d", error.code];

  Log(@"Connection failed! Error - %@ %@ :code:%@",
      [error localizedDescription],
      [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey], err);

  [self dismissIndicator];
  [self.purchaseBtn setEnabled:YES];
  [AlertViewUtil showErrorAlertView:@"書籍のダウンロードに失敗しました。"];
}

- (void)connection:(NSURLConnection *)connection
  didFailWithError:(NSError *)error
{
  NSString *err = [NSString stringWithFormat : @"%d", error.code];

  Log(@"Connection failed! Error - %@ %@ :code:%@",
      [error localizedDescription],
      [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey], err);

  [self dismissIndicator];
  [self.purchaseBtn setEnabled:YES];
  [AlertViewUtil showErrorAlertView:@"書籍のダウンロードに失敗しました。"];
}

#pragma mark - FileDownloadDaoDelegate

- (void)didFinishSaveFile:(BOOL)isSaved
{
  if (isSaved) {
    if (self.book.isFree) {
      //無料はinsert処理
      [self insertPurcahsedBook:nil];
    }else {
      //有料の場合はin app purchaseでの購入処理が完了した時点(successPayment)でレシート情報を保存しているため、update処理となっている
      [self updatePurcahsedBook];
    }

    [self setPurchaseBtnRead];
  }else {
    [AlertViewUtil showErrorAlertView:@"書籍の保存に失敗しました。容量の確認をして再ダウンロードしてください。"];
  }
  [self dismissIndicator];
  [self.purchaseBtn setEnabled:YES];
}

#pragma mark - StoreKitUtilDelegate Method

- (void)receiveProduct:(SKProduct *)aProduct
{
  Log(@"%s", __PRETTY_FUNCTION__);
  [IndicatorUtil dismissCustomIndicator:customIndicator];

  if (!aProduct) {  // 失敗
    [AlertViewUtil showErrorAlertView:@"購入情報を取得できませんでした。"];
    [self.purchaseBtn setEnabled:YES];
    return;
  }

  // プロダクト購入処理
  [storeKitManager requestPurchase:aProduct];
}

- (void)successPayment:(NSString *)aProductId receipt:(NSData *)aReceipt
{
  Log(@"%s", __PRETTY_FUNCTION__);

  [self insertPurcahsedBook:aReceipt];
  [self fileListWithReceipt:[DataUtil base64WithData:aReceipt]];
}

// 購入キャンセル／エラー処理
- (void)failedPayment:(BOOL)isCancel
{
  Log(@"%s", __PRETTY_FUNCTION__);
  [storeKitManager removeTransaction];
  [self.purchaseBtn setEnabled:YES];
}

@end
