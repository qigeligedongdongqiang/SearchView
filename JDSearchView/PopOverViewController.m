//
//  PopOverViewController.m
//  JDSearchView
//
//  Created by Ngmm_Jadon on 2017/6/26.
//  Copyright © 2017年 Ngmm_Jadon. All rights reserved.
//

#import "PopOverViewController.h"

@interface PopOverViewController ()<UIPopoverPresentationControllerDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UIView *sourceView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArr;

@end

static CGFloat const rowHeight = 30;

@implementation PopOverViewController

- (instancetype)initWithSourceView:(UIView *)sourceView {
    if (self = [super init]) {
        _sourceView = sourceView;
        self.modalPresentationStyle = UIModalPresentationPopover;
        self.popoverPresentationController.delegate = self;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dataArr = @[@"宝贝",@"天猫",@"店铺"];
    [self setConfig];
    
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
}

- (void)setConfig {
    self.popoverPresentationController.sourceView =  self.sourceView;
    self.popoverPresentationController.sourceRect = self.sourceView.bounds;
    self.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionUp;
    self.preferredContentSize = CGSizeMake(70, rowHeight * self.dataArr.count);
    self.popoverPresentationController.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
}

#pragma mark -UIPopoverPresentationControllerDelegate
- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller {
    return UIModalPresentationNone;
}

#pragma mark - tableView dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:15];
    if (indexPath.row < self.dataArr.count) {
        cell.textLabel.text = self.dataArr[indexPath.row];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return  cell;
}

#pragma mark - tableView delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return rowHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < self.dataArr.count) {
        if ([self.delegate respondsToSelector:@selector(popView:didSelectTitle:)]) {
            [self.delegate popView:self didSelectTitle:self.dataArr[indexPath.row]];
            [self dismissViewControllerAnimated:NO completion:nil];
        }
    }
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _tableView.separatorColor = [UIColor blackColor];
    }
    return _tableView;
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
