//
//  FileDownloadDao.h
//  SampleSeminar
//
//  Created by Kenji Tazawa on 12/08/03.
//  Copyright (c) 2012年 CONIT Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SamuraiPurchaseConnection.h"
@class DownloadFile;

@protocol FileDownloadDaoDelegate<SamuraiPurchaseDaoDelegate>

- (void)didFinishSaveFile:(BOOL )isSaved;

@end

/*
 * SamuraiPurchaseからファイルをダウンロードする機能を提供するクラスです。
 */
@interface FileDownloadDao : SamuraiPurchaseConnection

/*
 * ファイルをSamuraiPurchaseからダウンロードします。
 * ハッシュのチェック。データの保存を行います。
 */
- (void)fileWithDownloadUrl:(DownloadFile *)downloadFile;

@end
