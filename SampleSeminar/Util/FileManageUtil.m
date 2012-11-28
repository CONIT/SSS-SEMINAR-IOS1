//
//  FileManageUtil.m
//  SampleSeminar
//
//  Created by Kenji Tazawa on 12/08/05.
//  Copyright (c) 2012年 CONIT Co., Ltd. All rights reserved.
//

#import "FileManageUtil.h"

@implementation FileManageUtil

+ (NSString *)getCachePath
{
  NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask,
                                                       YES);

  return([paths objectAtIndex:0]);
}

+ (NSString *)getCachePathWithDirectoryName:(NSString *)directoryName
{
  NSString *cacheDirPath = [self getCachePath];

  return([cacheDirPath stringByAppendingPathComponent:directoryName]);
}

+ (NSString *)getCachePathWithSPDirectoryFileName:(NSString *)fileName
{
  NSString *directoryPath = [self getCachePathWithDirectoryName:SP_DIRECTORY];

  return([directoryPath stringByAppendingPathComponent:fileName]);
}

+ (NSString *)getCachePathWithSPDirectoryHtmlFileName:(NSString *)fileName
{
  NSString *htmlFileName = [fileName stringByAppendingString:@".html"];

  return([self getCachePathWithSPDirectoryFileName:htmlFileName]);
}

+ (BOOL)isFileExists:(NSString *)filePath
{
  return([[NSFileManager defaultManager] fileExistsAtPath:filePath]);
}

+ (BOOL)createDirectory:(NSString *)directoryPath
{
  NSFileManager *manager =
    [NSFileManager defaultManager];
  NSError       *error    = nil;
  BOOL          isCreated = [manager createDirectoryAtPath:directoryPath
                             withIntermediateDirectories:YES
                             attributes:nil
                             error:&error];

  // 作成に失敗した場合は、エラーログを出力します
  if (isCreated) {
    return(YES);
  }else {
    Log(@"failed to create directory. reason is %@ - %@", error, error.userInfo);
    return(NO);
  }
}

+ (BOOL)saveFile:(NSData *)data filePath:(NSString *)filePath
{
  //ファイル名と空文字を置換してフォルダパスを生成
  NSString *directoryPath = [filePath stringByReplacingOccurrencesOfString:
                             [filePath lastPathComponent] withString:@""];

  if (![self isFileExists:directoryPath]) {
    if (![self createDirectory:directoryPath]) {
      return(NO);
    }
  }
  return([data writeToFile:filePath atomically:YES]);
}

+ (BOOL)removeFile:(NSString *)filePath
{
  NSError *error = nil;

  BOOL    isSuccess = [[NSFileManager defaultManager] removeItemAtPath:filePath error:&error];

  if (!isSuccess) {
    Log(@"failed to remove file. reason is %@ - %@", error, error.userInfo);
  }
  return(isSuccess);
}

@end
