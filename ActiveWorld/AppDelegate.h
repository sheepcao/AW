//
//  AppDelegate.h
//  ActiveWorld
//
//  Created by Eric Cao on 10/10/14.
//  Copyright (c) 2014 Eric Cao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "globalVar.h"
#import "WXApi.h"


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

-(BOOL)isIOS7Plus;

@end

