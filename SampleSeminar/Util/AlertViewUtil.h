//
//  AlerViewUtil.h
//  SampleSeminar
//
//  Created by Kenji Tazawa on 12/08/06.
//  Copyright (c) 2012年 CONIT Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 * UIAlertViewを表示するユーティリティクラスです 。
 */
@interface AlertViewUtil : NSObject

/*
 * 閉じる機能のみのUIAlertViewを表示します。
 */
+ (void)showAlertView:(NSString *)title message:(NSString *)message btnName:(NSString *)btnName;

/*
 * 閉じる機能のみのUIAlertViewを表示します。UIAlertViewのタイトル表示は「エラー」固定です。
 */
+ (void)showErrorAlertView:(NSString *)message;

@end
