//
//  CommonUtility.h
//  completeImage
//
//  Created by 张力 on 14-8-18.
//  Copyright (c) 2014年 张力. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>


@interface CommonUtility : NSObject
{
    AVAudioPlayer *myAudioPlayer;
}

@property (nonatomic, strong) AVAudioPlayer *myAudioPlayer;

+ (CommonUtility *)sharedCommonUtility;
+ (BOOL)isSystemLangChinese;
+ (void)tapSound;
+ (void)tapSound:(NSString *)name withType:(NSString *)type;
+ (BOOL)isSystemVersionLessThan7;

+ (BOOL)checkFavoritesWithCurrentLevel:(int)levelNow;
+ (void)addToFavoratesWith:(int)level and:(NSString *)levelName By:(UIButton *)button;
+ (void)removeFavoratesWith:(int)level By:(UIButton *)button;
+ (void)removeFavoritesOnCell:(NSInteger)row;
@end
