//
//  PreviewTableViewCell.m
//  JDSearchView
//
//  Created by Ngmm_Jadon on 2017/6/26.
//  Copyright © 2017年 Ngmm_Jadon. All rights reserved.
//

#import "PreviewTableViewCell.h"
#import "SearchModel.h"

@implementation PreviewTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self.upTosearchBtn addTarget:self action:@selector(upTosearchBtnAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(SearchModel *)model {
    _model = model;
    
    self.previewLabel.text = model.name;
}

- (void)upTosearchBtnAction {
    if (self.upSearchAction) {
        self.upSearchAction();
    }
}

@end
