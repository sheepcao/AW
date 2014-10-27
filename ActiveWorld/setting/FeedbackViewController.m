//
//  FeedbackViewController.m
//  ActiveMobile
//
//  Created by Kari Ohlsen on 10/16/12.
//  Copyright (c) 2012 The Active Network. All rights reserved.
//


#import "FeedbackViewController.h"
#import <MessageUI/MessageUI.h>

#import "ActiveDotComAppCell.h"
#import <QuartzCore/QuartzCore.h>
#import "AboutViewController.h"
#import "UIDevice-Hardware.h"
#import "JSON.h"
//#import "Constants.h"
#import "AppDelegate.h"

#ifdef _SYSTEMCONFIGURATION_H
#define AAA @"aaa"
#else 
#define AAA @"bbb"
#endif

@interface FeedbackViewController ()
@property(nonatomic, retain) NSMutableArray *ourApps;
@end

@implementation FeedbackViewController
@synthesize ourApps, appTableView,httpClient;




- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		return self;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    NSLog(@"AAA:%@",AAA);
    
//	self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back"
//																			   style:UIBarButtonItemStylePlain
//																			  target:self
//																			  action:@selector(closeModalView)];
//    
//   [ self.navigationItem.backBarButtonItem setTintColor :[UIColor redColor] ];
//	AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
//    if (app.isIOS7Plus) {
//		[self.navigationItem.rightBarButtonItem setTintColor:[UIColor whiteColor]];
//	}
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
	
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_top_logo"] forBarMetrics:UIBarMetricsDefault];
	[self.navigationController.navigationBar setTranslucent:NO];
    if (self.ourApps == nil) {
        httpClient = [AFHTTPClient clientWithBaseURL:[NSURL URLWithString:@"http://www.active.com"]];
    [httpClient setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            
            NSLog(@"Internet status changed");
            NSLog(@"%d", status);
        }];
		if  ([httpClient networkReachabilityStatus] == AFNetworkReachabilityStatusNotReachable) {
			[self.appTableView reloadData];
		} else {
			[self fetchAppList];
		}
        
    } else {
        [self.appTableView reloadData];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	if (section==0) {
		return 2;
	} else if (section==1) {
		return [ourApps count];
	} else {
		return 1;
	}
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.section==1) {
		return 110;
	} else {
		return 40;
	}
	
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    static NSString *AppCellIdentifier = @"AppCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    ActiveDotComAppCell *appCell = (ActiveDotComAppCell *)[tableView dequeueReusableCellWithIdentifier:AppCellIdentifier];
    
    // Configure the cell...
	if (indexPath.section==0) {
		if (cell == nil) {
			cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
		}
		if (indexPath.row==1) {
			cell.textLabel.text=@"Having trouble? Let us know.";
		} else if (indexPath.row==0) {
			cell.textLabel.text=@"\u2605  Favorites  \u2605  ";
		}
		
		cell.textLabel.adjustsFontSizeToFitWidth=YES;
		UIImageView *arrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow.png"]];
		arrow.frame = CGRectMake(tableView.frame.size.width * 292/320,13,10,14);

		[cell addSubview:arrow];
		
		//cell.textLabel.font = [UIFont systemFontOfSize:14];
	} else if (indexPath.section==1){
		
		if (appCell == nil) {
			NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"ActiveDotComAppCell" owner:nil options:nil];
			for (id currentObject in topLevelObjects) {
				if ([currentObject isKindOfClass:[UITableViewCell class]]) {
					appCell = (ActiveDotComAppCell *)currentObject;
					break;
				}
			}
		}
		
		appCell.title.text = [[self.ourApps objectAtIndex:indexPath.row] objectForKey:@"appName"];
		appCell.summary.text = [[self.ourApps objectAtIndex:indexPath.row] objectForKey:@"appShortDesc"];
		appCell.image.image = [[self.ourApps objectAtIndex:indexPath.row] objectForKey:@"appImage"];
		appCell.image.hidden = NO;
		appCell.image.layer.cornerRadius = 10.0;
		appCell.image.layer.masksToBounds = YES;
		cell=appCell;
	} else if (indexPath.section==2){
		if (cell == nil) {
			cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
		}
		cell.textLabel.text =@"About Active Network";
	} else if (indexPath.section==3){
		if (cell == nil) {
			cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
		}
		cell.textLabel.text =@"Terms & Conditions";
	}
   // cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.section==0) {
		if (indexPath.row==1) {
			 // Not all devices are capable or setup to send email.
			 if (![MFMailComposeViewController canSendMail]) {
			 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mail not set up"
			 message:@"Sorry - you cannot send mail because you have not yet configured an email account in the Mail app. Please do that and then try again."
			 delegate:self
			 cancelButtonTitle:@"OK"
			 otherButtonTitles:nil];
			 [alert show];
			 return;
			 }
			 
			 NSMutableString *bodyStr = [NSMutableString string];
			 
			 UIDevice *device = [UIDevice currentDevice];
			 
			 NSString *appVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
			 [bodyStr appendFormat:@"\n\n\n\n\nApp Ver: %@\n", appVersion];
			 [bodyStr appendFormat:@"Platform: %@\n", [device platform]];
			 [bodyStr appendFormat:@"Platform String: %@\n", [device platformString]];
			 [bodyStr appendFormat:@"iOS version: %@\n", [device systemVersion]];
			 
			 MFMailComposeViewController *mailVC = [MFMailComposeViewController new];
			 [mailVC setSubject:@"ACTIVE App Feedback"];
			 [mailVC setToRecipients:[NSArray arrayWithObject:@"mobilesupport@activenetwork.com"]];
			 [mailVC setMessageBody:bodyStr isHTML:NO];
			 [mailVC setMailComposeDelegate:self];
			 [mailVC.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_top.png"] forBarMetrics:UIBarMetricsDefault];
			 
			 [self presentViewController:mailVC animated:YES completion:nil];
		
		} else if (indexPath.row==0) {
			
			[self.appTableView deselectRowAtIndexPath:[self.appTableView indexPathForSelectedRow] animated:YES];
            favoritesTableViewController *myFavorTable = [[favoritesTableViewController alloc] initWithNibName:@"favoritesTableViewController" bundle:nil];
            [self.navigationController pushViewController:myFavorTable animated:YES];
            
			
        }
	} else if (indexPath.section==1) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Leaving Active World app" message:@"You are now leaving the Active World app, and opening the iTunes app." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
		alert.tag=1;
		[alert show];
		
		rowClicked = indexPath.row;
		
	} else if  (indexPath.section==3){
		AboutViewController *vc = [[AboutViewController alloc] initWithNibName:@"AboutViewController" bundle:nil];
		[self.navigationController pushViewController:vc animated:YES];
		
	} else {
		AboutViewController *vc = [[AboutViewController alloc] initWithNibName:@"AboutViewController" bundle:nil];
		vc.displayTermsAndConditions=YES;
		[self.navigationController pushViewController:vc animated:YES];
		
	}
	
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	[self.appTableView deselectRowAtIndexPath:[self.appTableView indexPathForSelectedRow] animated:YES];
	if (alertView.tag==1) {
		if (buttonIndex==1) {
			NSString *urlString = [[self.ourApps objectAtIndex:rowClicked] objectForKey:@"appInstallURL"];
			[[UIApplication sharedApplication] openURL:[NSURL URLWithString: urlString]];
			
		}
	}
	
	
}
#pragma mark -
#pragma mark MFMailComposeViewControllerDelegate methods

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
	[controller dismissViewControllerAnimated:YES completion:nil ];
	
	if ((result == MFMailComposeResultSent) || (result == MFMailComposeResultFailed)) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Thanks!"
														 message:@"Thank you for sharing your feedback."
														delegate:self
											   cancelButtonTitle:@"You're welcome"
											   otherButtonTitles:nil];
		[alert show];
	}
}
#pragma mark - Private Methods

- (void)fetchAppList {
   // [WaitView show];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
	
    NSString *urlString = APPLIST_API_URL;
	NSURL *url = [[NSURL alloc] initWithString:urlString];
	NSString *result = [[NSString alloc] initWithContentsOfURL:url encoding:NSASCIIStringEncoding error:nil];
  
	//NSLog(@"Result returned: %@", result);
	
	// Parse JSON result into array of linked apps
    NSMutableDictionary *resultObj = [result JSONValue];

    NSMutableDictionary *linkedAppInfoObj = [resultObj objectForKey:@"results"];
	self.ourApps = [linkedAppInfoObj objectForKey:@"linkedAppInfo"];
    
    for (NSMutableDictionary *appDict in self.ourApps) {
        [self performSelectorInBackground:@selector(fetchAppStoreDataForApp:) withObject:appDict];
    }
}
- (void)fetchAppStoreDataForApp:(NSMutableDictionary *)appDict {
    
    NSString *urlString2 =[NSString stringWithFormat:@"http://itunes.apple.com/lookup?id=%@", [appDict objectForKey:@"appID"]];
    NSLog(@"Requesting data from iTunes with URL: %@", urlString2);
    NSURL *appUrl = [[NSURL alloc] initWithString:urlString2];
    NSString *result2 = [[NSString alloc] initWithContentsOfURL:appUrl encoding:NSASCIIStringEncoding error:nil];
   // NSLog(@"Result returned from app store: %@", result2);
	
	if (result2 != nil) {
		NSDictionary *responseData = [result2 JSONValue];
		NSArray *iTunesAppInfo= [responseData objectForKey:@"results"];
		
		// Grab the iTunes URL
		NSString *thisTrackUrl = [[iTunesAppInfo objectAtIndex:0] objectForKey:@"trackViewUrl"];
		[thisTrackUrl stringByReplacingOccurrencesOfString:@" " withString:@"-"];
		if (thisTrackUrl) {
			[appDict setObject:thisTrackUrl forKey:@"appInstallURL"];
		}
		
		
		// Grab the app image
		NSString *imageURL = [[iTunesAppInfo objectAtIndex:0] objectForKey:@"artworkUrl100"];
		NSError *error = nil;
		UIImage *appImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageURL] options:NSDataReadingMappedAlways error:&error]];
		if (error == nil) {
			[appDict setObject:appImage forKey:@"appImage"];
		}
    }
	@try {
		// Reload the table to show any images we've retrieved
		[self performSelectorOnMainThread:@selector(refreshView) withObject:nil waitUntilDone:NO];
	}
	@catch (NSException * e) {
		// If we fail here, then it means that the app has come back into the foreground and in the meantime
		// has had its objects cleaned up, so that thiçs controller no longer exists in memory. So we'll catch the
		// exception to avoid a crash.
	}
    
}
- (void)refreshView {
    static int refreshCount = 0;
    
    [self.appTableView reloadData];
    refreshCount += 1;
    
    // If we are done fetching all our app data, turn off the network indicator
    if (refreshCount >= [self.ourApps count]) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    }
	
	self.navigationItem.backBarButtonItem.enabled = YES;
	
}
-(void)closeModalView{
//	[self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
