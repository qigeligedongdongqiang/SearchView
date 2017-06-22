//
//  JDSearchViewController.m
//  JDSearchView
//
//  Created by Ngmm_Jadon on 2017/6/22.
//  Copyright © 2017年 Ngmm_Jadon. All rights reserved.
//

#import "JDSearchViewController.h"
#import "JDSearchBar.h"

@interface JDSearchViewController ()<UITableViewDataSource,UITableViewDelegate,JDSearchBarDelegate>

@property (nonatomic, strong) JDSearchBar *searchBar;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *interestArr;
@property (nonatomic, strong) NSMutableArray *historyArr;

@end

@implementation JDSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.interestArr = [NSMutableArray array];
    self.historyArr = [NSMutableArray array];
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.searchBar];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self loadInterestData];
}

- (void)loadInterestData {
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.historyArr.count>0) {
        return 2;
    } else {
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 1) {
        return 1;
    } else if (section == 2) {
        return self.historyArr.count;
    } else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.textLabel.text = @"ddd";
    return cell;
}

- (void)searchBarDidClickCancel:(JDSearchBar *)searchBar {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        
        _tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
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
