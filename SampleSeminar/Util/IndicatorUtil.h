//
//  IndicatorUtil.h
//  SampleSeminar
//
//  Created by Kenji Tazawa on 12/08/03.
//  Copyright (c) 2012年 CONIT Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CustomIndicator.h"

/*
 * カスタムインジケータ[CustomIndicator]の表示を管理するユーティリティクラスです。
 */
@interface IndicatorUtil : NSObject

/*
 * カスタムインジケータを表示します。
 */
+ (void)showCustomIndicator:(CustomIndicator *)customIndicator parentView:(UIView *)parentView;

/*
 * カスタムインジケータが表示されている場合、非表示にします。
 */
+ (void)dismissCustomIndicator:(CustomIndicator *)customIndicator;
@end
