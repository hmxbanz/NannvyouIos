//
//  TGWebViewController.m
//  HaniEgg
//
//  Created by Danplin on 2018/3/20.
//  Copyright © 2018年 Kapa. All rights reserved.
//

#import "TGWebViewController.h"

#import <WebKit/WebKit.h>

@interface TGWebViewController ()<WKNavigationDelegate>

@property (nonatomic, weak) WKWebView *webView;

@end

@implementation TGWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (self.customTitle) {
        self.title = self.customTitle;
    }
    NSURL *url = [NSURL URLWithString:[self.path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [self.webView loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self.webView setFrame:self.view.bounds];
}

#pragma mark -- WKNavigationDelegate

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    if (self.customTitle.length == 0) {
        self.title = webView.title;
    }
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    
}

#pragma mark -- Accessor

- (WKWebView *)webView{
    if (!_webView) {
        WKWebView *webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
        [webView setNavigationDelegate:self];
        [self.view addSubview:webView];
        
//        [webView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
//        }];
        _webView = webView;
    }
    return _webView;
}

@end
