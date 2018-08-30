//
//  SoundPlayer.m
//  Tetris
//
//  Created by apple on 2018/8/31.
//  Copyright © 2018年 QSP. All rights reserved.
//

#import "SoundPlayer.h"
#import <AVFoundation/AVFoundation.h>

@interface SoundPlayer ()

@end

@implementation SoundPlayer
/**
 *  存放所有的音频ID
 *  字典: filename作为key, soundID作为value
 */
static NSMutableDictionary *_soundIDs;

- (void)dealloc {
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
}

+ (void)tetrisMoveSoundPlaying {
    [self playSound:@"SEB_mino1"];
}
+ (void)tetrisRotationSoundPlaying {
    [self playSound:@"SEB_mino4"];
}
+ (void)tetrisRemoveSoundPlaying {
    [self playSound:@"SEB_platinum"];
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
    if (soundID) {
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
    AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)url, &soundID);
    [_soundIDs setValue:@(soundID) forKey:fileName];

    return soundID;
}

@end
