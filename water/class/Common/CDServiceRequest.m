//
//  ServiceHelper.m
//  HttpRequest
//
//  Created by Richard Liu on 13-3-18.
//  Copyright (c) 2013年 Richard Liu. All rights reserved.
//

#import "CDServiceRequest.h"
#import "Global.h"

NSString* const NetWebServiceRequestErrorDomain = @"NetWebServiceRequestErrorDomain";


@interface CDServiceRequest ()<ASIHTTPRequestDelegate>
{
    __block ASIHTTPRequest* _runningRequest;
    NSRecursiveLock *_cancelLock;
}
@property (nonatomic, retain) __block ASIHTTPRequest* runningRequest;
@property (nonatomic, retain) NSRecursiveLock *cancelLock;

@end


@implementation CDServiceRequest
@synthesize runningRequest = _runningRequest;
@synthesize delegate = _delegate;
@synthesize cancelLock = _cancelLock;
@synthesize tag;
@synthesize ServerURL = _ServerURL;

-(id)initWithServiceUrl:(NSString *)_url {
    if ((self = [super init])) {
        self.ServerURL = _url;
    }
    return self;
}
-(id)initWithServiceUrl:(NSString *)_url jsonString:(NSString *)_jsonString{
    
    if ((self = [super init])) {

    NSData *body = [_jsonString  dataUsingEncoding:NSUTF8StringEncoding];
    [self initWithServiceUrl:_url withData:body];
    }
    return self;
}
-(id)initWithServiceUrl:(NSString *)_url withData:(NSData *)body{
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@", _url]];
    if ((self = [super init])) {
    ASIHTTPRequest *req = [[ASIHTTPRequest alloc] initWithURL:url];
    req.delegate = self;
    //req.userInfo = [NSDictionary dictionaryWithObject:@"initialRequest" forKey:@"type"];
   
    [req appendPostData:body];
    [req startSynchronous];
    self.runningRequest = req;
    [req release];
    self.cancelLock = [[NSRecursiveLock alloc]  init];
    }
    return self;
}
+(id)requestServiceUrl:(NSString *)_url withData:(NSData *)body{
    return [[[self alloc]initWithServiceUrl:_url withData:body]autorelease];
}

+(id)requestServiceUrl:(NSString *)_url jsonString:(NSString *)_jsonString{
    return [[[self alloc]initWithServiceUrl:_url jsonString:_jsonString]autorelease];
}
-(void)requestServiceUrlWithData:(NSData *)body{
    NSString *log = [[NSString alloc] initWithData:body encoding: gdkEncoding];//kCFStringEncodingUTF8
    NSLog(@"\nBEGIN＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝\n网络请求地址：\n%@\n\n网络请求参数：\n%@\n\n", _ServerURL, log);
    [log release];
    NSURL * url = [NSURL URLWithString:_ServerURL];
    
    ASIHTTPRequest *req = [[ASIHTTPRequest alloc] initWithURL:url];
    req.delegate = self;
    //req.userInfo = [NSDictionary dictionaryWithObject:@"initialRequest" forKey:@"type"];
    [ASIHTTPRequest hideNetworkActivityIndicator];
    [req appendPostData:body];
    //  [req setRequestMethod:@"PUT"];
    [req startAsynchronous];
    self.runningRequest = req;
    [req release];
    NSRecursiveLock *lock = [[NSRecursiveLock alloc]  init];
    self.cancelLock = lock;
    [lock release];
}
-(void)requestServiceUrlWithjsonString:(NSString *)_jsonString{
    
    NSData *body = [_jsonString  dataUsingEncoding:NSUTF8StringEncoding];
    [self requestServiceUrlWithData:body];
}

-(void)dealloc{
    [self cancel];
    [_ServerURL release];
    [super dealloc];
}



- (BOOL)isCancelled
{
    return [self.runningRequest isCancelled];
}

- (BOOL)isExecuting
{
    return [self.runningRequest isExecuting];
}

- (BOOL)isFinished
{
    return [self.runningRequest isFinished];
}


- (void) setDelegate:(id)delegate
{
    CLog(@"begin");
    [self.cancelLock lock];
    
    _delegate = delegate;
    
    [self.cancelLock unlock];
    CLog(@"end");
}



- (void)startAsynchronous
{
    CLog(@"Url_path:%@",_runningRequest.url);
    CLog(@"Method:%@",_runningRequest.requestMethod);
    CLog(@"PostData:%@",_runningRequest.postBody);
    [_runningRequest startAsynchronous];
}



- (void) cancel
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    CLog(@"begin");
    [self.cancelLock lock];
    
    self.delegate = nil;
    
    if (self.runningRequest) {
        [self.runningRequest clearDelegatesAndCancel];
        self.runningRequest = nil;
    }
    
    [self.cancelLock unlock];
    
    CLog(@"end");
}


- (void)NetWebServiceRequestStarted
{
    CLog(@"begin");
    if (_delegate && [_delegate respondsToSelector:@selector(netRequestStarted:)]) {
        [self.delegate netRequestStarted:self];
    }
    CLog(@"end");
}



- (void)FinisheddidRecvedInfoToResult:(NSString *)result responseData:(NSData*)requestData
{
    CLog(@"begin");
    if (_delegate && [_delegate respondsToSelector:@selector(netRequestFinished: finishedInfoToResult: responseData:)]) {
		[_delegate netRequestFinished:self finishedInfoToResult:result responseData:requestData];
	}
    CLog(@"end");
}

- (void) FaileddidRequestError:(NSError *)error
{
    CLog(@"begin");
    
    if (_delegate && [_delegate respondsToSelector:@selector(netRequestFailed:didRequestError:)]) {
        [_delegate netRequestFailed:self didRequestError:error];
    }
    CLog(@"end");
}




#pragma mark -
#pragma mark - ASIHTTPRequestDelegate Methods
- (void)requestStarted:(ASIHTTPRequest *)request
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [self NetWebServiceRequestStarted];
}


- (void)requestFinished:(ASIHTTPRequest *)request
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    int statusCode = [request responseStatusCode];

	// Use when fetching text data
	NSString *responseString = [request responseString];
	NSString *result = nil;
    if (statusCode == 200) {
        //表示正常请求
        NSData *responseData = [request responseData];
        [self FinisheddidRecvedInfoToResult:result responseData:responseData];
    }
    else{
        NSError *error;
        
        if (request.responseStatusMessage) {
            error = ERROR_INFO(NetWebServiceRequestErrorDomain, request.responseStatusCode,request.responseStatusMessage);
        }
        else {
            error = ERROR_NOINFO(NetWebServiceRequestErrorDomain, request.responseStatusCode);
        }
        
        CLog(@"error:%@",error);
        
        [self FaileddidRequestError:error];
    }
}



- (void)requestFailed:(ASIHTTPRequest *)request
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
  
    NSError *error = ERROR_DICTINFO(NetWebServiceRequestErrorDomain, request.error.code, request.error.userInfo);
    
    if (error.code == ASIRequestTimedOutErrorType) {
        error = ERROR_INFO(NetWebServiceRequestErrorDomain, NetRequestTimedOutErrorType, @"网络连接超时");
    }
    else if (error.code == ASIConnectionFailureErrorType)
    {
        error = ERROR_INFO(NetWebServiceRequestErrorDomain, NetRequestConnectionFailureErrorType, @"未连接网络");
    }
    
    //网络错误
    [self FaileddidRequestError:error];
	
}






@end
