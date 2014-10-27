//
//  webViewController.h
//  ActiveWorld
//
//  Created by Eric Cao on 10/23/14.
//  Copyright (c) 2014 Eric Cao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface webViewController : UIViewController<UIWebViewDelegate>
@property (strong,nonatomic) NSString *UrlToOpen;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end
