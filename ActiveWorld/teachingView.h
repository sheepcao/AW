//
//  teachingView.h
//  completeImage
//
//  Created by 张力 on 14-6-16.
//  Copyright (c) 2014年 张力. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>


@interface teachingView : UIView

@property (nonatomic,strong) UIButton *answerCN;
@property (nonatomic,strong) UIButton *answerEN;
@property (nonatomic,strong) NSNumber *soundCNObj;
@property (nonatomic,strong) NSNumber *soundENObj;
@property (nonatomic,strong) NSString *soundEnName;
@property (nonatomic,strong) NSString *soundCnName;


-(id)initWithWordsAndSound:(NSString *)chinese english:(NSString *)eng soundCN:(NSString *)sndCN soundEN:(NSString *)sndEN;

-(void)setWordsAndSound:(NSString *)chinese english:(NSString *)eng soundCN:(NSString *)sndCN soundEN:(NSString *)sndEN;


@end
