//
//  Book.m
//  SampleSeminar
//
//  Created by Kenji Tazawa on 12/07/23.
//  Copyright (c) 2012年 CONIT Co., Ltd. All rights reserved.
//

#import "Book.h"

@implementation Book

@synthesize productId       = _productId;
@synthesize title           = _title;
@synthesize outline         = _outline;
@synthesize isFree          = _isFree;
@synthesize fileHash        = _fileHash;
@synthesize publishDateStr  = _publishDateStr;
@synthesize purchaseDateStr = _purchaseDateStr;
@synthesize dlCount         = _dlCount;

@end
