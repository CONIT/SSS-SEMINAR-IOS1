//
//  BookCell.h
//  SampleSeminar
//
//  Created by Kenji Tazawa on 12/07/23.
//  Copyright (c) 2012年 CONIT Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 * 書籍情報を表示するUITableViewCellです。
 */
@interface BookCell : UITableViewCell

/*書籍タイトル*/
@property (weak, nonatomic) IBOutlet UILabel *cellTitleLabel;

/*書籍著者名*/
@property (weak, nonatomic) IBOutlet UILabel *cellAuthorLabel;

/*無料または有料*/
@property (weak, nonatomic) IBOutlet UILabel *cellPriceLabel;

/*オプション*/
@property (weak, nonatomic) IBOutlet UILabel *cellOptionLabel; //表示するデータによって登録日またはダウンロード数か、非表示となります。

@end
