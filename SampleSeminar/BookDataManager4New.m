//
//  BookDataManager4New.m
//  SampleSeminar
//
//  Created by Kenji Tazawa on 12/07/30.
//  Copyright (c) 2012年 CONIT Co., Ltd. All rights reserved.
//

#import "BookDataManager4New.h"
#import "SPProductParam.h"
#import "Book.h"
#import "BookCell.h"
#import "BookListDao.h"

@implementation BookDataManager4New

#pragma mark - BookDataManager Override Method

- (SPProductParam *)generateSPPParam
{
  SPProductParam *param = [[SPProductParam alloc] init];

  param.fields    = @"title,outline,publish_date";
  param.sorttype  = @"DESC";
  param.sortfield = @"publish_date";
  param.offset    = self.offset;
  param.limit     = UNIT_COUNT;

  return(param);
}

- (void) cellForRowWithSegmentedId:(BookCell *)bookCell bookData:(Book *)book
{
  NSDateFormatter *inputDateFormatter = [[NSDateFormatter alloc] init];

  [inputDateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
  NSDate          *inputDate = [inputDateFormatter dateFromString:book.publishDateStr];

  NSDateFormatter *outputDateFormatter    = [[NSDateFormatter alloc] init];
  NSString        *outputDateFormatterStr = @"MM/dd/yyyy";
  [outputDateFormatter setDateFormat:outputDateFormatterStr];
  NSString        *outputDateStr = [outputDateFormatter stringFromDate:inputDate];

  bookCell.cellOptionLabel.text = outputDateStr;
}

@end
