//
//  CGRectManager.m
//  SampleSeminar
//
//  Created by Kenji Tazawa on 12/08/02.
//  Copyright (c) 2012年 Kenji Tazawa. All rights reserved.
//

#import "CGRectManager.h"

@implementation CGRectManager

+ (CGRect)calcCenterFrameRelative:(UIView *)parentView subView:(UIView *)subView
{
  CGFloat x;
  CGFloat y;
  CGFloat width;
  CGFloat height;

  width  = subView.frame.size.width;
  height = subView.frame.size.height;

  //相対座標を算出
  x = ((parentView.frame.size.width - width) / 2.0f);
  y = ((parentView.frame.size.height - height) / 2.0f);

  return(CGRectMake(x, y, width, height));
}

+ (CGRect)calcCenterFrameAbsolute:(UIView *)parentView subView:(UIView *)subView
{
  CGFloat x;
  CGFloat y;
  CGFloat width;
  CGFloat height;

  width  = subView.frame.size.width;
  height = subView.frame.size.height;

  //絶対座標を算出
  x = parentView.frame.origin.x + ((parentView.frame.size.width - width) / 2.0f);
  y = parentView.frame.origin.y + ((parentView.frame.size.height - height) / 2.0f);

  return(CGRectMake(x, y, width, height));
}

+ (CGRect)calcCenterFrame:(UIView *)parentView magni:(CGFloat)magni
{
  //始点を考慮せず、サイズを指定した子View
  CGRect tmpSubViewRect = CGRectMake(parentView.frame.origin.x, parentView.frame.origin.y,
                                     parentView.frame.size.width * magni,
                                     parentView.frame.size.height * magni);
  UIView *tmpSubView = [[UIView alloc] initWithFrame:tmpSubViewRect];

  return([self calcCenterFrameRelative:parentView subView:tmpSubView]);
}

+ (CGRect)calcCenterFrame:(UIView *)parentView magniHeight:(CGFloat)magniHeight magniWidth:(
    CGFloat)magniWidth
{
  //始点を考慮せず、サイズを指定した子View
  CGRect tmpSubViewRect = CGRectMake(parentView.frame.origin.x, parentView.frame.origin.y,
                                     parentView.frame.size.width * magniWidth,
                                     parentView.frame.size.height * magniHeight);
  UIView *tmpSubView = [[UIView alloc] initWithFrame:tmpSubViewRect];

  return([self calcCenterFrameRelative:parentView subView:tmpSubView]);
}

@end
