//
//  messageTableViewController.h
//  ActiveWorld
//
//  Created by Eric Cao on 10/16/14.
//  Copyright (c) 2014 Eric Cao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "globalVar.h"
#import "gameLevelController.h"

@interface messageTableViewController : UITableViewController
{
    AVAudioRecorder *recorder;
    AVAudioPlayer *player;
}

@property (nonatomic ,strong) NSMutableArray *messageList;

@end
