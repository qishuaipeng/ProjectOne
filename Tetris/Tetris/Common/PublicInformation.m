//
//  PublicInformation.m
//  JDZBorrower
//
//  Created by QSP on 2018/4/13.
//  Copyright © 2018年 Jingbeijinrong. All rights reserved.
//

#import "PublicInformation.h"
#import "ReactiveObjC.h"

#define K_Public_HighestScore                  @"K_Public_HighestScore"


static PublicInformation *_shareInstance;

@interface PublicInformation ()


@end

@implementation PublicInformation
@synthesize elementImage = _elementImage;

- (UIImage *)elementImage {
    if (_elementImage == nil) {
        _elementImage = [ConFunc elementImage];
    }
    
    return _elementImage;
}

+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareInstance = [[self alloc] init];
    });
    
    return _shareInstance;
}
+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareInstance = [super allocWithZone:zone];
    });
    
    return _shareInstance;
}
- (instancetype)init {
    if (self = [super init]) {
        self.highestScore = [K_User_Defaults integerForKey:K_Public_HighestScore];
        [RACObserve(self, highestScore) subscribeNext:^(id  _Nullable x) {
            [K_User_Defaults setInteger:self.highestScore forKey:K_Public_HighestScore];
        }];
    }

    return self;
}
- (void)reloadData {
}
- (void)saveUserModel {

    [K_User_Defaults synchronize];
}
- (void)clear {
    for (id key in [[K_User_Defaults dictionaryRepresentation] allKeys]) {
        [K_User_Defaults removeObjectForKey:key];
    }
    
    [K_User_Defaults synchronize];
    [self reloadData];
}

@end
