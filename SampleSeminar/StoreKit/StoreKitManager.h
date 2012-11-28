//
//  StoreKitUtil.h
//  CdDataMag
//
//  Created by Yuka Wada on 12/03/27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>

@protocol StoreKitUtilDelegate<NSObject>
@optional
- (void)successPayment:(NSString *)aProductId receipt:(NSData *)aReceipt;
- (void)failedPayment:(BOOL)isCancel;
- (void)receiveProduct:(SKProduct *)aProduct;
- (void)restoreItem:(NSString *)aProductId receipt:(NSData *)aReceipt;
- (void)finishedRestore;
- (void)failedRestore;
@end

@interface StoreKitManager : NSObject<SKPaymentTransactionObserver, SKProductsRequestDelegate>

@property (nonatomic, weak) id<StoreKitUtilDelegate> delegate_;
@property (nonatomic, strong) NSString               *productId_;
@property (nonatomic) BOOL                           isFinish_;     // 購入処理終了フラグ　※重複処理制御

- (void)requestProduct:(NSSet *)aProductSet;
- (void)requestPurchase:(SKProduct *)aProduct;
- (void)requestRestore;
- (void)removeTransaction;

@end
