//
//  DataUtil.h
//  SampleSeminar
//
//  Created by Kenji Tazawa on 12/08/08.
//  Copyright (c) 2012年 CONIT Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 * データ処理するユーティリティクラスです 。
 */
@interface DataUtil : NSObject

/*
 * NSDataをBase64にエンコードします。
 */
+ (NSString *)base64WithData:(NSData *)aData;

@end
