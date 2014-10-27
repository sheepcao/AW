//
//  AboutViewController.m
//  ActiveDotCom
//
//  Created by Peter de Tagyos on 1/30/12.
//  Copyright (c) 2012 The Active Network. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "AboutViewController.h"

@interface AboutViewController ()
@property (retain, nonatomic) IBOutlet UIWebView *webView;
@end


@implementation AboutViewController

@synthesize webView;
@synthesize displayTermsAndConditions;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

   // self.view.layer.contents = (id)[UIImage imageNamed:@"background"].CGImage;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSString *filePath = nil;
    
	// Load up the content of the about page
	if (displayTermsAndConditions) {
		filePath  = [[NSBundle mainBundle] pathForResource:@"about" ofType:@"html"];
	} else {
		filePath  = [[NSBundle mainBundle] pathForResource:@"legal" ofType:@"html"];
	}
	
    
    NSLog(@"Loading data from: %@", filePath);
	NSData *htmlData = [NSData dataWithContentsOfFile:filePath];
	NSURL *url = [NSURL fileURLWithPath:[filePath stringByDeletingLastPathComponent]];
    NSLog(@"baseURL: %@", url);
	
	self.webView.delegate = self;
	self.webView.backgroundColor = [UIColor whiteColor];
	[self.webView loadData:htmlData MIMEType:@"text/html" textEncodingName:@"UTF-8" baseURL:url];	

}

-(void)viewDidDisappear:(BOOL)animated {
    [self.webView loadHTMLString:@"" baseURL:nil];
    [super viewDidDisappear:animated];
}

- (void)viewDidUnload {
    [self setWebView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
   
}


#pragma mark WebView Delegate Methods

- (BOOL)webView:(UIWebView *)theWebView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
	NSURL *url = [request URL];
	
	// Intercept the external http requests and forward to Safari.app
	if ([[url scheme] isEqualToString:@"http"] || [[url scheme] isEqualToString:@"https"]) {
		[[UIApplication sharedApplication] openURL:url];
		return NO;
    } else {
		return YES;
    }
    
}

@end
