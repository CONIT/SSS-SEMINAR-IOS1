//
//  IndicatorUtil.m
//  SampleSeminar
//
//  Created by Kenji Tazawa on 12/08/03.
//  Copyright (c) 2012年 CONIT Co., Ltd. All rights reserved.
//

#import "IndicatorUtil.h"

@implementation IndicatorUtil {
}

+ (void)showCustomIndicator:(CustomIndicator *)customIndicator parentView:(UIView *)parentView
{
  [customIndicator setBackgroundColor:[UIColor colorWithRed:0.1725 green:0.6039 blue:1.0000 alpha:
                                       1.0]];
  customIndicator.indicatorType = UIActivityIndicatorViewStyleWhiteLarge;
  [customIndicator startIndicatorWithView:parentView labelText:@"Loading…"];
}

+ (void)dismissCustomIndicator:(CustomIndicator *)customIndicator
{
  [customIndicator stopIndicator];
}

@end
