//
//  SPProductParam.m
//  SampleSeminar
//
//  Created by Kenji Tazawa on 12/07/26.
//  Copyright (c) 2012年 CONIT Co., Ltd. All rights reserved.
//

#import "SPProductParam.h"

@implementation SPProductParam

@synthesize productId   = _productId;
@synthesize lang        = _lang;
@synthesize fields      = _fields;
@synthesize limit       = _limit;
@synthesize offset      = _offset;
@synthesize sorttype    = _sorttype;
@synthesize sortfield   = _sortfield;
@synthesize category    = _category;
@synthesize subCategory = _subCategory;
@synthesize tag         = _tag;
@synthesize summaryType = _summaryType;
@synthesize freeType    = _freeType;
@synthesize summaryDate = _summaryDate;

- (id)init
{
  self = [super init];
  if (self) {
    _limit       = -1;
    _summaryType = -1;
    _freeType    = -1;
    _offset      = -1;
  }
  return(self);
}

@end
