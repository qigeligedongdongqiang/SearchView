//
//  HistoryTableViewCell.h
//  JDSearchView
//
//  Created by Ngmm_Jadon on 2017/6/23.
//  Copyright © 2017年 Ngmm_Jadon. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SearchModel;

@interface HistoryTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (nonatomic, strong) SearchModel *searchModel;

@end
