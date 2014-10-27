//
//  globalVar.h
//  completeImage
//
//  Created by 张力 on 14-6-25.
//  Copyright (c) 2014年 张力. All rights reserved.
//

#ifndef completeImage_globalVar_h
#define completeImage_globalVar_h

#define IPhoneHeight (([UIScreen mainScreen].bounds.size.height == 568.0)?568:460)
#define TIME_PARENT 120

#define bigLevel 5

#import "CommonUtility.h"
//#import <ShareSDK/ShareSDK.h>

int level ;
NSNumber *levelSaved;
int levelTop;
NSMutableArray *haveShared;
NSMutableArray *scores;
NSString *haveSharedString;

int seconds;
BOOL isAnimating;

NSArray *sharePic;
NSArray *sharePic480;

NSMutableArray *messageArray;


@protocol  backToLevelDelegate<NSObject>

-(BOOL) isFromReward :(BOOL)check;
@end



#endif
