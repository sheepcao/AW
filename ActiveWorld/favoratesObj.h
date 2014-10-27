//
//  favoratesObj.h
//  ActiveWorld
//
//  Created by Eric Cao on 10/20/14.
//  Copyright (c) 2014 Eric Cao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface favoratesObj : NSObject
{
    NSString *levelNum;
    NSString *levelName;
}

@property (nonatomic ,strong) NSString *levelName;
@property (nonatomic ,strong) NSString *levelNum;

@end
