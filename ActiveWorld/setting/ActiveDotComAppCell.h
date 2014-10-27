//
//  ArticleCell.h
//  ActiveReader
//
//  Created by Peter de Tagyos on 7/15/10.
//  Copyright 2010 The Active Network. All rights reserved.
//

#import <UIKit/UIKit.h>


@class ActiveDotComAppCell;



@interface ActiveDotComAppCell : UITableViewCell {
	UILabel *title;
	UILabel *summary;
	UIImageView *image;
	
}

@property (nonatomic, retain) IBOutlet UILabel *title;
@property (nonatomic, retain) IBOutlet UILabel *summary;
@property (nonatomic, retain) IBOutlet UIImageView *image;
@end
