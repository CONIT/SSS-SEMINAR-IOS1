//
//  DownloadFile.m
//  SampleSeminar
//
//  Created by Kenji Tazawa on 12/07/31.
//  Copyright (c) 2012年 CONIT Co., Ltd. All rights reserved.
//

#import "DownloadFile.h"

@implementation DownloadFile

@synthesize name;
@synthesize downloarUrl;
@synthesize hash;

- (NSString *)description
{
  return([NSString stringWithFormat:@"DownloadFile: name=%@ downloarUrl=%@ hash=%@", name,
          downloarUrl, hash]);
}
@end
