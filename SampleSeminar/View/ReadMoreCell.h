//
//  ReadMoreCell.h
//  SampleSeminar
//
//  Created by Kenji Tazawa on 12/08/10.
//  Copyright (c) 2012年 CONIT Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 * もっと読む、読み込み中のフッターを表示するUITableViewCellです。
 */
@interface ReadMoreCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *cellReadMoreLabel;

@end
