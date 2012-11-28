//
//  SeminarFirstViewController.m
//  SampleSeminar
//
//  Created by Kenji Tazawa on 12/07/18.
//  Copyright (c) 2012年 CONIT Co., Ltd. All rights reserved.
//

#import "TabStoreViewController.h"
#import "CustomUISegmentedControl.h"
#import "PruchaseViewController.h"
#import "Book.h"
#import "BookCell.h"
#import "ReadMoreCell.h"
#import "BookListDao.h"
#import "SPProductParam.h"
#import "TableDataManager.h"
#import "CustomIndicator.h"

@interface TabStoreViewController (){
  /*表示している書籍データ*/
  NSMutableArray   *books;

  TableDataManager *tableDataManager;

  CustomIndicator  *customIndicator;
}

/*
 * TableManagerを生成、初期化します。
 */
- (void)createTableManager;

/*
 * NavigationBarにボタンを配置します。
 */
- (void) customiseNavigationItem;

/*
 * 書籍リストを更新します。
 * 現在取得している書籍情報を破棄し再取得をします。
 */
- (void) reloardBookNewList:(id)sender;

/*
 * 書籍リストを取得します。
 */
- (void) obtainBookListFromSamuraiPurchase;

/*
 * 表示する書籍リストを変更します。
 */
- (void) changeShowBookList;

@end

@implementation TabStoreViewController
@synthesize storeTableView;
@synthesize storeSementedControl;

- (void)viewDidLoad
{
  [super viewDidLoad];

  books = [[NSMutableArray alloc] init];
  [self createTableManager];
}

- (void)viewDidUnload
{
  [self setStoreSementedControl:nil];
  [self setStoreTableView:nil];
  [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];

  self.navigationController.navigationBar.topItem.title = @"ストア";
  [self customiseNavigationItem];
}

- (void)viewDidAppear:(BOOL)animated
{
  if (![tableDataManager isFirstLoaded]) {
    customIndicator = [[CustomIndicator alloc] init];
    [IndicatorUtil showCustomIndicator:customIndicator parentView:self.view];
    [self obtainBookListFromSamuraiPurchase];
  }
}

- (void)dealloc
{
  if (tableDataManager) {
    [tableDataManager cancelObtainBookDataFromSamuraiPurchase];
  }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
  return(interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)viewWillDisappear:(BOOL)animated
{
  [super viewWillDisappear:animated];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
  NSString *identifier = [segue identifier];

  if ([identifier isEqualToString:@"purchase"]) {
    NSIndexPath            *indexPath = [storeTableView indexPathForSelectedRow];
    PruchaseViewController *vc        = [segue destinationViewController];
    vc.book = [books objectAtIndex:indexPath.row];
  }
}

#pragma mark - Storybord Method

- (IBAction)clickStoreSegmentedControl:(id)sender
{
  [self changeShowBookList];
}

#pragma mark - Private Method

- (void)createTableManager
{
  tableDataManager = [[TableDataManager alloc] init];
  [tableDataManager setSelectedId:SELECTED_NEW];
  [tableDataManager setDelegate:self];
}

- (void)customiseNavigationItem
{
  //更新ボタン生成
  UIImage  *reloadImg = [UIImage imageNamed:@"icon_reload.png"];
  UIButton *btn       = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];

  [btn setImage:reloadImg forState:UIControlStateNormal];
  [btn addTarget:self action:@selector(reloardBookNewList:) forControlEvents:UIControlEventTouchDown
  ];

  self.navigationController.navigationBar.topItem.rightBarButtonItem =
    [[UIBarButtonItem alloc] initWithCustomView:btn];
}

- (void)reloardBookNewList:(id)sender
{
  [books removeAllObjects];
  [tableDataManager clear];
  [IndicatorUtil showCustomIndicator:customIndicator parentView:self.view];

  [self obtainBookListFromSamuraiPurchase];
}

- (void)obtainBookListFromSamuraiPurchase
{
  self.navigationController.navigationBar.topItem.rightBarButtonItem.enabled = NO;
  [tableDataManager setLoading:YES];
  [self.storeTableView reloadData];    //フッターをもっと読むから読み込み中に変更するため
  [tableDataManager obtainBookDataFromSamuraiPurchase];
}

- (void)changeShowBookList
{
  [tableDataManager setSelectedId:[self.storeSementedControl selectedSegmentIndex]];

  [books removeAllObjects];
  books = [tableDataManager bookData];
  [storeTableView reloadData];


  if ([tableDataManager isLoading]) {
    self.navigationController.navigationBar.topItem.rightBarButtonItem.enabled = NO;
    return;
  }
  if ([tableDataManager isFinishLoaded]) {
    self.navigationController.navigationBar.topItem.rightBarButtonItem.enabled = YES;
    return;
  }

  if (![tableDataManager isFirstLoaded]) {
    [IndicatorUtil showCustomIndicator:customIndicator parentView:self.view];
    [self obtainBookListFromSamuraiPurchase];
    return;
  }
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  if ([tableDataManager isFinishLoaded] || ![tableDataManager isFirstLoaded]) {
    return(books.count);
  }else {
    return(books.count + 1);
  }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)
  indexPath
{
  //フッターが存在する場合
  if (indexPath.row == books.count) {
    NSString     *identifier = @"readMoreCell";

    ReadMoreCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];

    if (cell == nil) {
      cell =
        [[ReadMoreCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    if ([tableDataManager isLoading]) {
      cell.cellReadMoreLabel.text = @"読み込み中…";
    }else {
      cell.cellReadMoreLabel.text = @"もっと読む";
    }
    return(cell);
  }

  NSString *identifier = @"bookCell";

  BookCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];

  if (cell == nil) {
    cell =
      [[BookCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
  }

  Book *book = [books objectAtIndex:indexPath.row];

  cell.cellTitleLabel.text  = book.title;
  cell.cellAuthorLabel.text = book.outline;
  if (book.isFree) {
    cell.cellPriceLabel.text = @"無料";
  }else {
    cell.cellPriceLabel.text = @"有料";
  }
  [tableDataManager cellForRowWithSegmentedId:cell bookData:book];

  return(cell);
}

- (void)tableView:(UITableView *)tableView
  didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  if (indexPath.row == books.count && ![tableDataManager isLoading]) {
    [self obtainBookListFromSamuraiPurchase];
  }
}

#pragma mark - BookListManagerDelegate
- (void)didFinishBookList:(NSMutableArray *)bookListArray
{
  for (Book *book in bookListArray)
  {
    [books addObject:book];
  }

  //初回取得の場合はフラグ更新
  //初回時のみインジケーターを表示しているためインジケーター非表示
  if (![tableDataManager isFirstLoaded]) {
    [tableDataManager setFirstLoaded:YES];
    [IndicatorUtil dismissCustomIndicator:customIndicator];
  }
  self.navigationController.navigationBar.topItem.rightBarButtonItem.enabled = YES;

  //取得件数が０件の場合は読み込み処理が完了したものとみなす
  if ([bookListArray count] == 0) {
    [tableDataManager setFinishLoaded:YES];
  }
  [tableDataManager setLoading:NO];

  [self.storeTableView reloadData];
}

- (void)didError
{
  self.navigationController.navigationBar.topItem.rightBarButtonItem.enabled = YES;
  [IndicatorUtil dismissCustomIndicator:customIndicator];
  [AlertViewUtil showErrorAlertView:@"書籍情報の取得に失敗しました。"];
  [storeTableView reloadData];
}

@end
