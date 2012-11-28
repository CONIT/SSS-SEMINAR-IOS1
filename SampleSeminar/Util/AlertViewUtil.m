//
//  AlerViewUtil.m
//  SampleSeminar
//
//  Created by Kenji Tazawa on 12/08/06.
//  Copyright (c) 2012年 CONIT Co., Ltd. All rights reserved.
//

#import "AlertViewUtil.h"

@implementation AlertViewUtil

+ (void)showAlertView:(NSString *)title message:(NSString *)message btnName:(NSString *)btnName
{
  UIAlertView *alert =
    [[UIAlertView alloc] initWithTitle:title message:message
     delegate:self cancelButtonTitle:btnName otherButtonTitles:nil];

  [alert show];
}

+ (void)showErrorAlertView:(NSString *)message
{
  [self showAlertView:@"エラー" message:message btnName:@"OK"];
}

@end
