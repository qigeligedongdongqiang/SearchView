//
//  HistoryTableViewCell.m
//  JDSearchView
//
//  Created by Ngmm_Jadon on 2017/6/23.
//  Copyright © 2017年 Ngmm_Jadon. All rights reserved.
//

#import "HistoryTableViewCell.h"
#import "SearchModel.h"

@implementation HistoryTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setSearchModel:(SearchModel *)searchModel {
    _searchModel = searchModel;
    
    self.titleLabel.text = searchModel.name;
}

@end
