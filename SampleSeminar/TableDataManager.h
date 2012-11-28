//
//  TableDataManager.h
//  SampleSeminar
//
//  Created by Kenji Tazawa on 12/07/30.
//  Copyright (c) 2012年 CONIT Co., Ltd. All rights reserved.
//

#import "BookDataManager.h"
#import "BookDataManager4New.h"
#import "BookDataManager4Rank.h"
#import "BookDataManager4Title.h"
#import "SamuraiPurchaseConnection.h"

/*
 * TabStoreViewControllerで表示する書籍情報BookDataManager（新着、人気、タイトル）を一括管理するクラスです。
 */
@interface TableDataManager : NSObject {
}

/*
 * SegmentedControlで選択されたボタンIDを設定します。
 * 選択されたIDに紐付く書籍情報がTableDataManagerで操作されるようになります。
 */
- (void)setSelectedId:(NSInteger)newId;

/*
 *書籍データを取得します。
 */
- (NSMutableArray *)bookData;

/*
 * 選択されている書籍情報データを初期値に戻します。
 */
- (void)clear;

/*
 * テーブルのセルに書籍内容を表示します。
 */
- (void)cellForRowWithSegmentedId:(BookCell *)bookCell bookData:(Book *)book;

/*
 * SamuraiPurchaseから書籍情報を取得します。
 */
- (void)obtainBookDataFromSamuraiPurchase;
- (void)cancelObtainBookDataFromSamuraiPurchase;

/*
 * 初回読み込みか判定、設定します。
 */
- (BOOL)isFirstLoaded;
- (void)setFirstLoaded:(BOOL)isLoaded;

/*
 *読み込み終了か判定、設定します。
 */
- (BOOL)isFinishLoaded;
- (void)setFinishLoaded:(BOOL)isLoaded;

/*
 *読み込み中か判定、設定します。
 */
- (BOOL)isLoading;
- (void)setLoading:(BOOL)isLoading;

/*
 * デリゲートの設定処理です。
 */
- (void)setDelegate:(id<BookListManagerDelegate> )delgate;

@end
