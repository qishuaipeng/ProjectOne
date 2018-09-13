//
//  ModeViewController.m
//  Tetris
//
//  Created by QSP on 2018/9/12.
//  Copyright © 2018年 QSP. All rights reserved.
//

#import "ModeViewController.h"

@interface ModeViewController ()

@property (weak, nonatomic) UITableView *tableView;

@end

@implementation ModeViewController

+ (instancetype)controllerWithVM:(ModeVM *)vm {
    return [[self alloc] initWithVM:vm];
}
- (instancetype)initWithVM:(ModeVM *)vm {
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
    UIButton *completionB = [UIButton buttonWithType:UIButtonTypeCustom];
    [completionB setTitle:@"完成" forState:UIControlStateNormal];
    [completionB setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [completionB addTarget:self action:@selector(completionAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:completionB];
    
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
        CellM *cellM = [self.vm.tableViewVM rowVMWithIndexPath:obj.indexPath].dataM;
        if (!cellM.selected) {
            cellM.selected = YES;
        }
        if (obj.indexPath.row == 0) {
            self.vm.tetrisType = TetrisTypeReverse;
        } else {
            self.vm.tetrisType = TetrisTypeNormal;
        }
    }];
}

- (void)completionAction:(UIButton *)sender {
    if (self.vm.tetrisVMType == TetrisVMTypePlaying || self.vm.tetrisVMType == TetrisVMTypePaused) {
        UIAlertController *nextCtr = [UIAlertController alertControllerWithTitle:nil message:@"您有一局游戏尚未结束，该操作会结束游戏，是否继续？" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [self changeType];
        }];
        [nextCtr addAction:cancelAction];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self changeType];
        }];
        [nextCtr addAction:okAction];
        [self presentViewController:nextCtr animated:YES completion:nil];
    } else {
        [self changeType];
    }
}
- (void)changeType {
    if (K_PublicInformation.tetrisType != self.vm.tetrisType) {
        K_PublicInformation.tetrisType = self.vm.tetrisType;
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
