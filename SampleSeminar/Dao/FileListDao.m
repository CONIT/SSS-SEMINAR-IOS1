//
//  FileListDao.m
//  SampleSeminar
//
//  Created by Kenji Tazawa on 12/07/31.
//  Copyright (c) 2012年 CONIT Co., Ltd. All rights reserved.
//

#import "FileListDao.h"
#import "DownloadFile.h"

@implementation FileListDao

- (void)filelistWithProductId:(NSString *)productId receipt:(NSString *)receipt
{
  Log(@"filelistWithProductId");

  NSMutableString *path = [NSMutableString string];
  [path appendString:@"files/"];

  NSMutableString *body = [NSMutableString string];

  //Tokenの設定
  [body appendString:@"token="];
  [body appendString:TOKEN];

  //ProductIDの設定
  [body appendString:@"&product_id="];
  [body appendString:productId];

  //レシートの設定（有料の場合）
  if (receipt != nil) {
    [body appendString:@"&receipt="];
    [body appendString:receipt];
  }

  NSURL               *url = [super URLWithPath:path];

  NSMutableURLRequest *theRequest =
    [NSMutableURLRequest requestWithURL:url
     cachePolicy:NSURLRequestUseProtocolCachePolicy
     timeoutInterval:TIMEOUT_SEC];
  [theRequest setHTTPMethod:@"POST"];
  NSData *bodyData = [body dataUsingEncoding:NSUTF8StringEncoding];
  [theRequest setHTTPBody:bodyData];

  [self doRequest:theRequest];
}

#pragma mark - SamuraiPurchaseConnection Override Method

- (void)didFinishLoadingWithData:(NSData *)receivedData

{
  NSMutableArray *result = [NSMutableArray array];

  NSError        *err = nil;

  NSDictionary   *root
    =
      [NSJSONSerialization JSONObjectWithData:receivedData options:NSJSONReadingMutableContainers
       error:&
       err];

  if (err == nil) {
    NSArray *productList = [root objectForKey:@"files"];

    if ([productList count] <= 0) {
      Log(@"count:%u", [productList count]);
    }else {
      for (NSDictionary *data in productList)
      {
        NSString     *name        = [data objectForKey:@"file_name"];
        NSString     *downloadUrl = [data objectForKey:@"download_url"];
        NSString     *hash        = [data objectForKey:@"hash"];

        DownloadFile *downloadFile = [[DownloadFile alloc] init];
        downloadFile.name        = name;
        downloadFile.downloarUrl = downloadUrl;
        downloadFile.hash        = hash;

        [result addObject:downloadFile];
      }
    }
  }

  [(id < FileListDaoDelegate >)self.delegate didFinishFileList:result];
}

@end

