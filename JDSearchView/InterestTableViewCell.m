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

static CGFloat const labelH = 30;
static CGFloat const fontSize = 14;
static CGFloat const adjustW = 14;
static CGFloat const margin = 10;

static NSArray *subFrames;

@implementation InterestTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

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
    for (NSInteger i = 0; i < searchModels.count; i++) {
        SearchModel *searchModel = searchModels[i];
        YYLabel *label = [[YYLabel alloc] init];
        
        //设置标签frame
        NSValue *value = subFrames[i];
        label.frame = [value CGRectValue];
        
        //设置标签样式
        NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:searchModel.name];
        text.yy_alignment = NSTextAlignmentCenter;
        text.yy_font = [UIFont systemFontOfSize:fontSize];
        text.yy_color = [UIColor colorWithRed:122/255.0 green:122/255.0 blue:122/255.0 alpha:1];
        //设置背景框
        YYTextBorder *border = [YYTextBorder borderWithFillColor:[UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1] cornerRadius:labelH/2];
        CGSize textSize = [searchModel.name boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, labelH) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:fontSize]} context:nil].size;
        border.insets = UIEdgeInsetsMake(-(labelH - textSize.height)/2, -adjustW/2, -(labelH - textSize.height)/2, -adjustW/2);
        text.yy_textBackgroundBorder = border;
        //交互事件
        YYTextHighlight *highlight = [YYTextHighlight new];
        __weak typeof(self) weakSelf = self;
        highlight.tapAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
            [weakSelf selectLabelWithIndex:i];
        };
        [text yy_setTextHighlight:highlight range:NSMakeRange(0, text.length)];
        label.attributedText = text;
        [self.contentView addSubview:label];
    }
}

- (void)selectLabelWithIndex:(NSInteger)index {
    if (self.selectAction) {
        self.selectAction(index);
    }
}

+ (CGFloat)cellHeightWithModel:(InterestModel *)model {
    NSArray *searchModels = model.searchModels;
    CGRect previousFrame = CGRectMake(12-margin, margin, 0, labelH);
    CGRect newFrame = CGRectZero;
    NSMutableArray *frames = [NSMutableArray array];
    for (NSInteger i = 0; i < searchModels.count; i++) {
        SearchModel *searchModel = searchModels[i];
        CGSize textSize = [searchModel.name boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, labelH) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:fontSize]} context:nil].size;
        if (CGRectGetMaxX(previousFrame) + textSize.width + adjustW +12 < [UIScreen mainScreen].bounds.size.width) {
            newFrame = CGRectMake(CGRectGetMaxX(previousFrame) + margin, previousFrame.origin.y, textSize.width + adjustW, labelH);
            previousFrame = newFrame;
        } else {
            newFrame = CGRectMake(12, CGRectGetMaxY(previousFrame) + margin, textSize.width + adjustW, labelH);
            previousFrame = newFrame;
        }
        [frames addObject:[NSValue valueWithCGRect:newFrame]];
    }
    subFrames = frames;
    return CGRectGetMaxY(newFrame) + margin;
}

@end
