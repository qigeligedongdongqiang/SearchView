//
//  JDSearchBar.h
//  JDSearchView
//
//  Created by Ngmm_Jadon on 2017/6/22.
//  Copyright © 2017年 Ngmm_Jadon. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JDSearchBar;

@protocol JDSearchBarDelegate <NSObject>

@optional
- (void)searchBarDidClickMore:(JDSearchBar *)searchBar;
- (void)searchBarDidClickCancel:(JDSearchBar *)searchBar;

- (void)searchBar:(JDSearchBar *)searchBar textFieldDidChange:(UITextField *)textField;
- (void)searchBar:(JDSearchBar *)searchBar textFieldWillSearch:(UITextField *)textField;

@end

@interface JDSearchBar : UIView

@property (nonatomic, assign, getter=isShowKeyBoardWhenEnter) BOOL showKeyBoardWhenEnter;
@property (nonatomic, copy) NSString *placeholder;
@property (nonatomic, strong) UIButton *moreBtn;
@property (nonatomic, weak) id<JDSearchBarDelegate> delegate;

@end
