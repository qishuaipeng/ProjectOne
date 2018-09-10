//
//  MainVM.h
//  MiningInterestingly
//
//  Created by QSP on 2018/8/16.
//  Copyright © 2018年 Jingbeijinrong. All rights reserved.
//

#import "BaseVM.h"
#import "QSPTableViewVM.h"
#import "TetrisVM.h"
#import "PreviewVM.h"

@interface MainVM : BaseVM

@property (strong, nonatomic) TetrisVM *tetrisVM;
@property (strong, nonatomic) PreviewVM *previewVM;
@property (strong, nonatomic) RACCommand *pauseCommand;
@property (strong, nonatomic) RACCommand *resetCommand;
@property (strong, nonatomic) RACCommand *soundCommand;
@property (strong, nonatomic) RACCommand *setCommand;
@property (strong, nonatomic) RACCommand *upCommand;
@property (strong, nonatomic) RACCommand *leftCommand;
@property (strong, nonatomic) RACCommand *rightCommand;
@property (strong, nonatomic) RACCommand *downCommand;
@property (strong, nonatomic) RACCommand *rotationCommand;
@property (assign, nonatomic) BOOL statusBarShow;

@end
