//
//  SoundPlayer.h
//  Tetris
//
//  Created by apple on 2018/8/31.
//  Copyright © 2018年 QSP. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SoundPlayer : NSObject

+ (void)tetrisMoveSoundPlaying;
+ (void)tetrisDownSoundPlaying;
+ (void)tetrisRotationSoundPlaying;
+ (void)tetrisRemoveSoundPlaying;
+ (void)tetrisNewSoundPlaying;
+ (void)tetrisBeginSoundPlaying;
+ (void)tetrisOverSoundPlaying;
+ (void)tetrisPhysicalSoundPlaying;

@end
