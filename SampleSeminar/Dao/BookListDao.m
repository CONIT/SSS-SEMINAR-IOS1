//
//  BookListDao.m
//  SampleSeminar
//
//  Created by Kenji Tazawa on 12/07/26.
//  Copyright (c) 2012年 CONIT Co., Ltd. All rights reserved.
//

#import "BookListDao.h"
#import "Book.h"
#import "SPProductParam.h"

@implementation BookListDao {
}

- (void)bookListWithSPparam:(SPProductParam *)param
{
  Log(@"bookListWithSPparam");

  NSMutableString *path = [NSMutableString string];
  [path appendString:@"products/"];
  [path appendString:[SamuraiPurchaseConnection pathToken]];

  if (param.fields != nil) {
    [path appendString:@"&fields="];
    [path appendString:param.fields];
  }
  if (param.sorttype != nil) {
    [path appendString:@"&sorttype="];
    [path appendString:param.sorttype];
  }
  if (param.sortfield != nil) {
    [path appendString:@"&sortfield="];
    [path appendString:param.sortfield];
  }

  // ランキングの場合のURLの生成処理
  if (param.summaryType != -1) {
    [path appendString:@"&summary_type="];
    [path appendString:  [[NSString alloc] initWithFormat:@"%d", param.summaryType]];
  }
  if (param.freeType != -1) {
    [path appendString:@"&fee_type="];
    [path appendString: [[NSString alloc] initWithFormat:@"%d", param.freeType]];
  }

  // オフセットの設定
  if (param.offset != -1) {
    [path appendString:@"&offset="];
    [path appendString:[[NSString alloc] initWithFormat:@"%d", param.offset]];
  }

  // 取得上限の設定
  if (param.limit != -1) {
    [path appendString:@"&limit="];
    [path appendString:[[NSString alloc] initWithFormat:@"%d", param.limit]];
  }

  NSURL *url = [super URLWithPath:path];

  // Create the request.
  NSURLRequest *theRequest =
    [NSURLRequest requestWithURL:url
     cachePolicy:NSURLRequestUseProtocolCachePolicy
     timeoutInterval:TIMEOUT_SEC];

  [self doRequest:theRequest];
}

#pragma mark - SamuraiPurchaseConnection Override Method

- (void)didFinishLoadingWithData:(NSData *)receivedData

{
  NSMutableArray *result = [NSMutableArray array];
  NSError        *err    = nil;

  NSDictionary   *root
    =
      [NSJSONSerialization JSONObjectWithData:receivedData options:NSJSONReadingMutableContainers
       error:&
       err];

  if (err == nil) {
    NSArray *productList = [root objectForKey:@"products"];

    if ([productList count] <= 0) {
      Log(@"count:%u", [productList count]);
    }else {
      for (NSDictionary *data in productList)
      {
        BOOL     isFree     = NO;
        NSString *productId = [data objectForKey:@"product_id"];
        NSString *title     = [data objectForKey:@"title"];
        NSString *outline   = [data objectForKey:@"outline"];

        NSString *isFreeStr = [data objectForKey:@"is_free"];
        if ([isFreeStr intValue] == 1) {
          isFree = YES;
        }
        NSString *publishDateStr = [data objectForKey:@"publish_date"];
        NSString *dlcount        = [data objectForKey:@"summary"];

        Book     *book = [[Book alloc] init];
        book.productId      = productId;
        book.title          = title;
        book.outline        = outline;
        book.isFree         = isFree;
        book.publishDateStr = publishDateStr;
        book.dlCount        = dlcount;

        [result addObject:book];
      }
    }
  }

  [(id < BookListDaoDelegate >)self.delegate didFinishBookList:result];
}

@end
