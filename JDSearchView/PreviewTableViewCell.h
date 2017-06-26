//
//  PreviewTableViewCell.h
//  JDSearchView
//
//  Created by Ngmm_Jadon on 2017/6/26.
//  Copyright © 2017年 Ngmm_Jadon. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SearchModel;

typedef void(^UpSearchBlock)();

@interface PreviewTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *previewLabel;
@property (weak, nonatomic) IBOutlet UIButton *upTosearchBtn;
@property (nonatomic, copy) UpSearchBlock upSearchAction;

@property (nonatomic, strong) SearchModel *model;

@end
