//
//  FileListDao.h
//  SampleSeminar
//
//  Created by Kenji Tazawa on 12/07/31.
//  Copyright (c) 2012年 CONIT Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SamuraiPurchaseConnection.h"

@protocol FileListDaoDelegate<SamuraiPurchaseDaoDelegate>

- (void)didFinishFileList:(NSMutableArray *)fileListArray;

@end

/*
 * SamuraiPurchaseからファイルリストを取得する機能を提供するクラスです。
 */
@interface FileListDao : SamuraiPurchaseConnection

/*
 * プロダクトIDに紐付くファイルリストをSamuraiPurchaseServerから取得します。
 *
 * @param receipt 無料:nil 有料:必須
 */
- (void)filelistWithProductId:(NSString *)productId receipt:(NSString *)receipt;

@end
