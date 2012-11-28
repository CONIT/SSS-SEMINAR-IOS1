//
//  NSData+MD5.m
//  SampleSeminar
//
//  Created by Kenji Tazawa on 12/08/06.
//  Copyright (c) 2012年 CONIT Co., Ltd. All rights reserved.
//

#import <CommonCrypto/CommonDigest.h>
#import "NSData+SHA1.h"

@implementation  NSData (exDigest)

- (NSData *) sha1Digest
{
  unsigned char result[CC_SHA1_DIGEST_LENGTH];

  CC_SHA1([self bytes], [self length], result);
  return([NSData dataWithBytes:result length:CC_SHA1_DIGEST_LENGTH]);
}

- (NSString *) sha1String
{
  return([[self sha1Digest] hexString]);
}

- (NSString *)hexString
{
  unsigned int      i;
  static const char *hexstr[16] =
  {
    "0", "1", "2", "3",
    "4", "5", "6", "7",
    "8", "9", "a", "b",
    "c", "d", "e", "f"
  };
  const char        *dataBuffer   = (char *)[self bytes];
  NSMutableString   *stringBuffer = [NSMutableString stringWithCapacity:([self length] * 2)];

  for (i = 0; i < [self length]; i++)
  {
    uint8_t t1, t2;
    t1 = (0x00f0 & (dataBuffer[i])) >> 4;
    t2 = 0x000f & (dataBuffer[i]);
    [stringBuffer appendFormat:@"%s", hexstr[t1]];
    [stringBuffer appendFormat:@"%s", hexstr[t2]];
  }

  return
    ([stringBuffer copy]);
}
@end
