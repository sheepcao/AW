//
//  CommonUtility.m
//  completeImage
//
//  Created by 张力 on 14-8-18.
//  Copyright (c) 2014年 张力. All rights reserved.
//

#import "CommonUtility.h"

@implementation CommonUtility
@synthesize myAudioPlayer;

+(CommonUtility *)sharedCommonUtility
{
    static CommonUtility *singleton;
    static dispatch_once_t token;
    dispatch_once(&token,^{
        singleton = [[CommonUtility alloc]init];
    });
    return singleton;
}

+ (BOOL)isSystemLangChinese
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *languages = [defaults objectForKey:@"AppleLanguages"];
    NSString *currentLang = [languages objectAtIndex:0];

    if([currentLang compare:@"zh-Hans" options:NSCaseInsensitiveSearch]==NSOrderedSame || [currentLang compare:@"zh-Hant" options:NSCaseInsensitiveSearch]==NSOrderedSame)
    {
        return YES;
    }else
    {
        return NO;
    }
}

+(void)tapSound
{
    SystemSoundID soundTap;
    
    CFBundleRef CNbundle=CFBundleGetMainBundle();
    
    CFURLRef soundfileurl=CFBundleCopyResourceURL(CNbundle,(__bridge CFStringRef)@"tapSound",CFSTR("wav"),NULL);
    //创建system sound 对象
    AudioServicesCreateSystemSoundID(soundfileurl, &soundTap);
    AudioServicesPlaySystemSound(soundTap);
}

+(BOOL)isSystemVersionLessThan7{
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1) {
        return YES;
    } else {
        return NO;
    }
}

+(void)tapSound:(NSString *)name withType:(NSString *)type
{
    
    NSString *soundFilePath = [[NSBundle mainBundle] pathForResource:name ofType:type];
    NSURL *fileURL = [[NSURL alloc] initFileURLWithPath:soundFilePath ];
    [CommonUtility sharedCommonUtility].myAudioPlayer= [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:nil];
    //    self.myAudioPlayer.numberOfLoops = -1; //infinite loop
    [[CommonUtility sharedCommonUtility].myAudioPlayer play];

}
@end
