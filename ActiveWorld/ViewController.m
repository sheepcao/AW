//
//  ViewController.m
//  ActiveWorld
//
//  Created by Eric Cao on 10/10/14.
//  Copyright (c) 2014 Eric Cao. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize SportMenu;
@synthesize CommunityMenu;
@synthesize OutdoorMenu;
@synthesize game;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    game = [[gameLevelController alloc] initWithNibName:@"gameLevelController" bundle:nil];
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
    NSLog(@"button:%ld",button.tag);
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

@end
