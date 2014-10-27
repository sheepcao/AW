//
//  favoratesObj.m
//  ActiveWorld
//
//  Created by Eric Cao on 10/20/14.
//  Copyright (c) 2014 Eric Cao. All rights reserved.
//

#import "favoratesObj.h"

@implementation favoratesObj

@synthesize levelName;

- (id) init{
    self = [super init];
    if (self != nil) {
        levelNum = [NSString new];
        levelName = [NSString new];
    }
    
    return self;
}
@end
