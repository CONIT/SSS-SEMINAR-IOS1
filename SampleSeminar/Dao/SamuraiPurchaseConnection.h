//
//  SamuraiPurchaseConnection.h
//  SampleSeminar
//
//  Created by Kenji Tazawa on 12/07/26.
//  Copyright (c) 2012年 CONIT Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SamuraiPurchaseDaoDelegate<NSObject, NSURLConnectionDelegate>

- (void)didFailWithAPIError:(NSString *)status message:(NSString *)message;

@optional
- (void)didFailWithNetworkError:(NSError *)error;

@end

/*
 * SamuraiPurchaseServerとの通信を取りまとめたクラスです。
 * 接続、キャンセル、データ取得処理を行います。
 *
 * 各APIへの接続処理の実装は当クラスを継承して行います。
 * そのためデータ取得後、エラー時に行われる処理は使用するクラスで実装する必要があります。
 *
 */
@interface SamuraiPurchaseConnection : NSObject {
  @protected
  NSMutableData *_receivedData;
}

@property (nonatomic, assign) id<SamuraiPurchaseDaoDelegate> delegate;

/*
 * リクエストに使用するトークンパラメータを取得します。
 */
+ (NSString *)pathToken;

/*
 * リクエストURLを生成します。
 */
- (NSURL *)URLWithPath:(NSString *)path;

/*
 * HTTP通信のリクエストを行います。
 */
- (void)doRequest:(NSURLRequest *)request;

/*
 * HTTP通信をキャンセルします。
 * 通信中のみキャンセル処理が実行されます。
 */
- (void)cancelConnection;

/*
 * HTTP通信がタイムアウトした場合に実行されます。
 */
- (void)doRequestTimeOut:(NSURLRequest *)request;

/*
 * データ取得完了時に実行されるメソッドです。
 *
 */
- (void)didFinishLoadingWithData:(NSData *)receivedData;

@end
