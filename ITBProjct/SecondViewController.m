//
//  SecondViewController.m
//  ITBProjct
//
//  Created by Dmitry Likhtarov on 24/04/2019.
//  Copyright © 2019 Dmitry Likhtarov. All rights reserved.
//

#import "SecondViewController.h"
#import <WebKit/WebKit.h>

@interface SecondViewController () <WKUIDelegate, WKNavigationDelegate>

@property (weak, nonatomic) IBOutlet WKWebView *webView;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UIButton *enterButton;
@property (weak, nonatomic) IBOutlet UITextField *textSearch;
@property (weak, nonatomic) IBOutlet UIProgressView *progress;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activity;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView.navigationDelegate = self;
    [self showActivityProgress:1];
    self.backButton.alpha = 0.5;
    self.nextButton.alpha = 0.5;

    
    [self.webView addObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress)) options:NSKeyValueObservingOptionNew context:NULL];
    
}

- (IBAction)enterPressed:(id)sender
{
    NSString *text = self.textSearch.text;
    NSURL *url = [NSURL URLWithString:text];
    if (!(url && url.scheme && url.host)) {
        // Вероятно урл некорректный, загуглим
        url = [NSURL URLWithString:[NSString stringWithFormat:@"https://www.google.com/search?q=%@", [self.textSearch.text stringByReplacingOccurrencesOfString:@" " withString:@"+"]]];
    }

    [self showActivityProgress:0];

    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

- (void) stopPressed
{
    [self.webView stopLoading];
    [self showActivityProgress:1.0];
    [self updateUI];
}

- (IBAction)backButtonPressed:(id)sender {
    [self.webView goBack];
}

- (IBAction)nextButtonPressed:(id)sender {
    [self.webView goForward];
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation
{
    self.textSearch.text = webView.URL.absoluteString;
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation
{
    [self updateUI];
}

- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error
{
    [self updateUI];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                       context:(void *)context
{

    if ([keyPath isEqualToString:NSStringFromSelector(@selector(estimatedProgress))] && object == self.webView) {
        [self showActivityProgress:self.webView.estimatedProgress];
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void) updateUI
{
    self.backButton.alpha = self.webView.canGoBack ? 1 : 0.5;
    self.nextButton.alpha = self.webView.canGoForward ? 1 : 0.5;
}

- (void) showActivityProgress:(CGFloat)progress
{
    [self.enterButton removeTarget:nil action:nil forControlEvents:UIControlEventAllEvents];
    NSString *enter;
    self.progress.progress = progress;
    BOOL completed = (progress >= 1.0);
    
    self.progress.hidden = completed;
    UIApplication.sharedApplication.networkActivityIndicatorVisible = completed;
    
    if (completed) {
        [self.activity stopAnimating];
        enter = @"↩️";
        [self.enterButton addTarget:self action:@selector(enterPressed:) forControlEvents:UIControlEventTouchUpInside];
    } else {
        [self.activity startAnimating];
        enter = @"⏹";
        [self.enterButton addTarget:self action:@selector(stopPressed) forControlEvents:UIControlEventTouchUpInside];
    }
    [self.enterButton setTitle:enter forState:UIControlStateNormal];
}

@end
