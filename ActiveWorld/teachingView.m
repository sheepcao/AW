//
//  teachingView.m
//  completeImage
//
//  Created by 张力 on 14-6-16.
//  Copyright (c) 2014年 张力. All rights reserved.
//

#import "teachingView.h"

@implementation teachingView


SystemSoundID soundCN;
SystemSoundID soundEN;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(id)initWithWordsAndSound:(NSString *)chinese english:(NSString *)eng soundCN:(NSString *)sndCN soundEN:(NSString *)sndEN between:(UIButton *)left and :(UIButton *)right
{
    self = [super init];

    if (self) {
        
        if ([[UIScreen mainScreen] bounds].size.height == 480) {
            
            self.frame = CGRectMake(80, 60, 160, 100);
            self.answerCN = [[UIButton alloc] initWithFrame:CGRectMake(20, 15, 110-50, 35)];
            self.answerEN = [[UIButton alloc] initWithFrame:CGRectMake(20, 50, 110-50, 35)];
            self.customRecorder = [[UIButton alloc] initWithFrame:CGRectMake(90, 15, 40, 35)];
            self.customPlay = [[UIButton alloc] initWithFrame:CGRectMake(90, 50, 40, 35)];
        }else
        {
//             self.wrongLabel = [[UIImageView alloc] initWithFrame:CGRectMake(self.priorButton.frame.origin.x + self.priorButton.frame.size.width+5, self.priorButton.frame.origin.y -10, self.nextButton.frame.origin.x - self.priorButton.frame.origin.x - self.priorButton.frame.size.width -10, 100)];
            self.frame = CGRectMake(left.frame.origin.x + left.frame.size.width+5, left.frame.origin.y -10, right.frame.origin.x - left.frame.origin.x - left.frame.size.width -10, 100);
            
            self.answerCN = [[UIButton alloc] initWithFrame:CGRectMake(15, 15, 140-70, 40)];
            self.answerEN = [[UIButton alloc] initWithFrame:CGRectMake(15, 55, 140-60, 40)];
            self.customRecorder = [[UIButton alloc] initWithFrame:CGRectMake(90, 15, 40, 40)];
            self.customPlay = [[UIButton alloc] initWithFrame:CGRectMake(90, 50, 40, 40)];
            
            [self.answerCN setCenter:CGPointMake(self.frame.size.width/4, self.frame.size.height/4 +5)];
            [self.answerEN setCenter:CGPointMake(self.frame.size.width/4, self.frame.size.height *3/4 -5)];
            [self.customRecorder setCenter:CGPointMake(self.frame.size.width *3/4, self.frame.size.height/4 +5)];
            [self.customPlay setCenter:CGPointMake(self.frame.size.width *3/4, self.frame.size.height *3/4 -5)];
            NSLog(@"answerCN:%@",self.answerCN);
            NSLog(@"center:%f,%f",self.center.x,self.center.y);

        }
        
        UIImageView *backImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [backImg setImage:[UIImage imageNamed:@"board" ]];
        [backImg setContentMode:UIViewContentModeScaleToFill];
        [self.answerCN setContentMode:UIViewContentModeScaleToFill];
        [self.answerEN setContentMode:UIViewContentModeScaleToFill];
        [self addSubview:backImg];
//        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"board" ]];
        

 /*//       self.answerCN .backgroundColor =[UIColor greenColor];
        [self.answerCN setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.answerEN setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
       
        UIImageView *amplifierCN = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"amplifier"] highlightedImage:[UIImage imageNamed:@"amplifier2"]];
        
        UIImageView *amplifierEN = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"amplifier"] highlightedImage:[UIImage imageNamed:@"amplifier2"]];
        amplifierCN.frame = CGRectMake(105, 9, 25, 25);
        amplifierEN.frame = CGRectMake(105, 9, 25, 25);

        [self.answerCN addSubview:amplifierCN];
        [self.answerEN addSubview:amplifierEN];
*/
        [self.answerCN setTitle:chinese forState:UIControlStateNormal];
        [self.answerEN setTitle:eng forState:UIControlStateNormal];
        [self.answerCN setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [self.answerEN setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        self.answerCN.titleLabel.font = [UIFont fontWithName:@"SegoePrint" size:16];
        self.answerEN.titleLabel.font = [UIFont fontWithName:@"SegoePrint" size:16];
        [self.answerCN.titleLabel setTextAlignment:NSTextAlignmentRight];
        [self.answerEN.titleLabel setTextAlignment:NSTextAlignmentRight];
        
        [self.customRecorder setTitle:@"Rec" forState:UIControlStateNormal];
        [self.customPlay setTitle:@"play" forState:UIControlStateNormal];

        [self.customRecorder setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [self.customPlay setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        
//        self.answerEN.layer.borderColor = [UIColor blackColor].CGColor;
//        self.answerEN.layer.borderWidth = 1.0f ;
        
        // [self bringSubviewToFront:self.answerCN];
 
//        [self.answerCN setImage:[UIImage imageNamed:chinese] forState:UIControlStateNormal];
//        [self.answerEN setImage:[UIImage imageNamed:eng] forState:UIControlStateNormal];

        
        [self addSubview:self.answerEN];
        [self addSubview:self.answerCN];
        [self addSubview:self.customPlay];
        [self addSubview:self.customRecorder];
        
        CFBundleRef CNbundle=CFBundleGetMainBundle();
        
        //获得声音文件URL
        CFURLRef soundfileurlCN=CFBundleCopyResourceURL(CNbundle,(__bridge CFStringRef)sndCN,CFSTR("wav"),NULL);
        //创建system sound 对象
        AudioServicesCreateSystemSoundID(soundfileurlCN, &soundCN);
        
      //  CFBundleRef ENbundle=CFBundleGetMainBundle();
        
        //获得声音文件URL
        CFURLRef soundfileurlEN=CFBundleCopyResourceURL(CNbundle,(__bridge CFStringRef)sndEN,CFSTR("wav"),NULL);
        //创建system sound 对象
        AudioServicesCreateSystemSoundID(soundfileurlEN, &soundEN);
        
        self.soundCNObj = [NSNumber numberWithInt:soundCN];
        self.soundENObj = [NSNumber numberWithInt:soundEN];
        
    
        
        
    }
    
    return self;

}


-(void)setWordsAndSound:(NSString *)chinese english:(NSString *)eng soundCN:(NSString *)sndCN soundEN:(NSString *)sndEN
{
    [self.answerCN setTitle:chinese forState:UIControlStateNormal];
    [self.answerEN setTitle:eng forState:UIControlStateNormal];
//
//    [self.answerCN setImage:[UIImage imageNamed:chinese] forState:UIControlStateNormal];
//    [self.answerEN setImage:[UIImage imageNamed:eng] forState:UIControlStateNormal];
    
    CFBundleRef CNbundle=CFBundleGetMainBundle();
    
    //获得声音文件URL
    CFURLRef soundfileurlCN=CFBundleCopyResourceURL(CNbundle,(__bridge CFStringRef)sndCN,CFSTR("wav"),NULL);
    //创建system sound 对象
    AudioServicesCreateSystemSoundID(soundfileurlCN, &soundCN);
    
//    CFBundleRef ENbundle=CFBundleGetMainBundle();
    
    //获得声音文件URL
    CFURLRef soundfileurlEN=CFBundleCopyResourceURL(CNbundle,(__bridge CFStringRef)sndEN,CFSTR("wav"),NULL);
    //创建system sound 对象
    AudioServicesCreateSystemSoundID(soundfileurlEN, &soundEN);
    
    self.soundCNObj = [NSNumber numberWithInt:soundCN];
    self.soundENObj = [NSNumber numberWithInt:soundEN];
}

@end
