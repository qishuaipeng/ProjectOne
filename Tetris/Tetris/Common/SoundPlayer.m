//
//  SoundPlayer.m
//  Tetris
//
//  Created by apple on 2018/8/31.
//  Copyright © 2018年 QSP. All rights reserved.
//

#import "SoundPlayer.h"
#import <AVFoundation/AVFoundation.h>
#import "ReactiveObjC.h"

@interface SoundPlayer ()

@end

@implementation SoundPlayer
/**
 *  存放所有的音频ID
 *  字典: filename作为key, soundID作为value
 */
static NSMutableDictionary *_soundIDs;

+ (void)removeSoundIDs {
    [_soundIDs enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [self.class disposeSound:key];
    }];
    [_soundIDs removeAllObjects];
}
+ (void)initialize {
    _soundIDs = [NSMutableDictionary dictionaryWithCapacity:1];
    
    //设置会话类型
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryAmbient error:nil];
    //激活会话
    [session setActive:YES error:nil];
    
    [RACObserve(K_PublicInformation, sound) subscribeNext:^(id  _Nullable x) {
        if (!K_PublicInformation.sound) {
            [self removeSoundIDs];
        }
    }];
}

+ (void)tetrisMoveSoundPlaying {
    [self playSound:@"MOVE_SOUND.mp3"];
}
+ (void)tetrisDownSoundPlaying {
    [self playSound:@"BRICK_FINISHEDMOVE.mp3"];
}
+ (void)tetrisRotationSoundPlaying {
    [self playSound:@"ROTATE_SOUND.mp3"];
}
+ (void)tetrisRemoveSoundPlaying {
    [self playSound:@"EXPLOSION.mp3"];
}
+ (void)tetrisNewSoundPlaying {
    [self playSound:@"NEW_LEVEL.mp3"];
}
+ (void)tetrisBeginSoundPlaying {
    [self playSound:@"ENGINE.wav"];
}
+ (void)tetrisOverSoundPlaying {
    [self playSound:@"GAME_OVER.mp3"];
}
+ (void)tetrisPhysicalSoundPlaying {
    [self playSound:@"PHYSICAL_BUTTON_SOUND.mp3"];
}

/**
 *  播放音效
 *
 *  @param fileName 音效文件名
 */
+ (void)playSound:(NSString *)fileName
{
    if ([ConFunc blankOfStr:fileName]) {
        return;
    }
    SystemSoundID soundID = [self achieveSoundID:fileName];
    if (soundID && K_PublicInformation.sound) {
        AudioServicesPlaySystemSound(soundID);
    }
}
/**
 *  销毁音效
 *
 *  @param fileName 音效文件名
 */
+ (void)disposeSound:(NSString *)fileName
{
    if ([ConFunc blankOfStr:fileName]) {
        return;
    }
    SystemSoundID soundID = [[_soundIDs valueForKey:fileName] unsignedIntValue];
    if (soundID) {
        AudioServicesDisposeSystemSoundID(soundID);
        //移除soundID
        [_soundIDs removeObjectForKey:fileName];
    }
}

/**
 *  根据文件名查找soundID
 *
 *  @param fileName 文件名
 *
 *  @return soundID
 */
+ (SystemSoundID)achieveSoundID:(NSString *)fileName
{
    if ([ConFunc blankOfStr:fileName]) {
        return 0;
    }
    SystemSoundID soundID = [_soundIDs[fileName] unsignedIntValue];
    if (!soundID) {
        soundID = [self createSoundID:fileName];
    }
    
    return soundID;
}
+ (SystemSoundID)createSoundID:(NSString *)fileName {
    SystemSoundID soundID;
    //加载音效文件
    NSURL *url = [[NSBundle mainBundle] URLForResource:fileName withExtension:nil];
    OSStatus error = AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)url, &soundID);
    if (error != kAudioSessionNoError) {
        DebugLog(@"----------error:%i", (int)error);
    }
    
    [_soundIDs setValue:@(soundID) forKey:fileName];

    return soundID;
}

@end
