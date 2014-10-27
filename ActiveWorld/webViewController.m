//
//  webViewController.m
//  ActiveWorld
//
//  Created by Eric Cao on 10/23/14.
//  Copyright (c) 2014 Eric Cao. All rights reserved.
//

#import "webViewController.h"

@interface webViewController ()

@end

@implementation webViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_top_logo"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTranslucent:NO];
    
    
    NSLog(@"Loading data from: %@", self.UrlToOpen);
    NSURLRequest *htmlData = [NSURLRequest requestWithURL:[NSURL URLWithString:self.UrlToOpen]];
//    NSURL *url = [NSURL fileURLWithPath:[self.UrlToOpen stringByDeletingLastPathComponent]];
//    NSLog(@"baseURL: %@", url);
    
    self.webView.delegate = self;
    self.webView.backgroundColor = [UIColor whiteColor];
    [self.webView loadRequest:htmlData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark WebView Delegate Methods

//- (BOOL)webView:(UIWebView *)theWebView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
//    NSURL *url = [request URL];
//    
//    // Intercept the external http requests and forward to Safari.app
//    if ([[url scheme] isEqualToString:@"http"] || [[url scheme] isEqualToString:@"https"]) {
//        [[UIApplication sharedApplication] openURL:url];
//        return NO;
//    } else {
//        return YES;
//    }
//    
//}

@end
