//
//  PublicInformation.h
//  JDZBorrower
//
//  Created by QSP on 2018/4/13.
//  Copyright © 2018年 Jingbeijinrong. All rights reserved.
//

#import "BaseM.h"

@interface PublicInformation : BaseM
@property (strong, nonatomic, readonly) UIImage *elementImage;
@property (assign, nonatomic) NSInteger highestScore;

+ (instancetype)shareInstance;
- (void)clear;

@end