//
//  Book.h
//  SampleSeminar
//
//  Created by Kenji Tazawa on 12/07/23.
//  Copyright (c) 2012年 CONIT Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Book : NSObject

/* プロダクトID */
@property (nonatomic, copy) NSString *productId;
/* 書籍タイトル */
@property (nonatomic, copy) NSString *title;
/* 著者 */
@property (nonatomic, copy) NSString *outline;
/* 無料判定フラグ */
@property  BOOL                      isFree;
/* ハッシュ */
@property (nonatomic, copy) NSString *fileHash;
/* 公開日 */
@property (nonatomic, copy) NSString *publishDateStr;
/* 購入日 */
@property (nonatomic, copy) NSString *purchaseDateStr;
/* ダウンロード数 */
@property (nonatomic, copy) NSString *dlCount;

@end
