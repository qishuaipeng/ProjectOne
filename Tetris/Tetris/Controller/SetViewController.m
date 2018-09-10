//
//  SetViewController.m
//  Tetris
//
//  Created by QSP on 2018/9/2.
//  Copyright © 2018年 QSP. All rights reserved.
//

#import "SetViewController.h"
#import "SelectViewController.h"

@interface SetViewController ()

@property (weak, nonatomic) UITableView *tableView;

@end

@implementation SetViewController
+ (instancetype)controllerWithVM:(SetVM *)vm {
    return [[self alloc] initWithVM:vm];
}
- (instancetype)initWithVM:(SetVM *)vm {
    if (self = [super init]) {
        _vm = vm;
    }
    
    return self;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
- (BOOL)prefersStatusBarHidden {
    return self.vm.statusBarHidden;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self.navigationController setNavigationBarHidden:NO animated:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self settingUI];
    [self bindViewModel];
}
- (void)settingUI {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableView.backgroundColor = [UIColor clearColor];
    [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
}
- (void)bindViewModel {
    self.title = self.vm.title;
    self.tableView.vmSet(self.vm.tableViewVM);
    
    @weakify(self);
    [self.tableView.vm.didSelectRowSignal subscribeNext:^(QSPTableViewAndIndexPath *obj) {
        @strongify(self);
        SelectViewController *nextCtr = [SelectViewController controllerWithVM:[SelectVM selectVMWithM:[obj.tableView.vm rowVMWithIndexPath:obj.indexPath].dataM]];
        [self.navigationController pushViewController:nextCtr animated:YES];
    }];
}

@end
