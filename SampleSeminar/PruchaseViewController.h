//
//  PruchaseViewController.h
//  SampleSeminar
//
//  Created by Kenji Tazawa on 12/07/23.
//  Copyright (c) 2012年 CONIT Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FileListDao.h"
#import "FileDownloadDao.h"
#import "StoreKitManager.h"
@class Book;

/*
 * 書籍の購入、ダウンロードする機能を提供するViewControllerです。
 */
@interface PruchaseViewController : UIViewController<FileListDaoDelegate,
                                                     FileDownloadDaoDelegate,StoreKitUtilDelegate>

/* 書籍情報 */
@property (strong, nonatomic) Book *book;

/* 書籍タイトル表示ラベル */
@property (weak, nonatomic) IBOutlet UILabel *purchaseTitle;

/* 書籍タ著者表示ラベル */
@property (weak, nonatomic) IBOutlet UILabel *purchaseAutor;

/* 購入、ダウンロードボタン */
@property (weak, nonatomic) IBOutlet UIButton *purchaseBtn;

/* ボタンタップ時のアクション */
- (IBAction)purchase:(id)sender;

@end
