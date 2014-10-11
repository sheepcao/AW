//
//  gameLevelController.m
//  completeImage
//
//  Created by 张力 on 14-6-22.
//  Copyright (c) 2014年 张力. All rights reserved.
//

#import "gameLevelController.h"

//ad...big
#import "AppDelegate.h"

@interface gameLevelController ()

@end

@implementation gameLevelController


@synthesize backIMG;


@synthesize animationBegin;
@synthesize picture;
@synthesize answer1;
@synthesize answer2;
@synthesize answer3;
@synthesize nextButton;
@synthesize priorButton;
@synthesize choices;
@synthesize empty;
@synthesize levelCount;
@synthesize teachView;
@synthesize wrongLabel;
@synthesize myImg;
@synthesize emptyGif;
@synthesize webView;
@synthesize questionMark;
@synthesize backButton;

@synthesize levelNumber;



double posX[MAXlevel] = {216.6,113.1,107.4,118.5,90.6,/*5*/141.4};
double posY[MAXlevel] = {277.1,284.3,282.5,195.1,340.1,/*5*/274.7};
double animationSpeed[MAXlevel] = {0.35,0.31,0.27,0.34,0.33,/*5*/0.24};
double repeatTime[MAXlevel] = {3,1,3,1,1,/*5*/2};
bool haveFixed[MAXlevel] = {NO};
bool notJumpOver = NO;



NSArray *wordsCN;
NSArray *wordsEN;
NSArray *backgroundName;

NSMutableArray  *arrayM;
NSMutableArray  *arrayGif;




- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)viewDidAppear:(BOOL)animated

{
    level = [self.levelNumber intValue];


    
    
    
    
    
    if ([CommonUtility isSystemLangChinese]) {
        
        [self.backButton setImage:[UIImage imageNamed:@"returnToLevel"] forState:UIControlStateNormal];
        [self.backButton setImage:[UIImage imageNamed:@"returnTapped"] forState:UIControlStateHighlighted];
    }else
    {
        [self.backButton setImage:[UIImage imageNamed:@"returnToLevelEN"] forState:UIControlStateNormal];
        [self.backButton setImage:[UIImage imageNamed:@"returnTappedEN"] forState:UIControlStateHighlighted];
    }
    
    
    
    self.isFormRewordFlag = NO;
    
    
    for (int i=0; i<levelTop-1; i++) {
        haveFixed[i]= YES;
    }

    
    picture = [[UIImageView alloc] initWithFrame:CGRectMake(self.priorButton.center.x, 190,self.nextButton.center.x - self.priorButton.center.x ,(self.nextButton.center.x - self.priorButton.center.x) * 230/250)];
    
    answer2 = [[UIButton alloc] initWithFrame:CGRectMake(picture.center.x-27.5, picture.frame.origin.y + picture.frame.size.height + 30, 55, 55)];
    answer2.tag = 2;
    
    answer1 = [[UIButton alloc] initWithFrame:CGRectMake(picture.frame.origin.x, answer2.frame.origin.y, 55, 55)];
    answer1.tag = 1;

    answer3 = [[UIButton alloc] initWithFrame:CGRectMake(picture.frame.origin.x + picture.frame.size.width - 55, answer2.frame.origin.y, 55, 55)];
    answer3.tag = 3;
    
    [answer1 setBackgroundImage:[UIImage imageNamed:@"choiceBackground"] forState:UIControlStateNormal];
    [answer2 setBackgroundImage:[UIImage imageNamed:@"choiceBackground"] forState:UIControlStateNormal];
    [answer3 setBackgroundImage:[UIImage imageNamed:@"choiceBackground"] forState:UIControlStateNormal];
    [answer1 addTarget:self action:@selector(buttonTap:) forControlEvents:UIControlEventTouchUpInside];
    [answer2 addTarget:self action:@selector(buttonTap:) forControlEvents:UIControlEventTouchUpInside];
    [answer3 addTarget:self action:@selector(buttonTap:) forControlEvents:UIControlEventTouchUpInside];
    
    
    if ([[UIScreen mainScreen] bounds].size.height == 480) {
        
        [self.picture setFrame: CGRectMake(33, 157, 250, 230)];
        
        self.animationBegin = [[UIButton alloc] initWithFrame:CGRectMake(33, 157, 250, 230)];
        
        [self.answer1 setFrame:CGRectMake(33, 400, 55, 55)];
        [self.answer2 setFrame:CGRectMake(131, 400, 55, 55)];
        [self.answer3 setFrame:CGRectMake(228, 400, 55, 55)];
        
    }else
    {
//        picture = [[UIImageView alloc] initWithFrame:CGRectMake(self.priorButton.center.x, 190,self.nextButton.center.x - self.priorButton.center.x ,(self.nextButton.center.x - self.priorButton.center.x) * 230/250)];
//        picture.layer.borderWidth = 1.0f;
//        picture.layer.borderColor = [UIColor redColor].CGColor;
        self.animationBegin = [[UIButton alloc] initWithFrame:CGRectMake(33, 190, 250, 230)];
        posY[level-1] +=1;
    }
    [self.view addSubview:self.answer1];
    [self.view addSubview:self.answer2];
    [self.view addSubview:self.answer3];
    self.animationBegin.backgroundColor = [UIColor clearColor];
    //    self.picture.layer.borderWidth = 0;
    [self.view addSubview:self.picture];
    [self.view addSubview:self.animationBegin];
    [self.view bringSubviewToFront:self.animationBegin];
    [self.animationBegin addTarget:self action:@selector(animationTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    self.choices = [[NSMutableArray alloc] initWithObjects:self.answer1,self.answer2,self.answer3, nil];
    NSString *words1 = @"猪,猫,兔子,鸡,青蛙,蜜蜂,狗,鲨鱼,蜗牛,考拉,羽毛球,足球,乒乓球,高尔夫,保龄球,射箭,滑雪,篮球,帆船,举重,牛奶,土豆,月饼,栗子,米饭,披萨饼,西瓜,花生,橙子,黄瓜,眼镜,牙刷,钢笔,红绿灯,奶嘴,卫生间,钟表,蜡烛,放大镜,洗衣液,向日葵,柳树,玫瑰,荷花,竹子,松树,仙人掌,银杏树,菊花,牵牛花";
    wordsCN = [words1 componentsSeparatedByString:@","];
    NSString *words2 = @"pig,cat,rabbit,chicken,frog,bee,dog,shark,snail,koala,badminton,football,table tennis,golf,bowling,archery,skiing,basketball,sailing,weighting,milk,potato,mooncake,chestnut,rice,pizza,watermelon,peanut,orange,cucumber,glasses,toothbrush,pen,traffic light,pacifier,toilet,clock,candle,magnifier,landry,sunflower,willow,rose,lotus,bamboo,pine,cactus,gingko,chrysanthemum,morning glory";
    wordsEN = [words2 componentsSeparatedByString:@","];
    
    NSString *backgroundNames = @"animalBackground";
    backgroundName = [backgroundNames componentsSeparatedByString:@","];
    
    self.empty = [[UIButton alloc] init];
    [self.empty setBackgroundColor:[UIColor clearColor]];
    self.empty.layer.borderWidth = 0;
    
    //share change task.    [self.shareBtn setHidden:YES];
    
    self.questionMark = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 55, 55)];
    self.questionMark.layer.borderWidth = 0;
    self.questionMark.alpha = 0.8;
    [self.empty addSubview:self.questionMark];
    
    arrayGif=[[NSMutableArray array] init];
    UIImage *gif = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"QuestionMark" ofType:@"png"]];
    [arrayGif addObject:gif];
    
    [arrayGif addObject:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"透明" ofType:@"png"]]];
    
    [arrayGif addObject:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"QuestionMarkBlue" ofType:@"png"]]];
    
    [arrayGif addObject:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"透明" ofType:@"png"]]];
    
    
    
    [self.view sendSubviewToBack:backIMG];
    [backIMG setImage:[UIImage imageNamed:@"animalBackground"]];
    
    
    
    if (self.isFormRewordFlag == YES) {
        self.isFormRewordFlag = NO;
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
    [self.animationBegin setHidden:YES];
    
    for (int i =0; i<3; i++) {
        [self setButton:(UIButton *)self.choices[i]];
    }
    
    
    self.myImg = [[uncompleteImage alloc] initWithEmptyX:posX[level-1] Y:posY[level-1]];
    
    [self setupWithEmptyPosition:self.myImg.positionX :self.myImg.positionY];
    
    
    self.teachView = [[teachingView alloc] initWithWordsAndSound:wordsCN[level-1] english:wordsEN[level-1] soundCN:wordsCN[level-1] soundEN:wordsEN[level-1] between:priorButton and:nextButton];
    
    if (!haveFixed[level-1]) {
        
        [self.nextButton setEnabled:NO];
        
    }else
    {
        [self.nextButton setEnabled:YES];
        
    }
    if (arrayGif.count>0) {
        //设置动画数组
        [self.questionMark setAnimationImages:arrayGif];
        //设置动画播放次数
        [self.questionMark setAnimationRepeatCount:0];
        //设置动画播放时间
        [self.questionMark setAnimationDuration:2*1.0];
        //开始动画
        [self.questionMark startAnimating];
        
        
    }


}



-(void)setupWithEmptyPosition:(NSInteger )px :(NSInteger )py
{
    
    [self.levelCount setText:[NSString stringWithFormat:@"%d",level]];
    self.levelCount.font = [UIFont fontWithName:@"SegoePrint" size:23];
    [self.levelCount setTextColor:[UIColor blackColor]];
    
    if (self.wrongLabel.superview) {
        [self.wrongLabel removeFromSuperview];

    }

    
    
    NSString *pic = [NSString stringWithFormat:@"pic%d",level];
    
    NSString *an1 = [NSString stringWithFormat:@"an1-%d",level];
    
    NSString *an2 = [NSString stringWithFormat:@"an2-%d",level];
    
    NSString *an3 = [NSString stringWithFormat:@"an3-%d",level];
    
    
    
    [self setImages:an1:an2 :an3 :pic];
   
    [self.empty setFrame:CGRectMake(px, py, 55, 55)];
        
    [self.questionMark setFrame:CGRectMake(0, 0, 55, 55)];

    [self setButton:self.empty];
    self.empty.layer.borderWidth = 0;
    
    self.empty.tag = 0;
    
    for (int i =0; i<3; i++) {
        [((UIButton *)self.choices[i]) setHidden:NO];
    }
    [self.view addSubview:self.empty];
    
    [self.teachView removeFromSuperview];
    [self.empty removeTarget:self action:@selector(buttonTap:) forControlEvents:UIControlEventTouchUpInside];
    
    
//
//    if (!haveFixed[level-1]) {
//        
//        [self.nextButton setEnabled:NO];
//        
//    }else
//    {
        [self.nextButton setEnabled:YES];
  
        
//    }
    
    //每个主题的第一关不允许点击上一关
    if (level == 1) {
        [self.priorButton setEnabled:NO];
    }else
    {
        [self.priorButton setEnabled:YES];

    }
    
    [self.animationBegin setHidden:YES];//每关开始不可点击。

 
}

-(void)setImages:(NSString *)rightAns :(NSString *)wrong1 :(NSString *)wrong2 :(NSString *)guess
{
    unsigned int randomNumber = arc4random();
    
    int correctAns = randomNumber%MAXanswer;
    UIButton *rightBtn = self.choices[correctAns];
    
    [rightBtn setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:rightAns ofType:@"png"]] forState:UIControlStateNormal];
    correct[level-1] = correctAns+1;
    
    [self.choices[(correctAns+1)%3] setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@", wrong1] ofType:@"png"]]forState:UIControlStateNormal];
    [self.choices[(correctAns+2)%3] setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@", wrong2] ofType:@"png"]]forState:UIControlStateNormal];
    
    [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@", wrong1] ofType:@"png"]];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@", guess] ofType:@"png"];
    UIImage *myImage = [UIImage imageWithContentsOfFile:path];
    [self.picture setImage:myImage];

    [self.empty setImage:nil forState:UIControlStateNormal];
    [self.questionMark setHidden:NO];
    
    
    
    
    
    
}

-(void)setButton:(UIButton *)btn
{
    btn.layer.borderWidth = 1.0f;
    btn.layer.borderColor = [UIColor blackColor].CGColor;
    btn.backgroundColor = [UIColor clearColor];
    [btn addTarget:self action:@selector(buttonTap:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)buttonTap:(UIButton *)sender
{

//    [CommonUtility tapSound:@"choiceSound" withType:@"mp3"];
    
    if (sender.tag == 0) {
        if (self.empty.imageView.image) {
            [self.empty setImage:nil forState:UIControlStateNormal];
            [self.questionMark setHidden:NO];
            
            for (int i = 0; i<3; i++) {
                if ([((UIButton *) self.choices[i]) isHidden]) {
                    [((UIButton *) self.choices[i]) setHidden:NO];
                }
            }
            [self.wrongLabel removeFromSuperview];
            
        }
        [self.empty removeTarget:self action:@selector(buttonTap:) forControlEvents:UIControlEventTouchUpInside];
        
        
    }else
    {
        
        for (int i=0; i<3; i++) {
            if ([((UIButton *)self.choices[i]) isHidden]) {
                return;
            }
        }
        
        [((UIButton *) self.choices[sender.tag-1]) setHidden:YES];
        [self.questionMark setHidden:YES];

        [self.empty setImage:((UIButton *) self.choices[sender.tag-1]).imageView.image forState:UIControlStateNormal];
        self.empty.layer.borderWidth = 0;
        
        
        if (sender.tag == correct[level-1] ) {
            
            
            
//            [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(correctAnswer) userInfo:nil repeats:NO];
            [self correctAnswer];
            
        }
        else
        {
//            
//            [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(wrongAnswer) userInfo:nil repeats:NO];
            [self wrongAnswer];
            
            
        }
        
    }
    
    
    
}

-(void)animationOver
{
    [self.animationBegin setHidden:NO];

    [self.empty setHidden:NO];
    if (!haveFixed[level-1]) {
        levelTop++;

        haveFixed[level-1] = YES;

    }
    //每个主题的第一关不允许点击上一关
    if (level%10 == 1) {
        [self.priorButton setEnabled:NO];
        [self.nextButton setEnabled:YES];
        
    }else{
        [self.nextButton setEnabled:YES];
        [self.priorButton setEnabled:YES];
    }
    NSLog(@"%d",haveFixed[level-1]);
    NSLog(@"%d",levelTop);
    
    [self.empty addTarget:self action:@selector(buttonTap:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)sayEnglish
{
//    AudioServicesPlaySystemSound([self.teachView.soundENObj intValue]);
//    [CommonUtility tapSound:wordsEN[level-1] withType:@"wav"];
    
}

-(void)correctAnswer{
    
    
    notJumpOver = YES;
    [self.nextButton setEnabled:NO];
    [self.priorButton setEnabled:NO];

    
    /* fit for 4-inch screen */
//    if ([[UIScreen mainScreen] bounds].size.height == 480) {
//        self.teachView.frame = CGRectMake(80, 60, 160, 100);
//        
//    }else
//    {
//        self.teachView.frame = CGRectMake(80, 70, 160, 120);
//
//    }
    
    [self.teachView.answerCN addTarget:self action:@selector(chineseTap) forControlEvents:UIControlEventTouchUpInside];
    [self.teachView.answerEN addTarget:self action:@selector(englishTap) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.teachView];
    
//    AudioServicesPlaySystemSound([self.teachView.soundCNObj intValue]);

//    [CommonUtility tapSound:wordsCN[level-1] withType:@"wav"];

    [NSTimer scheduledTimerWithTimeInterval:1.6 target:self selector:@selector(sayEnglish) userInfo:nil repeats:NO];
    
    [self.empty setHidden:YES];

    arrayM=[[NSMutableArray array] init];
    for (int i=1; i<15; i++) {

        UIImage *gif = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"level%d-%d",level,i] ofType:@"png"]];
        if (gif) {
            [arrayM insertObject:gif atIndex:i-1];
            
        }
        else if(i == 1)
        {
            [arrayM removeAllObjects];
            break;
        }
        else
        {
            for (int j=i-1; j<arrayM.count; j++) {
                [arrayM removeObjectAtIndex:j];
            }
            
//            if (arrayM.count>i-1) {
//                [arrayM removeObjectAtIndex:i-1];//make every level's animation with different image count.
//
//            }
        }
    }
    
    if (arrayM.count>0) {
        //设置动画数组
        [self.picture setAnimationImages:arrayM];
        //设置动画播放次数
        [self.picture setAnimationRepeatCount:repeatTime[level-1]];
        //设置动画播放时间
        [self.picture setAnimationDuration:arrayM.count*animationSpeed[level-1]];
        //开始动画
        [self.picture startAnimating];
        
        
    }
    
    double timeInterval =(1.5*self.picture.animationDuration > 3.5)?(1.5*self.picture.animationDuration):3.5;
   
    [self performSelector:@selector(animationOver) withObject:nil afterDelay:timeInterval];
    
    
    
    
}


-(void)choiceBack
{
    //correct记录的是选项tag，1～3而非0～2.
    for (int i = 0; i<3; i++) {
        if ( [((UIButton *) self.choices[i]) isHidden ] && ((i+1) == correct[level-1]) ) {
            return;
        }else if( [((UIButton *) self.choices[i]) isHidden ])
            [((UIButton *) self.choices[i]) setHidden:NO];

    }
    
    if (self.empty.imageView.image) {
        [self.empty setImage:nil forState:UIControlStateNormal];
        [self.questionMark setHidden:NO];
/*
        for (int i = 0; i<3; i++) {
            if ( [((UIButton *) self.choices[i]) isHidden ] ) {
                [((UIButton *) self.choices[i]) setHidden:NO];

            }
        }
 */       
        [self.wrongLabel removeFromSuperview];
        
        [self.empty removeTarget:self action:@selector(buttonTap:) forControlEvents:UIControlEventTouchUpInside];

    }
    
    
}

-(void)wrongAnswer{
    
    
//    [CommonUtility tapSound:@"衰" withType:@"wav"];

    
    int scoreTemp = [[scores objectAtIndex:((level-1)/10)] intValue];
    
    [scores setObject:[NSNumber numberWithInt:(scoreTemp +1)] atIndexedSubscript:((level-1)/10)];
    
    
    if([self.teachView superview])
    {
        [self.teachView removeFromSuperview];
    }
    
    
    if ([[UIScreen mainScreen] bounds].size.height == 480) {
        
        self.wrongLabel = [[UIImageView alloc] initWithFrame:CGRectMake(80, 60, 160, 100)];


    }else
    {
//        self.wrongLabel = [[UIImageView alloc] initWithFrame:CGRectMake(80, 70, 160, 120)];
        
        self.wrongLabel = [[UIImageView alloc] initWithFrame:CGRectMake(self.priorButton.frame.origin.x + self.priorButton.frame.size.width+5, self.priorButton.frame.origin.y -10, self.nextButton.frame.origin.x - self.priorButton.frame.origin.x - self.priorButton.frame.size.width -10, 100)];
    }

    [self.wrongLabel setImage:[UIImage imageNamed:@"board" ]];
    [self.wrongLabel setContentMode:UIViewContentModeScaleToFill];

    UIImageView *cryFace = [[UIImageView alloc] initWithFrame:CGRectMake(self.wrongLabel.frame.size.width/2 - 32, 15, 65, 65)];
    cryFace.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"wrongImg" ofType:@"png"]];
    [self.wrongLabel addSubview:cryFace];
    [self.view addSubview:self.wrongLabel];
    
    //5秒后按钮自动退回
    [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(choiceBack) userInfo:nil repeats:NO];
    [self.empty addTarget:self action:@selector(buttonTap:) forControlEvents:UIControlEventTouchUpInside];
   //cancel the border..
    //self.empty.layer.borderWidth = 1.0f;
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma alert delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 1) {
        if (level<MAXlevel) {
            level++;
        }
        [self.myImg setEmptyX:posX[level-1] Y:posY[level-1]];
        [self setupWithEmptyPosition:self.myImg.positionX :self.myImg.positionY];
        [self.teachView setWordsAndSound:wordsCN[level-1] english:wordsEN[level-1] soundCN:wordsCN[level-1] soundEN:wordsEN[level-1]];
        
    }
}


- (IBAction)priorLevel {

    
//    [CommonUtility tapSound:@"levelSound" withType:@"mp3"];

    
//    [MobClick event:@"2"];
    
    if (level>1) {
        level--;
        
        [self.myImg setEmptyX:posX[level-1] Y:posY[level-1]];
        [self setupWithEmptyPosition:self.myImg.positionX :self.myImg.positionY];
        [self.teachView setWordsAndSound:wordsCN[level-1] english:wordsEN[level-1] soundCN:wordsCN[level-1] soundEN:wordsEN[level-1]];
        
        
    }else if(level ==1)
    {
        return;
    }
}



- (IBAction)nextLevel {

    
//    [CommonUtility tapSound:@"levelSound" withType:@"mp3"];
    
//    [MobClick event:@"1"];
    
    [arrayM removeAllObjects];
    if (!notJumpOver) {
        int scoreTemp = [[scores objectAtIndex:((level-1)/10)] intValue];
        
        [scores setObject:[NSNumber numberWithInt:(scoreTemp +2)] atIndexedSubscript:((level-1)/10)];
    }
    
    
   
        [self changeImgs];
        
    
    
}
-(void)changeImgs
{
    
    if (haveFixed[level-1]) {
        
        if (level<MAXlevel) {
            level++;
            notJumpOver = NO;

            [self.myImg setEmptyX:posX[level-1] Y:posY[level-1]];
            [self setupWithEmptyPosition:self.myImg.positionX :self.myImg.positionY];
            [self.teachView setWordsAndSound:wordsCN[level-1] english:wordsEN[level-1] soundCN:wordsCN[level-1] soundEN:wordsEN[level-1]];
            
        }else if(level == MAXlevel )
        {
            
            return;
            
        }
    }

}



- (IBAction)backToLevel {
    
//    [CommonUtility tapSound:@"backAndCancel" withType:@"mp3"];

//    [self dismissViewControllerAnimated:YES completion:Nil];
    [self.navigationController popViewControllerAnimated:YES];
    
}

//- (IBAction)share {
//    
//    [CommonUtility tapSound];
//
//    
////    sharePhotoViewController *myShare = [[sharePhotoViewController alloc] initWithNibName:@"sharePhotoViewController" bundle:nil];
////    myShare.frontImageName = sharePic[(level-1)/10];
////    myShare.afterShutter = NO;
////    myShare.backImage.image = nil;
////    
////    myShare.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
////    [self presentViewController:myShare animated:YES completion:Nil ];
//
//}

- (IBAction)animationTapped:(id)sender {
    
//    [CommonUtility tapSound];

    [self.nextButton setEnabled:NO];
    [self.priorButton setEnabled:NO];
    [self.empty setHidden:YES];

    
    if (arrayM.count>0) {
              //开始动画
        [self.picture startAnimating];
    }
    
    [self performSelector:@selector(animationOnly) withObject:nil afterDelay:self.picture.animationDuration * repeatTime[level-1]];

}
-(void)animationOnly
{
    if (level%10 == 1) {
        [self.priorButton setEnabled:NO];
        [self.nextButton setEnabled:YES];
        
    }else{
        [self.nextButton setEnabled:YES];
        [self.priorButton setEnabled:YES];
    }
    [self.empty setHidden:NO];
}

-(void)chineseTap

{
//    [MobClick event:@"5"];
//    AudioServicesPlaySystemSound([self.teachView.soundCNObj intValue]);

//    [CommonUtility tapSound:wordsCN[level-1] withType:@"wav"];

}

-(void)englishTap
{
//      [MobClick event:@"6"];
//    AudioServicesPlaySystemSound([self.teachView.soundENObj intValue]);
//    [CommonUtility tapSound:wordsEN[level-1] withType:@"wav"];

}
-(void)emptyDisappear
{
    [self.empty setHidden:YES];
    [self.questionMark setHidden:YES];
}
-(void)emptyAppear
{
    [self.empty setHidden:NO];
    [self.questionMark setHidden:NO];
}


#pragma backToLevelDelegate

//-(BOOL) isFromReward :(BOOL)check
//{
//    self.isFormRewordFlag = YES;
//    return check;
//}



//-(void)willStopTimer
//{
//    [self.stopDelegate stopTimer];
//}


//ad...big
//#pragma bigAD delegate method
//- (void)interstitial:(GADInterstitial *)interstitial
//didFailToReceiveAdWithError:(GADRequestError *)error {
//    // Alert the error.
//    
//    NSLog(@"big ad error:%@",[error description]);
//}
//
//- (void)interstitialDidReceiveAd:(GADInterstitial *)interstitial {
//    [interstitial presentFromRootViewController:self];
//
//}
//- (void)interstitialDidDismissScreen:(GADInterstitial *)interstitial
//{
//    [ADTimer invalidate];
//    ADTimer =nil;
//    ADTimer = [NSTimer scheduledTimerWithTimeInterval:20.0 target:self selector:@selector(bigAd) userInfo:nil repeats:NO];
//    
//    
//}
@end
