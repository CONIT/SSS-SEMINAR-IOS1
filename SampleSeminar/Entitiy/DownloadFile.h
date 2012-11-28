//
//  DownloadFile.h
//  SampleSeminar
//
//  Created by Kenji Tazawa on 12/07/31.
//  Copyright (c) 2012年 CONIT Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DownloadFile : NSObject

/* ファイル名 */
@property (nonatomic, copy) NSString *name;
/* ダウンロードURL */
@property (nonatomic, copy) NSString *downloarUrl;
/* ハッシュ値 */
@property (nonatomic, copy) NSString *hash;

@end
