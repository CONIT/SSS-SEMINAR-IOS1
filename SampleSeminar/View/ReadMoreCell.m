//
//  ReadMoreCell.m
//  SampleSeminar
//
//  Created by Kenji Tazawa on 12/08/10.
//  Copyright (c) 2012年 CONIT Co., Ltd. All rights reserved.
//

#import "ReadMoreCell.h"

@implementation ReadMoreCell

@synthesize cellReadMoreLabel = _cellReadMoreLabel;

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
