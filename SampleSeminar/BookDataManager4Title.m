//
//  BookDataManager4Title.m
//  SampleSeminar
//
//  Created by Kenji Tazawa on 12/07/30.
//  Copyright (c) 2012年 CONIT Co., Ltd. All rights reserved.
//

#import "BookDataManager4Title.h"
#import "SPProductParam.h"
#import "Book.h"
#import "BookCell.h"

@implementation BookDataManager4Title

#pragma mark - BookDataManager Override Method

- (SPProductParam *)generateSPPParam
{
  SPProductParam *param = [[SPProductParam alloc] init];

  param.fields    = @"title,outline";
  param.sorttype  = @"ASC";
  param.sortfield = @"title";
  param.offset    = self.offset;
  param.limit     = UNIT_COUNT;

  return(param);
}

- (void) cellForRowWithSegmentedId:(BookCell *)bookCell bookData:(Book *)book
{
  bookCell.cellOptionLabel.text = @"";
}

@end
