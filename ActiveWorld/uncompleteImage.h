//
//  uncompleteImage.h
//  completeImage
//
//  Created by 张力 on 14-6-4.
//  Copyright (c) 2014年 张力. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface uncompleteImage : NSObject


//@property (nonatomic , strong) UIImageView *uncompleteIMG;
//@property (nonatomic , strong) UIButton *emptyIMG;

@property  NSInteger positionX;
@property  NSInteger positionY;
//@property  NSInteger correct;



-(id)initWithEmptyX:(NSInteger)pos_x Y:(NSInteger)pos_y;
-(void)setEmptyX:(NSInteger)pos_x Y:(NSInteger)pos_y ;

@end
