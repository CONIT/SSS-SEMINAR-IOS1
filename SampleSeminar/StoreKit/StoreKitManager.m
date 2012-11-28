//
//  StoreKitUtil.m
//  CdDataMag
//
//  Created by Yuka Wada on 12/03/27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "StoreKitManager.h"

@interface StoreKitManager ()

@end

@implementation StoreKitManager

@synthesize delegate_  = delegate;
@synthesize productId_ = productId;
@synthesize isFinish_  = isFinish;

// プロダクト情報リクエスト
- (void)requestProduct:(NSSet *)aProductSet
{
  // 重複処理を制御
  if (!self.isFinish_) {
    return;
  }
  self.isFinish_ = NO;
  Log(@"requestProducts: %@", aProductSet.description);

  // リクエスト
  SKProductsRequest *skProductRequest =
    [[SKProductsRequest alloc] initWithProductIdentifiers:aProductSet];
  skProductRequest.delegate = self;
  [skProductRequest start];
}

// プロダクト情報リクエスト受信
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)
  response
{
  Log(@"%s", __PRETTY_FUNCTION__);
  if (response == nil || [response.products count] == 0) {
    Log(@"Product Response is nil");
    if (self.delegate_ && [self.delegate_ respondsToSelector:@selector(receiveProduct:)]) {
      [self.delegate_ receiveProduct:nil];
      return;
    }
  }

  // 確認できなかったプロダクトIDをログに記録
  for (NSString *identifier in response.invalidProductIdentifiers)
  {
    Log(@"invalid product: %@", identifier);
  }

  // 金額リスト生成
  SKProduct *product = nil;
  if (response.products.count == 1) {
    product         = [response.products objectAtIndex:0];
    self.productId_ = product.productIdentifier;
    Log(@"price[%@]: %@", [product.price stringValue], product.productIdentifier);
  }

  // 結果通知
  if (self.delegate_ && [self.delegate_ respondsToSelector:@selector(receiveProduct:)]) {
    [self.delegate_ receiveProduct:product];
  }
}

// プロダクト情報リクエスト完了
- (void)requestDidFinish:(SKRequest *)request
{
  request = nil;
}

// 購入リクエスト
- (void)requestPurchase:(SKProduct *)aProduct
{
  Log(@"requestPurchase:%@", aProduct.productIdentifier);

  // オブザーバ登録
  [[SKPaymentQueue defaultQueue] addTransactionObserver:self];

  // リクエスト
  SKPayment *payment = [SKPayment paymentWithProduct:aProduct];
  [[SKPaymentQueue defaultQueue] addPayment:payment];
}

// 復元リクエスト
- (void)requestRestore
{
  // 重複処理を制御
  if (!self.isFinish_) {
    return;
  }
  self.isFinish_ = NO;
  Log(@"requestRestore");

  // オブザーバ登録
  [[SKPaymentQueue defaultQueue] addTransactionObserver:self];

  // リクエスト
  [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
}

// リクエストエラー
- (void)request:(SKRequest *)request didFailWithError:(NSError *)error
{
  Log(@"didFailWithError:%@", [error localizedDescription]);
  if (self.delegate_ && [self.delegate_ respondsToSelector:@selector(failedPayment:)]) {
    [self.delegate_ failedPayment:NO];
  }
  request = nil;
}

// トランザクション破棄
- (void)paymentQueue:(SKPaymentQueue *)queue removedTransactions:(NSArray *)transactions
{
  Log(@"paymentQueue:removedTransactions");
}

// 購入成功
- (BOOL)successPayment:(NSString *)aProductId receipt:(NSData *)aReceipt
{
  // プロダクトIDが異なる場合はスルー
  if (![self.productId_ isEqualToString:aProductId]) {
    /*UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%@", aProductId]
     *                                                  message:@"前回のはスルー"
     *                                                 delegate:nil
     *                                        cancelButtonTitle:@"OK"
     *                                        otherButtonTitles:nil];
     * [alertView show];
     * [alertView release];*/
    return(NO);
  }

  Log(@"did purchased with : %@", aProductId);
  if (self.delegate_ && [self.delegate_ respondsToSelector:@selector(successPayment:receipt:)]) {
    [self.delegate_ successPayment:aProductId receipt:aReceipt];
  }
  return(YES);
}

// 購入キャンセル／エラー処理
- (void)failedPayment:(SKPaymentTransaction *)transaction
{
  NSString *msg = nil;

  switch ([transaction.error code])
  {
  case SKErrorUnknown:
    msg = [NSString stringWithFormat:@"未知のエラーが発生しました[%d]", [transaction.error code]];
    break;

  case SKErrorClientInvalid:
    msg = [NSString stringWithFormat:@"不正なクライアントです[%d]", [transaction.error code]];
    break;

  case SKErrorPaymentCancelled:
    msg = [NSString stringWithFormat:@"購入がキャンセルされました[%d]", [transaction.error code]];
    break;

  case SKErrorPaymentInvalid:
    msg = [NSString stringWithFormat:@"不正な購入です[%d]", [transaction.error code]];
    break;

  case SKErrorPaymentNotAllowed:
    msg = [NSString stringWithFormat:@"購入が許可されていません[%d]", [transaction.error code]];
    break;

  default:
    msg = [NSString stringWithFormat:@"%@[%d]",
           transaction.error.localizedDescription,
           [transaction.error code]];
    break;
  }
  Log(@"%@", msg);

#if TEST_MODE
  UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"SKPaymentTransactionStateFailed"
                            message:msg
                            delegate:nil
                            cancelButtonTitle:@"OK"
                            otherButtonTitles:nil];
  [alertView show];
#else
#endif

  // キャンセル（SKErrorUnknownは既に購入済みで再度無料で購入するというポップアップのキャンセル時に来るため）
  if ([transaction.error code] == SKErrorPaymentCancelled
      || [transaction.error code] == SKErrorUnknown) {
    if (self.delegate_ && [self.delegate_ respondsToSelector:@selector(failedPayment:)]) {
      [self.delegate_ failedPayment:YES];
    }
  }
  // エラー
  else {
    if (self.delegate_ && [self.delegate_ respondsToSelector:@selector(failedPayment:)]) {
      [self.delegate_ failedPayment:NO];
    }
  }
}

// リストア成功
- (void)restoreItem:(NSString *)aProductId receipt:(NSData *)aReceipt
{
  Log(@"restoreItem : %@", aProductId);
  if (self.delegate_ && [self.delegate_ respondsToSelector:@selector(restoreItem:receipt:)]) {
    [self.delegate_ restoreItem:aProductId receipt:aReceipt];
  }
}

// リストア終了
- (void)paymentQueueRestoreCompletedTransactionsFinished:(SKPaymentQueue *)queue
{
  Log(@"Payment Restore Transaction Finished");
  if (self.delegate_ && [self.delegate_ respondsToSelector:@selector(finishedRestore)]) {
    [self.delegate_ finishedRestore];
  }
}

// リストアエラー
- (void)paymentQueue:(SKPaymentQueue *)queue restoreCompletedTransactionsFailedWithError:(NSError *)
  error
{
  Log(@"Payment Restore Transaction Error: %@", [error localizedDescription]);
  if (self.delegate_ && [self.delegate_ respondsToSelector:@selector(failedRestore)]) {
    [self.delegate_ failedRestore];
  }
}

// 購入処理オブザーバ
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions
{
  // 購入確認ポップアップが表示される前にホームボタンで落とすと、
  // 次回起動時に前回の購入情報を含めて複数の情報がtransactionsに入ってくる。
  Log(@"情報数：%d", [transactions count]);

  for (SKPaymentTransaction *transaction in transactions)
  {
    Log(@"transactionState[0:Purchasing,1:Purchased,2:failed,3:restore]:%d",
        transaction.transactionState);
    switch (transaction.transactionState)
    {
    // 購入成功
    case SKPaymentTransactionStatePurchased: {
      Log(@"Payment Transaction Purchased: %@", transaction.transactionIdentifier);
      if ([self successPayment:transaction.payment.productIdentifier receipt:transaction.
              transactionReceipt]) {
        [queue finishTransaction:transaction];
        break;
      }
      [queue finishTransaction:transaction];
    }

    // 購入失敗（キャンセル含む）
    case SKPaymentTransactionStateFailed: {
      Log(@"Payment Transaction Failed: %@: %@", transaction.transactionIdentifier,
          transaction.error);
      [self failedPayment:transaction];
      [queue finishTransaction:transaction];
    }

    // 購入履歴復元
    case SKPaymentTransactionStateRestored: {
      Log(@"Payment Transaction Restored: %@", transaction.transactionIdentifier);
      [self restoreItem:transaction.payment.productIdentifier receipt:transaction.transactionReceipt
      ];
      [queue finishTransaction:transaction];
    }
    }
  }
}

- (id)init
{
  self = [super init];
  if (!self) {
    return(nil);
  }

  // フラグ初期化
  self.isFinish_ = YES;

  return(self);
}

- (void)removeTransaction
{
  [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
  self.isFinish_ = YES;
}

@end
