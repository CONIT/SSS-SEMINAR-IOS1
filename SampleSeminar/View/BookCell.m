//
//  BookCell.m
//  SampleSeminar
//
//  Created by Kenji Tazawa on 12/07/23.
//  Copyright (c) 2012年 CONIT Co., Ltd. All rights reserved.
//

#import "BookCell.h"

@implementation BookCell

@synthesize cellTitleLabel  = _cellTitleLabel;
@synthesize cellAuthorLabel = _cellAuthorLabel;
@synthesize cellPriceLabel  = _cellPriceLabel;
@synthesize cellOptionLabel = _cellOptionLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
  }
  return(self);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
  [super setSelected:selected animated:animated];
}

@end
