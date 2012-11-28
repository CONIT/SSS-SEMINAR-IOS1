//
//  ReadBookViewController.h
//  SampleSeminar
//
//  Created by Kenji Tazawa on 12/08/06.
//  Copyright (c) 2012年 CONIT Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReadBookViewController : UIViewController<UIWebViewDelegate>

/* 書籍を表示用 */
@property (weak, nonatomic) IBOutlet UIWebView *readBookWebView;

/* 書籍ファイル（html）の格納先 */
@property (copy, nonatomic) NSString *bookPath;

@end
