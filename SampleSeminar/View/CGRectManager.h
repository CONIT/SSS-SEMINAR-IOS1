//
//  CGRectManager.h
//  SampleSeminar
//
//  Created by Kenji Tazawa on 12/08/02.
//  Copyright (c) 2012年 Kenji Tazawa. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 * 座標算出してCGRectを生成するユーティリティクラスです。
 */
@interface CGRectManager : NSObject

/*
 * 入れ子となるViewの中央に配置するCGRectを算出します（相対座標）
 */
+ (CGRect )calcCenterFrameRelative:(UIView *)parentView subView:(UIView *)subView;

/*
 * 入れ子となるViewの中央に配置するCGRectを算出します（絶対座標）
 */
+ (CGRect )calcCenterFrameAbsolute:(UIView *)parentView subView:(UIView *)subView;

/*
 * 入れ子となるView(指定された親Viewに対する倍率のサイズ)を中央に配置するCGRectを算出します
 */
+ (CGRect )calcCenterFrame:(UIView *)parentView magni:(CGFloat)magni;

/*
 * 入れ子となるView(指定された親Viewに対する倍率のサイズ、縦横別倍率)を中央に配置するCGRectを算出します
 */
+ (CGRect )calcCenterFrame:(UIView *)parentView magniHeight:(CGFloat)magniHeight magniWidth:(
    CGFloat)magniWidth;

@end
