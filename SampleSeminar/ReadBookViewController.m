//
//  ReadBookViewController.m
//  SampleSeminar
//
//  Created by Kenji Tazawa on 12/08/06.
//  Copyright (c) 2012年 CONIT Co., Ltd. All rights reserved.
//

#import "ReadBookViewController.h"
#import "CustomIndicator.h"

@interface ReadBookViewController (){
  CustomIndicator *customIndicator;
}

/*
 * 前画面に戻ります。
 */
- (void) back:(id)sender;

@end

@implementation ReadBookViewController
@synthesize readBookWebView;
@synthesize bookPath;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
  }
  return(self);
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  customIndicator = [[CustomIndicator alloc] init];

  //戻るボタン生成
  UIImage  *backImg = [UIImage imageNamed:@"icon_back.png"];
  UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];

  [backBtn setImage:backImg forState:UIControlStateNormal];
  [backBtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchDown];

  self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];

  readBookWebView.delegate = self;
  [readBookWebView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:bookPath]]];
}

- (void)viewDidUnload
{
  [self setReadBookWebView:nil];
  [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
  return(interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Private Method
- (void)back:(id)sender
{
  [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UIWebViewDelegate Method
- (void)webViewDidStartLoad:(UIWebView *)webView
{
  [IndicatorUtil showCustomIndicator:customIndicator parentView:self.view];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
  [IndicatorUtil dismissCustomIndicator:customIndicator];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
  NSString *err = [NSString stringWithFormat : @"%d", error.code];

  Log(@"Connection failed! Error - %@ %@ :code:%@",
      [error localizedDescription],
      [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey], err);
}

@end
