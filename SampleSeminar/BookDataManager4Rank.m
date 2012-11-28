//
//  BookDataManager4Rank.m
//  SampleSeminar
//
//  Created by Kenji Tazawa on 12/07/30.
//  Copyright (c) 2012年 CONIT Co., Ltd. All rights reserved.
//

#import "BookDataManager4Rank.h"
#import "SPProductParam.h"
#import "Book.h"
#import "BookCell.h"

//ランキング書籍リストのマネージャークラスです
@implementation BookDataManager4Rank

#pragma mark - BookDataManager Override Method

- (SPProductParam *)generateSPPParam
{
  SPProductParam *param = [[SPProductParam alloc] init];

  param.fields      = @"title,outline,summary";
  param.sorttype    = @"DESC";
  param.sortfield   = @"summary";
  param.summaryType = 2;
  param.offset      = self.offset;
  param.limit       = UNIT_COUNT;

  return(param);
}

- (void) cellForRowWithSegmentedId:(BookCell *)bookCell bookData:(Book *)book
{
  NSString *count = [[NSString alloc] initWithFormat:@"DL数:%@", book.dlCount];

  bookCell.cellOptionLabel.text = count;
}

@end

