//
//  PurchasedBook.h
//  SampleSeminar
//
//  Created by Kenji Tazawa on 12/08/10.
//  Copyright (c) 2012年 CONIT Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

/*
 * ダウンロード完了した書籍情報をあらわすモデルクラスです。
 * NSManagedObjectを継承しており、CoreDataに使用されます。
 * また、マイブックスタブの1セルあたりの表示データとしても使用されます。
 */
@interface PurchasedBook : NSManagedObject

@property (nonatomic, retain) NSString *author;
@property (nonatomic, retain) NSNumber *payment; //1:有料　0:無料
@property (nonatomic, retain) NSString *productId;
@property (nonatomic, retain) NSDate   *purchasedDate;
@property (nonatomic, retain) NSData   *receipt;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSNumber *purchased; //1:購入済み　0:未購入

@end
