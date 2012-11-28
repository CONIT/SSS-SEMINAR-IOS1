//
//  SampleCustomIndicator.m
//  SampleSeminar
//
//  Created by Kenji Tazawa on 12/08/02.
//  Copyright (c) 2012年 Kenji Tazawa. All rights reserved.
//

#import "CustomIndicator.h"
#import <QuartzCore/QuartzCore.h>

@implementation CustomIndicator

- (void)setBackgroundColor:(UIColor *)color
{
  backGroundViewColor = [UIColor colorWithCGColor:color.CGColor];
}

- (void)startIndicatorWithView:(UIView *)view labelText:(NSString *)text
{
  // FillterView Create
  fillterView                 = [[UIView alloc] initWithFrame:view.frame];
  fillterView.backgroundColor = [UIColor grayColor];
  fillterView.alpha           = 0.7f;
  [view addSubview:fillterView];

  // BackgroundView Create
  //size
  CGRect bacgroudCGRect =
    [CGRectManager calcCenterFrame:view magniHeight:0.25f magniWidth:0.4f];

  backgroudView                    = [[UIView alloc] initWithFrame:bacgroudCGRect];
  backgroudView.backgroundColor    = backGroundViewColor;
  backgroudView.layer.cornerRadius = 15.0f;
  [view addSubview:backgroudView];

  // Indicator Create
  indicator =
    [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:
     UIActivityIndicatorViewStyleWhiteLarge
    ];
  indicator.backgroundColor = [UIColor clearColor];
  indicator.frame           =
    [CGRectManager calcCenterFrameRelative:backgroudView subView:indicator];
  [backgroudView addSubview:indicator];

  [indicator startAnimating];
  indicator.hidden     = NO;
  backgroudView.hidden = NO;

  // Label Create
  if (text != nil) {
    indicatorLabel                 = [[UILabel alloc] init];
    indicatorLabel.backgroundColor = [UIColor clearColor];
    indicatorLabel.textColor       = [UIColor whiteColor];
    indicatorLabel.text            = text;
    indicatorLabel.frame           = CGRectMake(0,
                                                indicator.frame.origin.y + indicator.frame.size.height,
                                                backgroudView.frame.size.width,
                                                ((backgroudView.frame.size.height -
                                                  indicator.frame.size.height) * 0.5f));
    indicatorLabel.textAlignment = UITextAlignmentCenter;
    indicatorLabel.font          = [UIFont fontWithName:@"AppleGothic" size:13];
    [backgroudView addSubview:indicatorLabel];
  }
  Log(@"startIndicator");
}

- (void)stopIndicator
{
  if ([indicator isAnimating]) {
    [indicator stopAnimating];
    indicator.hidden      = YES;
    backgroudView.hidden  = YES;
    indicatorLabel.hidden = YES;
    fillterView.hidden    = YES;

    [indicatorLabel removeFromSuperview];
    [indicator removeFromSuperview];
    [backgroudView removeFromSuperview];
    [fillterView removeFromSuperview];

    Log(@"stopIndicator");
  }
}

@end
