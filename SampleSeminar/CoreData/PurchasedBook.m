//
//  PurchasedBook.m
//  SampleSeminar
//
//  Created by Kenji Tazawa on 12/08/10.
//  Copyright (c) 2012年 CONIT Co., Ltd. All rights reserved.
//

#import "PurchasedBook.h"

@implementation PurchasedBook

@dynamic author;
@dynamic payment;
@dynamic productId;
@dynamic purchasedDate;
@dynamic receipt;
@dynamic title;
@dynamic purchased;

- (NSString *)description
{
  return([NSString stringWithFormat:
          @"PurchasedBook author:%@ payment:%@ productId:%@ purchasedDate:%@ title:%@ purchased:%@",
          self.author, self.payment, self.productId, self.purchasedDate, self.title,
          self.purchased]);
}

@end
