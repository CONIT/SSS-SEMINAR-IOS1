//
//  CustomUISegmentedControl.m
//  SampleSeminar
//
//  Created by Kenji Tazawa on 12/07/20.
//  Copyright (c) 2012年 CONIT Co., Ltd. All rights reserved.
//

#import "CustomUISegmentedControl.h"

@interface CustomUISegmentedControl ()

/*
 * 背景画像を再描画して反映させます。
 */
- (void)drawBackGroundColor;

@end

@implementation CustomUISegmentedControl

@synthesize tintColorNormal   = _tintColorNormal;
@synthesize tintColorSelected = _tintColorSelected;

/*
 * 指定イニシャライザ
 */
- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    //初期カラー設定
    if (self) {
      self.tintColorNormal   = [UIColor whiteColor];
      self.tintColorSelected = [UIColor blackColor];
      [self setSeminarStyle];
      [self drawBackGroundColor];
    }
  }
  return(self);
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
  self = [super initWithCoder:aDecoder];

  //初期カラー設定
  if (self) {
    self.tintColorNormal   = [UIColor whiteColor];
    self.tintColorSelected = [UIColor blackColor];
    [self setSeminarStyle];
    [self drawBackGroundColor];
  }

  return(self);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
  //タップ処理をキャッチしてSegmentedControlの再描画を行います
  [super touchesBegan:touches withEvent:event];

  [self drawBackGroundColor];
}

#pragma mark - Public Method

- (void)drawBackGroundColor
{
  for (int i = 0; i < [self.subviews count]; i++)
  {
    if ([[self.subviews objectAtIndex:i] isSelected]) {
      [[self.subviews objectAtIndex:i] setTintColor:self.tintColorSelected];
    }else {
      [[self.subviews objectAtIndex:i] setTintColor:self.tintColorNormal];
    }
  }
}

- (void) setFontNormal:(NSDictionary *)textAttributesNormal
{
  [self setTitleTextAttributes:textAttributesNormal forState:UIControlStateNormal];
}

- (void) setFontSelected:(NSDictionary *)textAttributesSelected
{
  [self setTitleTextAttributes:textAttributesSelected forState:UIControlStateHighlighted];
}

- (void)setSeminarStyle
{
  UIColor      *colorTextNormal =
    [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
  NSDictionary *textAttributesNormal = [NSDictionary dictionaryWithObjectsAndKeys:
                                        colorTextNormal, UITextAttributeTextColor,
                                        [UIColor colorWithRed:0.5020 green:0.5765 blue:0.6706 alpha:
                                         1.0], UITextAttributeTextShadowColor,
                                        [UIFont systemFontOfSize:13], UITextAttributeFont,
                                        nil];

  [self setFontNormal:textAttributesNormal];

  UIColor      *colorTextHighlighted      = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
  NSDictionary *textAttributesHighlighted = [NSDictionary dictionaryWithObjectsAndKeys:
                                             colorTextHighlighted, UITextAttributeTextColor,
                                             [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0],
                                             UITextAttributeTextShadowColor,
                                             [UIFont systemFontOfSize:13], UITextAttributeFont,
                                             nil];
  [self setFontSelected:textAttributesHighlighted];

  self.tintColorSelected =
    [UIColor colorWithRed:0.4706 green:0.5373 blue:0.6275 alpha:1.0];
  self.tintColorNormal =
    [UIColor colorWithRed:0.7725 green:0.8078 blue:0.8314 alpha:1.0000];
  self.selectedSegmentIndex = SELECTED_NEW;
  [self drawBackGroundColor];
}
@end
