//
//  ViewController.h
//  ActiveWorld
//
//  Created by Eric Cao on 10/10/14.
//  Copyright (c) 2014 Eric Cao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "gameLevelController.h"
#import "messageTableViewController.h"
#import "webViewController.h"
#define MaxSport 2
#define MaxCommunity 2
#define MaxOutdoor 2

@interface ViewController : UIViewController<messageDelegate,UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *MessageBtn;
@property (weak, nonatomic) IBOutlet UIScrollView *SportMenu;

@property (weak, nonatomic) IBOutlet UIScrollView *CommunityMenu;
@property (weak, nonatomic) IBOutlet UIScrollView *OutdoorMenu;

@property (strong, nonatomic) NSArray *sortedMessageArray;


@property (strong ,nonatomic) gameLevelController *game;
- (IBAction)settingTap:(id)sender;

- (IBAction)messageTap:(id)sender;
@end

