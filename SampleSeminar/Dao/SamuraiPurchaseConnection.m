//
//  SamuraiPurchaseConnection.m
//  SampleSeminar
//
//  Created by Kenji Tazawa on 12/07/26.
//  Copyright (c) 2012年 CONIT Co., Ltd. All rights reserved.
//

#import "SamuraiPurchaseConnection.h"

@implementation SamuraiPurchaseConnection {
  BOOL            _connectionFlag;
  NSURLConnection *_connection;
}

@synthesize delegate;

+ (NSString *)pathToken
{
  NSMutableString *pathtoken = [NSMutableString string];

  [pathtoken appendString:@"?token="];
  [pathtoken appendString:TOKEN];
  return(pathtoken);
}

- (NSURL *)URLWithPath:(NSString *)path
{
  NSMutableString *url = [NSMutableString stringWithString:BASE_URL];

  [url appendString:path];

  return([NSURL URLWithString:url]);
}

- (void)cancelConnection
{
  if ((_connection) && (_connectionFlag == YES)) {
    [_connection cancel];
  }
  NSLog(@"cancelConnection");

  [NSObject cancelPreviousPerformRequestsWithTarget:self];
}

- (void)doRequest:(NSURLRequest *)request
{
  Log(@"RequestURL:%@", request);
  _connectionFlag = YES;
  _receivedData   = [[NSMutableData alloc] init];
  _connection     = [[NSURLConnection alloc] initWithRequest:request delegate:self];
  [self performSelector:@selector(doRequestTimeOut:) withObject:_connection afterDelay:TIMEOUT_SEC];
  if (!_connection) {
    return;
  }
}

- (void)didFinishLoadingWithData:(NSData *)receivedData
{
  //継承側で各JSONのパース処理を実装する
}

#pragma mark - NSURLConnectionDelegate
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
  NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
  NSString          *statusCode   = [NSString stringWithFormat : @"%d", httpResponse.statusCode];

  NSLog(@"statusCode:%@", statusCode);
  [_receivedData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
  [NSObject cancelPreviousPerformRequestsWithTarget:self];
  [_receivedData appendData:data];
}

- (void)connection:(NSURLConnection *)connection
  didFailWithError:(NSError *)error
{
  _connectionFlag = NO;

  NSString *err = [NSString stringWithFormat : @"%d", error.code];
  Log(@"Connection failed! Error - %@ %@ :code:%@",
      [error localizedDescription],
      [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey], err);

  [self cancelConnection];
  [(id < SamuraiPurchaseDaoDelegate >) delegate didFailWithNetworkError:error];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
  _connectionFlag = NO;

  [NSObject cancelPreviousPerformRequestsWithTarget:self];

  NSError      *err = nil;

  NSDictionary *result
    =
      [NSJSONSerialization JSONObjectWithData:_receivedData options:NSJSONReadingMutableContainers
       error:&
       err];

  if (err != nil) {
    [(id < SamuraiPurchaseDaoDelegate >) delegate didFailWithAPIError:@"9999" message:@"システムエラー"];
    return;
  }

  Log(@"%@", result);

  NSDictionary *errorInfo = [result objectForKey:@"error_info"];
  if (errorInfo != nil) {
    NSString *code    = [errorInfo objectForKey:@"code"];
    NSString *message = [errorInfo objectForKey:@"message"];

    [(id < SamuraiPurchaseDaoDelegate >) delegate didFailWithAPIError:code message:message];
    return;
  }

  [self didFinishLoadingWithData:_receivedData];
}

- (void)doRequestTimeOut:(NSURLRequest *)request
{
  NSError *error = [[NSError alloc] initWithDomain:@"" code:NSURLErrorTimedOut userInfo:nil];

  [self cancelConnection];
  [(id < SamuraiPurchaseDaoDelegate >) delegate didFailWithNetworkError:error];
}

@end
