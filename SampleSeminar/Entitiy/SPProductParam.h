//
//  SPProductParam.h
//  SampleSeminar
//
//  Created by Kenji Tazawa on 12/07/26.
//  Copyright (c) 2012年 CONIT Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 * SamuraiPurchaseのプロダクトリスト取得APIの実行する際にする各種パラーメターをまとめたモデルクラスです。
 * 書籍情報取得処理で使用します。
 */
@interface SPProductParam : NSObject

/** プロダクトID */
@property (nonatomic, copy) NSString *productId;

/** 言語 */
@property (nonatomic, copy) NSString *lang;

/** 取得フィールド */
@property (nonatomic, copy) NSString *fields;

/** 最大取得件数 */
@property (nonatomic, assign) NSInteger limit;

/** オフセット */
@property (nonatomic, assign) NSInteger offset;

/** ソートタイプ（昇順、降順） */
@property (nonatomic, copy) NSString *sorttype;

/** ソート順 */
@property (nonatomic, copy) NSString *sortfield;

/** カテゴリID */
@property (nonatomic, copy) NSString *category;

/** サブカテゴリID */
@property (nonatomic, copy) NSString *subCategory;

/** タグ */
@property (nonatomic, copy) NSString *tag;

/** サマリ種別（日次、週次、月次） */
@property (nonatomic, assign) NSInteger summaryType;

/** 料金種別 */
@property (nonatomic, assign) NSInteger freeType;

/** 集計基準日 */
@property (nonatomic, copy) NSString *summaryDate;

@end
