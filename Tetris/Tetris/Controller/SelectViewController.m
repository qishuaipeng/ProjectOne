//
//  SelectViewController.m
//  Tetris
//
//  Created by QSP on 2018/9/6.
//  Copyright © 2018年 QSP. All rights reserved.
//

#import "SelectViewController.h"

@interface SelectViewController ()

@property (weak, nonatomic) UITableView *tableView;

@end

@implementation SelectViewController

+ (instancetype)controllerWithVM:(SelectVM *)vm {
    return [[self alloc] initWithVM:vm];
}
- (instancetype)initWithVM:(SelectVM *)vm {
    if (self = [super init]) {
        _vm = vm;
    }
    
    return self;
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
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

@end
