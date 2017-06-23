//
//  InterestTableViewCell.m
//  JDSearchView
//
//  Created by Ngmm_Jadon on 2017/6/22.
//  Copyright © 2017年 Ngmm_Jadon. All rights reserved.
//

#import "InterestTableViewCell.h"
#import "InterestModel.h"
#import "SearchModel.h"
#import "YYText.h"

@implementation InterestTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setInterestModel:(InterestModel *)interestModel {
    _interestModel = interestModel;
    
    [self setUpSubviewsWithModel:interestModel];
}

- (void)setUpSubviewsWithModel:(InterestModel *)model {
    NSArray *searchModels = model.searchModels;
    CGFloat margin = 5;
    CGRect previousFrame = CGRectMake(12, 0, 0, 44);
    for (NSInteger i = 0; i < searchModels.count; i++) {
        SearchModel *searchModel = searchModels[i];
        NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:searchModel.name];
        text.yy_font = [UIFont boldSystemFontOfSize:14];
        text.yy_color = [UIColor blueColor];
        [text yy_setColor:[UIColor lightGrayColor] range:NSMakeRange(0, searchModel.name.length)];
        YYLabel *label = [YYLabel new];
        CGSize textSize = [searchModel.name boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 44) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size;
        if (CGRectGetMaxX(previousFrame) + textSize.width +12 < self.contentView.bounds.size.width) {
            label.frame = CGRectMake(CGRectGetMaxX(previousFrame) + margin, previousFrame.origin.y, textSize.width, 44);
            previousFrame = label.frame;
        } else {
            label.frame = CGRectMake(12, CGRectGetMaxY(previousFrame) + margin, textSize.width, 44);
            previousFrame = label.frame;
        }
        label.attributedText = text;
        label.highlightTapAction = ^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
            
        };
        [self.contentView addSubview:label];
    }
    
}

@end
