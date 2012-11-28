//
//  BookDataManager.h
//  SampleSeminar
//
//  Created by Kenji Tazawa on 12/07/30.
//  Copyright (c) 2012年 CONIT Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BookListDao.h"
@class Book;
@class BookCell;

@protocol BookListManagerDelegate

- (void)didFinishBookList:(NSMutableArray *)bookListArray;
- (void)didError;

@end

/*
 * 書籍データの管理を行うクラスです。
 *
 * SamuraiPurchaseへのデータ取得
 * パース処理
 * データ保持
 */
@interface BookDataManager : NSObject<BookListDaoDelegate> {
}

/* SamuraiPurchaseからの書籍情報取得結果をハンドリングするデリゲート */
@property (nonatomic, assign) id<BookListManagerDelegate> delegate;

/* 初回読み込み判定フラグ */
@property (nonatomic) BOOL isFirstLoaded;

/* 読み込みデータのオフセット */
@property (nonatomic, assign) NSInteger offset;

/* 読み込み終了判定フラグ */
@property (nonatomic) BOOL isFinishLoaded;

/* 読み込み中判定フラグ */
@property (nonatomic) BOOL isLoading;

/* SegmentedControlで選択されているかを判定する */
@property (nonatomic) BOOL isSelected;

/*
 * SamuraiPurchaseから書籍データを取得、キャンセルします。
 */
- (void)doRequestBookDataFromSamuraiPurchase;
- (void)cancelRequestBookDataFromSamuraiPurchase;

/*
 * 書籍データを取得、保存します。
 */
- (NSMutableArray *)bookData;
- (void)addBookData:(NSMutableArray *)bookArray;

/*
 * 全データを初期化します。
 */
- (void)clear;

/*
 * 書籍データをテーブルのセルに設定、表示します。(当クラスの継承先で実装すること)
 */
- (void)cellForRowWithSegmentedId:(BookCell *)bookCell bookData:(Book *)book;

/*
 * SamuraiPurchaseから書籍データを取得するのに使用するパラメータを生成します。(当クラスの継承先で実装すること)
 */
- (SPProductParam *)generateSPPParam;

@end
