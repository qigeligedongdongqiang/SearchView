//
//  JDSearchBar.m
//  JDSearchView
//
//  Created by Ngmm_Jadon on 2017/6/22.
//  Copyright © 2017年 Ngmm_Jadon. All rights reserved.
//

#import "JDSearchBar.h"

@interface JDSearchBar ()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *textField;

@end

static CGFloat const paddingLR = 12;
static CGFloat const paddingTop = 27;
static CGFloat const paddingBottom = 7;
static CGFloat const marginCenter = 10;

static CGFloat const moreBtnW = 35;
static CGFloat const cancelBtnW = 30;

@implementation JDSearchBar

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setConfig];
        [self setUpSubviews];
    }
    return self;
}

- (void)setConfig {
    self.backgroundColor = [UIColor colorWithWhite:1 alpha:0.97];
    _placeholder = @"搜索";
    _showKeyBoardWhenEnter = YES;
}

- (void)setUpSubviews {
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake(self.bounds.size.width - paddingLR - cancelBtnW, paddingTop, cancelBtnW, self.bounds.size.height - paddingTop - paddingBottom);
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cancelBtn];
    
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(paddingLR, paddingTop, self.bounds.size.width - 2 * paddingLR -cancelBtnW - marginCenter, self.bounds.size.height - paddingTop - paddingBottom)];
    contentView.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
    contentView.layer.cornerRadius = contentView.bounds.size.height / 2;
    contentView.layer.masksToBounds = YES;
    [self addSubview:contentView];
    
    UIButton *moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    moreBtn.frame = CGRectMake(paddingLR, 0, moreBtnW, contentView.bounds.size.height);
    moreBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [moreBtn setImage:[UIImage imageNamed:@"arrowDown"] forState:UIControlStateNormal];
    [moreBtn setTitle:@"宝贝" forState:UIControlStateNormal];
    [moreBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [moreBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -moreBtn.imageView.bounds.size.width, 0, moreBtn.imageView.bounds.size.width)];
    [moreBtn setImageEdgeInsets:UIEdgeInsetsMake(0, moreBtn.titleLabel.bounds.size.width, 0, -moreBtn.titleLabel.bounds.size.width)];
    [moreBtn addTarget:self action:@selector(moreBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:moreBtn];
    self.moreBtn = moreBtn;
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(paddingLR + moreBtn.bounds.size.width + marginCenter, 0, contentView.bounds.size.width - paddingLR - moreBtn.bounds.size.width - marginCenter, contentView.bounds.size.height)];
    textField.delegate = self;
    textField.font = [UIFont systemFontOfSize:12];
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.returnKeyType = UIReturnKeySearch;
    textField.placeholder = self.placeholder;
    self.textField = textField;
    [contentView addSubview:textField];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.isShowKeyBoardWhenEnter) {
        [self.textField becomeFirstResponder];
    }
}

#pragma mark - actions
- (void)moreBtnClick {
    if ([self.delegate respondsToSelector:@selector(searchBarDidClickMore:)]) {
        [self.delegate searchBarDidClickMore:self];
    }
}

- (void)cancelBtnClick {
    if ([self.delegate respondsToSelector:@selector(searchBarDidClickCancel:)]) {
        [self.textField endEditing:YES];
        [self.delegate searchBarDidClickCancel:self];
    }
}

#pragma mark - uitextfield delegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([self.delegate respondsToSelector:@selector(searchBar:textFieldDidChange:)]) {
        [self.delegate searchBar:self textFieldDidChange:textField];
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if ([self.delegate respondsToSelector:@selector(searchBar:textFieldWillSearch:)]) {
        [self.delegate searchBar:self textFieldWillSearch:textField];
    }
    return YES;
}

#pragma mark - setter
- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = placeholder;
    self.textField.placeholder = placeholder;
}

@end
