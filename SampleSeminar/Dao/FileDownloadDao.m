//
//  FileDownloadDao.m
//  SampleSeminar
//
//  Created by Kenji Tazawa on 12/08/03.
//  Copyright (c) 2012年 CONIT Co., Ltd. All rights reserved.
//

#import "FileDownloadDao.h"
#import "DownloadFile.h"
#import "NSData+SHA1.h"

@implementation FileDownloadDao {
  DownloadFile *_file;
}

- (void)fileWithDownloadUrl:(DownloadFile *)downloadFile
{
  _file = downloadFile;

  NSURL        *url        = [NSURL URLWithString:_file.downloarUrl];
  NSURLRequest *theRequest = [NSURLRequest requestWithURL:url
                              cachePolicy:NSURLRequestUseProtocolCachePolicy
                              timeoutInterval:60.0];

  [self doRequest:theRequest];
}

#pragma mark - SamuraiPurchaseConnection Override Method

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
  //ダウンロード処理のためAPIのエラーコード判定は不要。オーバーライドしてスパークラスで行なっているエラーコード判定処理を無効化しています。
  Log(@"File Download DAO connectionDidFinishLoading");
  [self didFinishLoadingWithData:_receivedData];
}

- (void)didFinishLoadingWithData:(NSData *)receivedData
{
  //Hashチェック
  if (![_file.hash isEqualToString:[_receivedData sha1String]]) {
    [(id < FileDownloadDaoDelegate >)self.delegate didFinishSaveFile:NO];
  }

  //保存先のディレクトリPath生成
  NSString *saveFilePath =
    [FileManageUtil getCachePathWithSPDirectoryFileName:_file.name];
  BOOL     isSaved = [FileManageUtil saveFile:_receivedData filePath:saveFilePath];

  [(id < FileDownloadDaoDelegate >)self.delegate didFinishSaveFile:isSaved];
}

@end

