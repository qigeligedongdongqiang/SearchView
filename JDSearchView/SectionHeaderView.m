//
//  SectionHeaderView.m
//  JDSearchView
//
//  Created by Ngmm_Jadon on 2017/6/23.
//  Copyright © 2017年 Ngmm_Jadon. All rights reserved.
//

#import "SectionHeaderView.h"

@implementation SectionHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.accessoryBtn addTarget:self action:@selector(accessoryBtnAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)accessoryBtnAction {
    if (self.accessAction) {
        self.accessAction();
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
