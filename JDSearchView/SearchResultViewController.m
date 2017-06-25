//
//  SearchResultViewController.m
//  JDSearchView
//
//  Created by JADON on 2017/6/25.
//  Copyright © 2017年 Ngmm_Jadon. All rights reserved.
//

#import "SearchResultViewController.h"

@interface SearchResultViewController ()

@property (nonatomic, copy) NSString *searchText;

@end

@implementation SearchResultViewController

- (instancetype)initWithSearchText:(NSString *)text {
    if (self = [super init]) {
        _searchText = text;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"搜索结果页";
    
    UILabel *label = [[UILabel alloc] init];
    label.center = self.view.center;
    label.bounds = CGRectMake(0, 0, self.view.bounds.size.width, 50);
    label.textAlignment = NSTextAlignmentCenter;
    label.text = self.searchText;
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = [UIColor blackColor];
    [self.view addSubview:label];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
