//
//  FeedbackViewController.h
//  ActiveMobile
//
//  Created by Kari Ohlsen on 10/16/12.
//  Copyright (c) 2012 The Active Network. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "AFHTTPClient.h"
#import "favoritesTableViewController.h"



#define APPLIST_API_URL 					@"http://int-mobileui-01w.aw.dev.activenetwork.com:8550/misc?action=getActiveiTunesAppData"

@interface FeedbackViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,MFMailComposeViewControllerDelegate>
{
	NSMutableArray *ourApps;
	NSInteger rowClicked;
	IBOutlet UITableView *appTableView;
}
@property(nonatomic,retain) UITableView *appTableView;
@property (nonatomic, strong) AFHTTPClient *httpClient;

@end
