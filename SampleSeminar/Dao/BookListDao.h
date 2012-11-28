//
//  BookListDao.h
//  SampleSeminar
//
//  Created by Kenji Tazawa on 12/07/26.
//  Copyright (c) 2012年 CONIT Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SamuraiPurchaseConnection.h"
@class SPProductParam;

@protocol BookListDaoDelegate<SamuraiPurchaseDaoDelegate>

- (void)didFinishBookList:(NSMutableArray *)bookListArray;

@end

/*
 * SamuraiPurchaseから書籍情報を取得する機能を提供するクラスです。
 */
@interface BookListDao : SamuraiPurchaseConnection

/*
 * SPProductParamを使用して書籍情報をSamuraiPurchaseから取得します。
 */
- (void)bookListWithSPparam:(SPProductParam *)param;

@end
