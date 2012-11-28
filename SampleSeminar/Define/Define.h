//
//  Define.h
//  SampleSeminar
//
//  Created by Kenji Tazawa on 12/07/30.
//  Copyright (c) 2012年 CONIT Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

// FunctionIndex
#define SELECTED_NEW      0
#define SELECTED_RANK     1
#define SELECTED_TITLE    2

// SumuraiPurchase Param
#define UNIT_COUNT        10

// SumuraiPurchase DirectoryName
#define SP_DIRECTORY      @ "SamuraiPurchase"

// HTTP
#define BASE_URL \
  @ "https://ap344-cp1-d46b04eafe23b17925b1287449db25ca-apisrv.conit.jp/v2/ios/"
#define TOKEN \
  @ "14212d548859da92635fb1882f28bc901b9386b0"

//HTTP TimeOut
#define TIMEOUT_SEC                   60.0

// CoreData
#define PURCHASED_BOOK_ENTITY_NAME    @ "PurchasedBook"

#import "CGRectManager.h"
#import "IndicatorUtil.h"
#import "FileManageUtil.h"
#import "DataUtil.h"
#import "AlertViewUtil.h"