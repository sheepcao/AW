//
//  ArticleCell.m
//  ActiveReader
//
//  Created by Peter de Tagyos on 7/15/10.
//  Copyright 2010 The Active Network. All rights reserved.
//

#import "ActiveDotComAppCell.h"


@implementation ActiveDotComAppCell

@synthesize title, summary, image;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
        // Initialization code
    }
    return self;
}

- (void)dealloc {
	
}


@end
