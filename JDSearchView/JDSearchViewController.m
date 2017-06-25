//
//  JDSearchViewController.m
//  JDSearchView
//
//  Created by Ngmm_Jadon on 2017/6/22.
//  Copyright © 2017年 Ngmm_Jadon. All rights reserved.
//

#import "JDSearchViewController.h"

#import "JDSearchBar.h"
#import "SectionHeaderView.h"
#import "InterestTableViewCell.h"
#import "HistoryTableViewCell.h"

#import "MJExtension.h"
#import "InterestModel.h"
#import "SearchModel.h"

NSString *const BeginSearchKey = @"SearchViewBeginSearch";

@interface JDSearchViewController ()<UITableViewDataSource,UITableViewDelegate,JDSearchBarDelegate>

@property (nonatomic, strong) JDSearchBar *searchBar;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) InterestModel *interestModel;
@property (nonatomic, strong) NSMutableArray *historyArr;

@end

@implementation JDSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.historyArr = [NSMutableArray array];
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.searchBar];
    
    [self registerCell];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self loadInterestData];
    [self loadHistoryData];
}

- (void)registerCell {
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SectionHeaderView class]) bundle:nil] forHeaderFooterViewReuseIdentifier:NSStringFromClass([SectionHeaderView class])];
    [self.tableView registerClass:[InterestTableViewCell class] forCellReuseIdentifier:NSStringFromClass([InterestTableViewCell class])];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HistoryTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([HistoryTableViewCell class])];
}

#pragma mark - loadData
- (void)loadInterestData {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Interest" ofType:@"plist"];
    NSDictionary *dataDict = [NSDictionary dictionaryWithContentsOfFile:path];
    self.interestModel = [InterestModel mj_objectWithKeyValues:dataDict];
    
    if (self.interestModel.hotSearch) {
        self.searchBar.placeholder = self.interestModel.hotSearch;
    }
}

- (void)loadHistoryData {
    self.historyArr = [SearchModel findAll].mutableCopy;
}

#pragma mark - tableView dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.historyArr.count>0) {
        return 2;
    } else {
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        return self.historyArr.count;
    } else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        InterestTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([InterestTableViewCell class])];
        cell.interestModel = self.interestModel;
        __weak typeof(self) weakSelf = self;
        cell.selectAction = ^(NSInteger index) {
            __strong typeof(self) strongSelf = weakSelf;
            if (index < strongSelf.interestModel.searchModels.count) {
                [strongSelf searchWithModel:strongSelf.interestModel.searchModels[index]];
            }
        };
        return cell;
    } else if (indexPath.section == 1) {
        HistoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HistoryTableViewCell class])];
        if (indexPath.row < self.historyArr.count) {
            cell.searchModel = self.historyArr[indexPath.row];
        }
        return cell;
    }
    return nil;
}

#pragma mark - tableView delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return [InterestTableViewCell cellHeightWithModel:self.interestModel];
    } else {
        return 44;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    SectionHeaderView *sectionHeaderView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([SectionHeaderView class])];
    if (section == 0) {
        sectionHeaderView.sectionNameLabel.text = @"感兴趣";
        sectionHeaderView.accessoryBtn.hidden = YES;
    } else if (section == 1) {
        sectionHeaderView.sectionNameLabel.text = @"搜索历史";
        sectionHeaderView.accessoryBtn.hidden = NO;
        
        [sectionHeaderView.accessoryBtn setImage:[[UIImage imageNamed:@"delete"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        __weak typeof(self) weakSelf = self;
        sectionHeaderView.accessAction = ^{
            [weakSelf deleteAllHistory];
        };
    }
    
    return sectionHeaderView;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        return YES;
    }
    return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        if (indexPath.row<self.historyArr.count) {
            [self deleteHistoryWithIndex:indexPath.row];
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        if (indexPath.row < self.historyArr.count) {
            [self searchWithModel:self.historyArr[indexPath.row]];
        }
    }
}

#pragma mark - searchBar delegate
- (void)searchBarDidClickMore:(JDSearchBar *)searchBar {
    
}

- (void)searchBarDidClickCancel:(JDSearchBar *)searchBar {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)searchBar:(JDSearchBar *)searchBar textFieldDidChange:(UITextField *)textField {
    
}

- (void)searchBar:(JDSearchBar *)searchBar textFieldWillSearch:(UITextField *)textField {
    NSString *searchText;
    if (![textField.text isEqualToString:@""]) {
        searchText = textField.text;
    } else if (textField.placeholder) {
        searchText = textField.placeholder;
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:BeginSearchKey object:nil userInfo:@{@"searchText" : searchText}];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - actions
- (void)searchWithText:(NSString *)text {
    [[NSNotificationCenter defaultCenter] postNotificationName:BeginSearchKey object:nil userInfo:@{@"searchText" : text}];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)searchWithModel:(SearchModel *)model {
    NSArray *result = [SearchModel findFormatSqlConditions:@"where name = %@",sqlValue(model.name)];
    BOOL isExist = result.count > 0;
    if (!isExist) {
        [model save];
    }
    [self searchWithText:model.name];
}

- (void)deleteAllHistory {
    [SearchModel clear];
    [self.historyArr removeAllObjects];
    [self.tableView reloadData];
}

- (void)deleteHistoryWithIndex:(NSInteger)index {
    [self.historyArr removeObjectAtIndex:index];
    [self.tableView reloadData];
}

#pragma mark - lazyLoad
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        
        _tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
        _tableView.sectionFooterHeight = 0;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (JDSearchBar *)searchBar {
    if (!_searchBar) {
        _searchBar = [[JDSearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 64)];
        _searchBar.delegate = self;
    }
    return _searchBar;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
