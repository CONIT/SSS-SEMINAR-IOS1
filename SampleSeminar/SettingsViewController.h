//
//  SettingsViewController.h
//  SampleSeminar
//
//  Created by Kenji Tazawa on 12/07/24.
//  Copyright (c) 2012年 CONIT Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoreKitManager.h"

/*
 * 設定画面を表示するUIViewControllerです。
 * リストア機能を提供します。
 */
@interface SettingsViewController : UIViewController<StoreKitUtilDelegate>

@property (weak, nonatomic) IBOutlet UITextView *aboutTextView;

- (IBAction)restore:(id)sender;

@end
