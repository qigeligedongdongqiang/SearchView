//
//  ResultPreView.m
//  JDSearchView
//
//  Created by Ngmm_Jadon on 2017/6/26.
//  Copyright © 2017年 Ngmm_Jadon. All rights reserved.
//

#import "ResultPreView.h"
#import "PreviewTableViewCell.h"

#import "SearchModel.h"

@interface ResultPreView ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSourceArr;

@end

@implementation ResultPreView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}

- (void)setUp {
    self.dataSourceArr = [NSMutableArray array];
    
    [self addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([PreviewTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([PreviewTableViewCell class])];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.tableView.frame = self.bounds;
}

- (void)setSearchText:(NSString *)searchText {
    _searchText = searchText;
    
    [self beginSearch];
}

- (void)beginSearch {
    //模拟向后台匹配后返回数据
    [self.dataSourceArr removeAllObjects];
    SearchModel *searchModelOne = [[SearchModel alloc] init];
    searchModelOne.name = self.searchText;
    SearchModel *searchModelTwo = [[SearchModel alloc] init];
    searchModelTwo.name = @"我是测试";
    [self.dataSourceArr addObject:searchModelOne];
    [self.dataSourceArr addObject:searchModelTwo];
    [self.tableView reloadData];
}

#pragma mark - dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSourceArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PreviewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PreviewTableViewCell class])];
    SearchModel *model;
    if (indexPath.row < self.dataSourceArr.count) {
        model = self.dataSourceArr[indexPath.row];
    }
    cell.model = model;
    
    __weak typeof(self) weakSelf = self;
    cell.upSearchAction = ^{
        if (weakSelf.upToAction) {
            weakSelf.upToAction(model.name);
        }
    };
    return cell;
}

#pragma mark - delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < self.dataSourceArr.count) {
        SearchModel *model = self.dataSourceArr[indexPath.row];
        if (self.selectAction) {
            self.selectAction(model.name);
        }
    }
}

#pragma mark - lazyLoad
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        
        _tableView.separatorInset = UIEdgeInsetsMake(0, 12, 0, 12);
    }
    return _tableView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
