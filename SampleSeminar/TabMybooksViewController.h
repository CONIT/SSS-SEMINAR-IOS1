//
//  TabMybooksViewController.h
//  SampleSeminar
//
//  Created by Kenji Tazawa on 12/07/24.
//  Copyright (c) 2012年 CONIT Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CustomUISegmentedControl;

/*
 * マイブックタブを表示するUIViewControllerです。
 * ダウンロードした書籍一覧を表示する機能を提供します。
 */
@interface TabMybooksViewController : UIViewController<UITableViewDelegate,
                                                       UITableViewDataSource>


@property (weak, nonatomic) IBOutlet UITableView              *mybookTableView;

@end
