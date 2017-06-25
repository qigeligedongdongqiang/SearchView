//
//  InterestTableViewCell.h
//  JDSearchView
//
//  Created by Ngmm_Jadon on 2017/6/22.
//  Copyright © 2017年 Ngmm_Jadon. All rights reserved.
//

#import <UIKit/UIKit.h>

@class InterestModel;

typedef void(^LabelSelectBlock)(NSInteger index);

@interface InterestTableViewCell : UITableViewCell

@property (nonatomic, strong) InterestModel *interestModel;
@property (nonatomic, copy) LabelSelectBlock selectAction;

+ (CGFloat)cellHeightWithModel:(InterestModel *)model;

@end
