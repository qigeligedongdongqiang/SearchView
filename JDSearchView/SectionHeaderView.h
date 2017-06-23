//
//  SectionHeaderView.h
//  JDSearchView
//
//  Created by Ngmm_Jadon on 2017/6/23.
//  Copyright © 2017年 Ngmm_Jadon. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^accessoryBlock) ();

@interface SectionHeaderView : UITableViewHeaderFooterView

@property (weak, nonatomic) IBOutlet UILabel *sectionNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *accessoryBtn;

@property (nonatomic, copy) accessoryBlock accessAction;

@end
