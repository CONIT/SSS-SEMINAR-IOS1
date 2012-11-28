//
//  FileManageUtil.h
//  SampleSeminar
//
//  Created by Kenji Tazawa on 12/08/05.
//  Copyright (c) 2012年 CONIT Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 * ファイル、フォルダ管理、制御を行うユーティリティクラスです。
 */
@interface FileManageUtil : NSObject

/*
 * AppData/Library/CachesのPathを取得します 。
 */
+ (NSString *)getCachePath;

/*
 * AppData/Library/Caches/SamuraiPurchase/[fileName]のPathを取得します。
 */
+ (NSString *)getCachePathWithSPDirectoryFileName:(NSString *)fileName;

/*
 * AppData/Library/Caches/SamuraiPurchase/[fileName]+[.html]のPathを取得します。
 */
+ (NSString *)getCachePathWithSPDirectoryHtmlFileName:(NSString *)fileName;

/*
 * ファイルが存在するかを確認します。
 */
+ (BOOL)isFileExists:(NSString *)filePath;

/*
 * フォルダを生成します。
 */
+ (BOOL)createDirectory:(NSString *)directoryPath;

/*
 * NSDataを任意のパスに保存します。
 * 保存先のフォルダが存在しない場合は自動生成します。
 */
+ (BOOL)saveFile:(NSData *)data filePath:(NSString *)filePath;

/*
 * 指定したパスのファイルを削除します。
 */
+ (BOOL)removeFile:(NSString *)filePath;

@end
