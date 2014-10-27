//
//  gameLevelController.h
//  completeImage
//
//  Created by 张力 on 14-6-22.
//  Copyright (c) 2014年 张力. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "teachingView.h"
#import "sharePhotoViewController.h"
#import "uncompleteImage.h"
#import "globalVar.h"


static const int MAXlevel = 6;
static const int MAXanswer = 3;
//static const int bigLevel = 6;

bool levelLock[bigLevel];

@protocol messageDelegate <NSObject>

-(void)addMessage:(int)level andName:(NSString *)levelName Dir:(NSURL *)dir;

@end

@interface gameLevelController : UIViewController<AVAudioRecorderDelegate, AVAudioPlayerDelegate>
{
    int correct[MAXlevel];
    NSTimer *ADTimer;
    AVAudioRecorder *recorder;
    //AVAudioPlayer *player;

}
@property (nonatomic , weak) id <messageDelegate> mesgDelegate;
@property (nonatomic, strong) AVAudioPlayer *player;



@property (weak, nonatomic) IBOutlet UIImageView *backIMG;

@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
@property (strong, nonatomic) UIImage *backgroundImg;
//@property (strong, nonatomic) NSString *backgroundNames;

@property (strong, nonatomic)  UIButton *animationBegin;
@property (strong, nonatomic)  UIImageView *picture;
@property (strong, nonatomic)  UIButton *answer1;
@property (strong, nonatomic)  UIButton *answer2;
@property (strong, nonatomic)  UIButton *answer3;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UIButton *FavoriteButton;
@property (strong,nonatomic) NSMutableArray *choices;
@property (strong, nonatomic) IBOutlet UIButton *empty;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
@property (weak, nonatomic) IBOutlet UILabel *levelCount;
@property (strong, nonatomic) teachingView *teachView;
@property (strong, nonatomic) UIImageView *wrongLabel;
@property (strong,nonatomic) uncompleteImage *myImg;
@property (strong,nonatomic) NSString *emptyGif;
@property (strong,nonatomic) UIWebView *webView;
@property (strong,nonatomic) UIImageView *questionMark;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (nonatomic, assign) BOOL isFormRewordFlag;

@property (nonatomic ,strong) NSNumber *levelNumber;
@property (nonatomic ,strong) NSTimer *timer;
- (IBAction)priorLevel;
- (IBAction)nextLevel;
- (IBAction)backToLevel;
//- (IBAction)share;
- (IBAction)animationTapped:(id)sender;
- (IBAction)registerOnline:(id)sender;

@end
