//
//  ViewController.m
//  ActiveWorld
//
//  Created by Eric Cao on 10/10/14.
//  Copyright (c) 2014 Eric Cao. All rights reserved.
//

#import "ViewController.h"
#import <EventKit/EventKit.h>
#import "FeedbackViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize SportMenu;
@synthesize CommunityMenu;
@synthesize OutdoorMenu;
@synthesize game;
@synthesize MessageBtn;
@synthesize sortedMessageArray;

- (void)navigationController:(UINavigationController *)qnavigationController
      willShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated
{
    UIBarButtonItem *back;
//        UIBarButtonItem *back = [[UIBarButtonItem alloc]
//                                 initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
    if ([viewController isKindOfClass:[gameLevelController class]] ) {
        back = [[UIBarButtonItem alloc]
                                 initWithTitle:@"Active App" style:UIBarButtonItemStylePlain target:nil action:nil];
    }else
        back = [[UIBarButtonItem alloc]
                                 initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
//    back.tintColor = [UIColor redColor];
//        [[UIBarButtonItem appearance] setTintColor:[UIColor redColor]];
    

        
        viewController.navigationItem.backBarButtonItem = back;
    
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSError *error;

    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord error:&error];
    
    [[AVAudioSession sharedInstance] overrideOutputAudioPort:AVAudioSessionPortOverrideSpeaker
                                                       error:&error];
    
    [[AVAudioSession sharedInstance] setActive: YES error: nil];


    
    self.navigationController.delegate = self;
    // Do any additional setup after loading the view, typically from a nib.
    
    game = [[gameLevelController alloc] initWithNibName:@"gameLevelController" bundle:nil];
    game.mesgDelegate = self;
    
    messageArray = [[NSMutableArray alloc] init];
    
    [messageArray setArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"messageArray"]];

// calendar import
//    UIButton *testCalendar = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 60, 30)];
//    [testCalendar setTitle:@"import" forState:UIControlStateNormal];
//    testCalendar.layer.borderWidth = 1.0;
//    [testCalendar addTarget:self action:@selector(goCal) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:testCalendar];
}

//calendar import
//-(void)goCal
//{
//    EKEventStore *store = [[EKEventStore alloc] init];
//    [store requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
//        if (!granted) { return; }
//        EKEvent *event = [EKEvent eventWithEventStore:store];
//        event.location = @"hha";
//        event.title = @"Event Title";
//        event.startDate = [NSDate date]; //today
//        event.endDate = [event.startDate dateByAddingTimeInterval:60*60];  //set 1 hour meeting
//        [event setCalendar:[store defaultCalendarForNewEvents]];
//        NSError *err = nil;
//        [store saveEvent:event span:EKSpanThisEvent commit:YES error:&err];
//        NSString *savedEventId = event.eventIdentifier;  //this is so you can access this event later
//    }];
//}
//
-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:NO];

}
-(void)viewDidAppear:(BOOL)animated
{
    int level = 1;
    level = [self initScorll:SportMenu withSeed:level withMax:MaxSport];
    level = [self initScorll:CommunityMenu withSeed:level withMax:MaxSport + MaxCommunity];
    level = [self initScorll:OutdoorMenu withSeed:level withMax:MaxSport + MaxCommunity + MaxOutdoor];

}

-(int)initScorll:(UIScrollView *)myScroll withSeed:(int)seed withMax:(int)levelMax;
{
    int position = 0;
    
    myScroll.contentSize =CGSizeMake(myScroll.frame.size.width, myScroll.frame.size.height*1.5);
    myScroll.contentOffset = CGPointMake(0, -myScroll.frame.size.height/4);
    myScroll.contentInset = UIEdgeInsetsMake(2,0,0,0);
//    NSLog(@"scroll:%@",myScroll);
    for (int i = seed; i <= levelMax; i++)
    {
        
        UIButton *contentButton = [[UIButton alloc] initWithFrame:CGRectMake(5, 5+position * myScroll.frame.size.width, myScroll.frame.size.width-10, myScroll.frame.size.width-10)];
        contentButton.tag = i;
        [contentButton setImage:[UIImage imageNamed:[NSString stringWithFormat:@"pic%d",i]] forState:UIControlStateNormal];
        [contentButton addTarget:self action:@selector(chooseLevel:) forControlEvents:UIControlEventTouchUpInside];
        seed = i;
        [myScroll addSubview:contentButton];
        position++;
    }
    seed++;
    return seed;
}

-(void)chooseLevel:(UIButton *)button
{
//    NSLog(@"button:%d",button.tag);
    game.levelNumber = [NSNumber numberWithInteger:button.tag];
    
//    game.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
//    [self presentViewController:game animated:YES completion:Nil ];
//

    CATransition *transition = [CATransition animation];
    transition.duration = 0.5;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionMoveIn;
    transition.subtype = kCATransitionFromRight;
    transition.delegate = self;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    
    [self.navigationController pushViewController:game animated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addMessage:(int)level andName:(NSString *)levelName Dir:(NSURL *)dir
{
    NSString *levelString = [NSString stringWithFormat:@"%d",level];
//    NSString *path = [NSString alloc] initwithur
    [MessageBtn setBackgroundColor:[UIColor lightGrayColor]];
    NSDictionary *oneMessage =[ [NSDictionary alloc] initWithObjectsAndKeys:levelString,@"levelNumber",levelName,@"levelName",[dir absoluteString],@"DIR", nil];
   
    for (NSDictionary *oneElemt in messageArray) {
        if ([[oneElemt objectForKey:@"levelNumber"] isEqualToString:levelString]) {
            [messageArray removeObject:oneElemt];
            break;
        }
    }

    [messageArray addObject:oneMessage];
    
    sortedMessageArray =[NSArray arrayWithArray:[messageArray sortedArrayUsingComparator:^NSComparisonResult(NSDictionary *p1, NSDictionary *p2){
        
        return [[p1 objectForKey:@"levelNumber"] compare:[p2 objectForKey:@"levelNumber"] options:NSNumericSearch];
        
    }]];
    [messageArray removeAllObjects];
    [messageArray setArray:sortedMessageArray];

    
}

- (IBAction)settingTap:(id)sender {
    
    FeedbackViewController *vc = [[FeedbackViewController alloc] initWithNibName:@"FeedbackViewController" bundle:nil];
    vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (IBAction)messageTap:(id)sender {
    messageTableViewController *myNewMessage = [[messageTableViewController alloc] initWithNibName:@"messageTableViewController" bundle:nil];
//    [myNewMessage view];

    [self.navigationController pushViewController:myNewMessage animated:YES];
}

-(void)dealloc
{
    NSError *error;
    //eric:sound test...
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:&error];
    
    [[AVAudioSession sharedInstance] overrideOutputAudioPort:AVAudioSessionPortOverrideNone
                                                       error:&error];
    
    [[AVAudioSession sharedInstance] setActive: NO error: nil];
}
@end
