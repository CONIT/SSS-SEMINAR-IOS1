//
//  NSData+SHA1.h
//  SampleSeminar
//
//  Created by Kenji Tazawa on 12/08/06.
//  Copyright (c) 2012年 CONIT Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (exDigest)

- (NSData *)sha1Digest;
- (NSString *)hexString;
- (NSString *)sha1String;

@end
