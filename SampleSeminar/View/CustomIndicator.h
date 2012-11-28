//
//  SampleCustomIndicator.h
//  SampleSeminar
//
//  Created by Kenji Tazawa on 12/08/02.
//  Copyright (c) 2012年 Kenji Tazawa. All rights reserved.
//

#import <Foundation/Foundation.h>

/* カスタムインジケータクラスです。
 * インジケータとラベルを表示することができます。*/

/*
 * カスタムインジケータクラスです。
 * インジケータとラベルを表示することができます。
 */
@interface CustomIndicator : NSObject {
  /*インジケータの背後で全画面を覆うUI*/
  UIView *fillterView;

  /*カスタムインジケータの背景*/
  UIView *backgroudView;

  /*インジケータ*/
  UIActivityIndicatorView *indicator;

  /*ラベル*/
  UILabel *indicatorLabel;

  /*背景の色*/
  UIColor *backGroundViewColor;
}

/*インジケータのタイプ*/
@property (nonatomic, assign) UIActivityIndicatorViewStyle *indicatorType;

/*
 * インジケータを表示します。
 * ラベルテキストがnilの場合はラベルの表示はされません。
 */
- (void)startIndicatorWithView:(UIView *)view labelText:(NSString *)text;

/*
 *インジケータを停止し、非表示にします。
 */
- (void)stopIndicator;

/*
 * インジケーターの背景色の設定をします。
 */
- (void)setBackgroundColor:(UIColor *)color;

@end
