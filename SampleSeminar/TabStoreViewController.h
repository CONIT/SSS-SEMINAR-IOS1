//
//  SeminarFirstViewController.h
//  SampleSeminar
//
//  Created by Kenji Tazawa on 12/07/18.
//  Copyright (c) 2012年 CONIT Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BookListDao.h"
#import "BookDataManager.h"
@class CustomUISegmentedControl;

/*
 * ストアタブを表示するUIViewControllerです。
 * SamuraiPurchaseから取得した書籍情報を一覧表示する機能を提供します。
 */
@interface TabStoreViewController : UIViewController<UITableViewDelegate,
                                                     UITableViewDataSource,
                                                     BookListManagerDelegate> {
}

@property (weak, nonatomic) IBOutlet CustomUISegmentedControl *storeSementedControl;
@property (weak, nonatomic) IBOutlet UITableView              *storeTableView;
- (IBAction)clickStoreSegmentedControl:(id)sender;

@end
