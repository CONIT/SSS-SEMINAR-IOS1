//
//  SettingsViewController.m
//  SampleSeminar
//
//  Created by Kenji Tazawa on 12/07/24.
//  Copyright (c) 2012年 CONIT Co., Ltd. All rights reserved.
//

#import "SettingsViewController.h"
#import "StoreKitManager.h"
#import "PurchasedBookCoreDataManager.h"
#import "PurchasedBook.h"
#import "CustomIndicator.h"

@interface SettingsViewController (){
  StoreKitManager *storeKitManager;
  CustomIndicator *customIndicator;
}

/*
 * 前画面に戻ります。
 */
- (void) back:(id)sender;

/*
 * NavigationBarを初期化（カスタマイズ）します。
 */
- (void) customiseNavigationItem;

@end

@implementation SettingsViewController
@synthesize aboutTextView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
  }
  return(self);
}

- (void)viewDidLoad
{
  [super viewDidLoad];

  [self customiseNavigationItem];
  self.aboutTextView.text =
    @"【アプリ使用上の注意事項】\nこのアプリはサンプルアプリでありますが、アプリ内課金機能を実装しており、アプリから購入を行なうとApple社からの請求が発生します。\nこれによって生じたいかなる不利益に対しても保証はできかねますので、あらかじめご了承ください。\n\n\nCopyright(c) 2012 CONIT Co., Ltd.";

  storeKitManager           = [[StoreKitManager alloc] init];
  storeKitManager.delegate_ = self;
    
  customIndicator = [[CustomIndicator alloc] init];  
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
  return(interfaceOrientation == UIInterfaceOrientationPortrait);
}
- (void)viewDidUnload
{
    storeKitManager.delegate_=nil;
    storeKitManager =nil;
    customIndicator=nil;
  [self setAboutTextView:nil];  
  [super viewDidUnload];
}

#pragma mark - Private Method
- (void)back:(id)sender
{
  [IndicatorUtil dismissCustomIndicator:customIndicator];    
  [self.navigationController popViewControllerAnimated:YES];
}

- (void)customiseNavigationItem
{
  //戻るボタン生成
  UIImage  *backImg = [UIImage imageNamed:@"icon_back.png"];
  UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];

  [backBtn setImage:backImg forState:UIControlStateNormal];
  [backBtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchDown];

  self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
}

#pragma mark - StoryBoard Method
- (IBAction)restore:(id)sender
{
  [IndicatorUtil showCustomIndicator:customIndicator parentView:self.view];
    
  PurchasedBookCoreDataManager *manager = [[PurchasedBookCoreDataManager alloc] init];

  [manager deleteAll:PURCHASED_BOOK_ENTITY_NAME];
  [manager save];
  [storeKitManager requestRestore];
}

#pragma mark - StoreKitUtilDelegate Method
- (void)restoreItem:(NSString *)aProductId receipt:(NSData *)aReceipt
{
  Log(@"restoreItem");
  PurchasedBookCoreDataManager *manager = [[PurchasedBookCoreDataManager alloc] init];
  PurchasedBook                *pb      =
    (PurchasedBook *)[manager entityForInsert:PURCHASED_BOOK_ENTITY_NAME];

  pb.productId     = aProductId;
  pb.purchasedDate = [NSDate date];
  pb.receipt       = aReceipt;
  pb.purchased     = [NSNumber numberWithBool:NO];

  [manager save];
  
}

- (void)finishedRestore
{
  Log(@"finishedRestore");
  [IndicatorUtil dismissCustomIndicator:customIndicator];
}

- (void)failedRestore
{
  Log(@"failedRestore");
  [IndicatorUtil dismissCustomIndicator:customIndicator];
  [self.navigationController popViewControllerAnimated:YES];
}

@end
