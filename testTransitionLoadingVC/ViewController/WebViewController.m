//
//  WebViewController.m
//  testTransitionLoadingVC
//
//  Created by Bomi on 2018/1/25.
//  Copyright © 2018年 PrototypeC. All rights reserved.
//

#import "WebViewController.h"
#import <WebKit/WebKit.h>

@interface WebViewController ()<WKNavigationDelegate>
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
@property (strong, nonatomic) WKWebView *webView;
@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.webView = [[WKWebView alloc] initWithFrame:self.view.frame configuration:[[WKWebViewConfiguration alloc] init]];
    self.webView.allowsBackForwardNavigationGestures = YES;
    NSURL *url = [[NSURL alloc] initWithString:@"https://www.youtube.com"];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [self.webView loadRequest:request];
    self.webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:self.webView];
    self.webView.navigationDelegate = self;
    [self.webView setHidden:YES];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [self.indicator stopAnimating];
    [self.webView setHidden:NO];
}

@end
