//
//  TabMybooksViewController.m
//  SampleSeminar
//
//  Created by Kenji Tazawa on 12/07/24.
//  Copyright (c) 2012年 CONIT Co., Ltd. All rights reserved.
//

#import "TabMybooksViewController.h"
#import "SettingsViewController.h"
#import "ReadBookViewController.h"
#import "CustomUISegmentedControl.h"
#import "BookCell.h"
#import "PurchasedBookCoreDataManager.h"
#import "PurchasedBook.h"

@interface TabMybooksViewController (){
  /* 表示している書籍データ */
  NSMutableArray *books;
}

/*
 * NavigationBarを初期化（カスタマイズ）します。
 */
- (void) customiseNavigationItem;

/*
 * 設定画面に遷移します。
 */
- (void) settings:(id)sender;

/*
 * 書籍情報の削除モードに切り替えます。
 */
- (void) removeBooks:(id)sender;

@end

@implementation TabMybooksViewController
@synthesize mybookTableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
  }
  return(self);
}

- (void)viewDidLoad
{
  books                    = [[NSMutableArray alloc] init];
  mybookTableView.delegate = self;

  [super viewDidLoad];
}

- (void)viewDidUnload
{
  [self setMybookTableView:nil];
  [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  self.navigationController.navigationBar.topItem.title = @"マイブックス";

  //購入履歴取得
  [books removeAllObjects];
  PurchasedBookCoreDataManager *manager = [PurchasedBookCoreDataManager sharedInstance];
  NSArray                      *array   = [manager allPurchased:PURCHASED_BOOK_ENTITY_NAME];
  books = [array mutableCopy];

  [mybookTableView reloadData];
  if ([mybookTableView isEditing]) {
    [mybookTableView setEditing:NO animated:NO];
  }
}

- (void)viewDidAppear:(BOOL)animated
{
  [self customiseNavigationItem];
}

- (void)viewWillDisappear:(BOOL)animated
{
  [super viewWillDisappear:animated];
  self.navigationController.navigationBar.topItem.leftBarButtonItem = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
  return(interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
  NSString *identifier = [segue identifier];

  if ([identifier isEqualToString:@"readbookFromMybookSegue"]) {
    NSIndexPath            *indexPath = [mybookTableView indexPathForSelectedRow];
    ReadBookViewController *vc        = [segue destinationViewController];
    PurchasedBook          *pBook     = [books objectAtIndex:indexPath.row];
    vc.bookPath =
      [FileManageUtil getCachePathWithSPDirectoryHtmlFileName:pBook.productId];
  }
}

#pragma  mark - Private Method

- (void)customiseNavigationItem
{
  //削除ボタン生成
  UIImage  *removeImg = [UIImage imageNamed:@"icon_remove.png"];
  UIButton *removeBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];

  [removeBtn setImage:removeImg forState:UIControlStateNormal];
  [removeBtn addTarget:self action:@selector(removeBooks:) forControlEvents:UIControlEventTouchDown];

  self.navigationController.navigationBar.topItem.leftBarButtonItem =
    [[UIBarButtonItem alloc] initWithCustomView:removeBtn];

  //設定ボタン生成
  UIImage  *settingsImg = [UIImage imageNamed:@"icon_settings.png"];
  UIButton *settingsBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];

  [settingsBtn setImage:settingsImg forState:UIControlStateNormal];
  [settingsBtn addTarget:self action:@selector(settings:) forControlEvents:
   UIControlEventTouchDown];

  self.navigationController.navigationBar.topItem.rightBarButtonItem =
    [[UIBarButtonItem alloc] initWithCustomView:settingsBtn];
}

- (void)removeBooks:(id)sender
{
  if ([mybookTableView isEditing]) {
    [mybookTableView setEditing:NO animated:YES];
  }else {
    [mybookTableView setEditing:YES animated:YES];
  }
}

- (void)settings:(id)sender
{
  SettingsViewController *controller =
    [self.storyboard instantiateViewControllerWithIdentifier:@"SettingsViewController"];

  [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource Method

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return(books.count);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)
  indexPath
{
  NSString *identifier = @"bookCell4Mybook";

  BookCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];

  if (cell == nil) {
    cell =
      [[BookCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
  }

  PurchasedBook *pBook = [books objectAtIndex:indexPath.row];

  cell.cellTitleLabel.text  = pBook.title;
  cell.cellAuthorLabel.text = pBook.author;

  return(cell);
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)
  editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
  if (UITableViewCellEditingStyleDelete == editingStyle) {
    //booksはDBから取得した情報から参照コピーを行なっているため「ファイル削除」→「DB情報削除」の順に行っています
    //ファイル削除
    PurchasedBook *pBook = (PurchasedBook *)[books objectAtIndex:indexPath.row];
    [FileManageUtil removeFile:[FileManageUtil getCachePathWithSPDirectoryHtmlFileName:pBook.
                                   productId]];
    //DB情報削除
    PurchasedBookCoreDataManager *manager = [PurchasedBookCoreDataManager sharedInstance];
    [manager entityForDelete:pBook];
    [manager save];

    [books removeObjectAtIndex:indexPath.row];
    [mybookTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:
     UITableViewRowAnimationFade];
  }
}

@end
