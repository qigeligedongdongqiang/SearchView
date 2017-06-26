//
//  ViewController.m
//  JDSearchView
//
//  Created by Ngmm_Jadon on 2017/6/22.
//  Copyright © 2017年 Ngmm_Jadon. All rights reserved.
//

#import "ViewController.h"
#import "JDSearchViewController.h"
#import "SearchResultViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"首页";
    
    //搜索button
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.frame = CGRectMake(0, 0, 30, 30);
    searchBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
    [searchBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(searchBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:searchBtn];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(beginSearch:) name:BeginSearchKey object:nil];
}

- (void)searchBtnClick {
    [self presentViewController:[JDSearchViewController new] animated:NO completion:nil];
}

- (void)beginSearch:(NSNotification *)noti {
//    NSLog(@"%@",noti.userInfo);
    NSString *searchText = [NSString stringWithFormat:@"%@,%@",noti.userInfo[@"searchType"],noti.userInfo[@"searchText"]];
    [self.navigationController pushViewController:[[SearchResultViewController alloc] initWithSearchText:searchText] animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
