//
//  CustomUISegmentedControl.h
//  SampleSeminar
//
//  Created by Kenji Tazawa on 12/07/20.
//  Copyright (c) 2012年 CONIT Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 * フォントの指定と、選択状態と非選択状態の背景色を指定できるように拡張したSegmentedControlです。
 */
@interface CustomUISegmentedControl : UISegmentedControl

/*通常時の背景色*/
@property (strong, nonatomic) UIColor *tintColorNormal;

/*選択時の背景色*/
@property (strong, nonatomic) UIColor *tintColorSelected;

/*
 * 通常時（非選択状態）のフォント情報を設定します。
 */
- (void)setFontNormal:(NSDictionary *)textAttributesNormal;

/*
 * 選択時のフォント情報を設定します。
 */
- (void)setFontSelected:(NSDictionary *)textAttributesSelected;

/*
 * セミナーアプリ向けの設定を適用します。
 */
- (void)setSeminarStyle;

@end
