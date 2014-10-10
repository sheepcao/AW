//
//  uncompleteImage.m
//  completeImage
//
//  Created by 张力 on 14-6-4.
//  Copyright (c) 2014年 张力. All rights reserved.
//

#import "uncompleteImage.h"

@implementation uncompleteImage


const int EMPTY_AREA_EDGE = 55;

-(id)initWithEmptyX:(NSInteger)pos_x Y:(NSInteger)pos_y
{
    self = [super init];
    if (self) {
        // Initialization code
        if ([[UIScreen mainScreen] bounds].size.height == 480) {
            pos_y -=31;
            
        }else
        {
            pos_y +=1;
        }
        self.positionX = pos_x ;
        self.positionY = pos_y;
        //self.correct = correct_num;
        //[self.uncompleteIMG setImage:[UIImage imageNamed:fullImage]];
      //  self.emptyIMG = [[UIButton alloc] initWithFrame:CGRectMake(positionX, positionY, EMPTY_AREA_EDGE, EMPTY_AREA_EDGE)];
    

    }
    return self;


}
-(void)setEmptyX:(NSInteger)pos_x Y:(NSInteger)pos_y
{
    if (self) {
        if ([[UIScreen mainScreen] bounds].size.height == 480) {
            pos_y -=31;
            
        }else
        {
            pos_y +=1;
        }
        self.positionX = pos_x;
        self.positionY = pos_y;
        //self.correct = correct_num;
    }
   
}

@end
