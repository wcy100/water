//
//  CUCallService.m
//  cifco@iPhone
//
//  Created by zhao dan on 9/25/10.
//  Copyright 2010 cucsi. All rights reserved.
//

#import "CUCallService.h"

#import <SystemConfiguration/SystemConfiguration.h>
#import <netinet/in.h>
#import <arpa/inet.h>
#import <netdb.h>
#import "Global.h"
@implementation CUCallService

@synthesize deviceId;
@synthesize appVersion;
@synthesize timer;
@synthesize isCalling;

- (id) initWithDelegate: (id)delegate {
	self = [super init];
	
	if (self)
	{
		httpLocation = BASEURL;
		connectionDelegate = delegate;
		urlConnection = nil;
		receiveData = [[NSMutableData alloc] init];
		
        isCalling = NO;
	}
	
	return self;
}

- (void)changeHttpLocationToUploadLocation {
    //	httpLocation = kUploadAddress;
}


- (void)changeHttpLocationToVerifyLocation {
    //	httpLocation = CCDURL;
}

- (void) dealloc
{
	connectionDelegate = nil;
	[urlConnection release];
	[receiveData release];
	//[httpLocation release];
	[deviceId release];
	[appVersion release];
	[timer invalidate];
	[timer release];
	timer = nil;
	[super dealloc];
}


- (void) cancelConnection {
    isCalling = NO;
	if( nil != urlConnection )
	{
		//NSLog(@"cancelConnection---------\nconnection: %@", urlConnection);
		[urlConnection cancel];
		[urlConnection release];
		urlConnection = nil;
		[timer invalidate];
		[timer release];
		timer = nil;
	}
}

#pragma mark -
#pragma mark http method
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
	NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
	if (NO == [httpResponse isKindOfClass:[NSHTTPURLResponse class]] || httpResponse.statusCode != 200) {
		[connection cancel];
		NSString *errorString = nil;
		
		switch (httpResponse.statusCode) {
			case 500:
				errorString = @"服务器处理异常！";
				break;
			case 403:
				errorString = @"请求被服务器拒绝！";
				break;
			case 404:
				errorString = @"请求的服务不存在！";
				break;
			default:
				break;
		}
		NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:errorString, NSLocalizedDescriptionKey, nil];
		NSError *error = [[NSError alloc] initWithDomain:NSURLErrorDomain code:httpResponse.statusCode userInfo:dic];
		[self connection:connection didFailWithError:error];
		[error release];
		[dic release];
		[errorString release];
	}
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    
	[receiveData appendData:data];
	if ([connectionDelegate respondsToSelector:@selector(callerDidReceiveData:)]) {
		NSInteger len = [receiveData length];
		[connectionDelegate callerDidReceiveData:len];
	}
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	[timer invalidate];
	[timer release];
	timer = nil;
    isCalling = NO;
//NSString *log = [[NSString alloc] initWithData:receiveData encoding:gdkEncoding];
//NSLog(@"\n网络请求结果：\n%@\n\nEND＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝\n\n\n", log);
//[log release];
	
	if ([connectionDelegate respondsToSelector:@selector(callFinish:withData:)]) {
		[connectionDelegate callFinish:self withData:receiveData];
	}
	
	[urlConnection release];
	urlConnection = nil;
	[receiveData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	[timer invalidate];
	[timer release];
	timer = nil;
    isCalling = NO;
	if ([connectionDelegate respondsToSelector:@selector(callFailed:withError:)]) {
		[connectionDelegate callFailed:self withError:error];
	}
	else {
		NSString *errorString = [error localizedDescription];
		NSString *strBody = [NSString stringWithFormat:@"{\"code\":-1,\"message\":\"%@\"}", errorString];
		[receiveData setLength:0];
		const char *gdkString = [strBody cStringUsingEncoding:gdkEncoding];
		[receiveData appendBytes:gdkString length:strlen(gdkString)];
		
		[self connectionDidFinishLoading:connection];
	}
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
	NSURLCredential *credential = [[NSURLCredential alloc] initWithTrust:nil];
	[[challenge sender] useCredential:credential forAuthenticationChallenge:challenge];
	[credential release];
}

- (void)connection:(NSURLConnection *)connection   didSendBodyData:(NSInteger)bytesWritten
 totalBytesWritten:(NSInteger)totalBytesWritten
totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite
{
    if (timer != nil) {
        [timer invalidate];
        [timer release];
        timer = nil;
    }
    
    //NSLog(@"%d --- %d ---- %d" , bytesWritten , totalBytesWritten , totalBytesExpectedToWrite);
    if ([connectionDelegate respondsToSelector:@selector(sendData: didSendBodyData: totalBytesWritten: totalBytesExpectedToWrite:)]) {
		[connectionDelegate sendData:self didSendBodyData:bytesWritten totalBytesWritten:totalBytesWritten totalBytesExpectedToWrite:totalBytesExpectedToWrite];
	}
}

- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace
{
	return YES;
}

- (void)callhttpservice:(NSString *)uri postBody:(NSData *)body
{
    if ( !isCalling ) {
        
       if( [self isConnected] )
       {
           isCalling = YES;
            NSString *urlString = [[NSString alloc] initWithFormat:@"%@%@", httpLocation, uri];
            NSURL *url = [[NSURL alloc] initWithString:urlString];
           
//NSString *log = [[NSString alloc] initWithData:body encoding:gdkEncoding];
//NSLog(@"\nBEGIN＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝\n网络请求地址：\n%@\n\n网络请求参数：\n%@\n\n", urlString, log);
//[log release];
           
            [urlString release];
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
            [request setCachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData];
            [url release];
            [request setHTTPMethod:@"POST"];
            [request setValue:@"application/octet-stream" forHTTPHeaderField:@"Content-Type"];
            
            if (0 != [body length]) {
                [request setHTTPBody:body];
            }
            //NSString *log2 = [[NSString alloc] initWithData:body encoding:gdkEncoding];
            urlConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
            [request release];
            timer = [NSTimer scheduledTimerWithTimeInterval:30 target:self selector:@selector(timeOut:) userInfo:nil repeats:NO];
            [timer retain];
            [timer setFireDate: [NSDate dateWithTimeIntervalSinceNow: 30]];
       }
       else
       {
           if ([connectionDelegate respondsToSelector:@selector(callFailed:withError:)]) {
               [connectionDelegate callFailed:self withError:nil];
           }

       }
    }
}

-(void)getFileWithURL:(NSString*)uri {
    isCalling = YES;
	NSString *urlString = [[NSString alloc] initWithFormat:@"%@", uri];
	NSURL *url = [[NSURL alloc] initWithString:urlString];
	[urlString release];
	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
	[request setCachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData];
	[url release];
	[request setHTTPMethod:@"GET"];
	urlConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
	[request release];
}

- (void)timeOut:(NSTimer*)timer1
{
	[urlConnection cancel];
    isCalling = NO;
	if ([connectionDelegate respondsToSelector:@selector(callFailed:withError:)]) {
		[connectionDelegate callFailed:self withError:nil];
	}
	else {
		NSString *strBody = [NSString stringWithFormat:@"{\"code\":-1,\"message\":\"%@\"}", @"连接超时"];
		[receiveData setLength:0];
		const char *gdkString = [strBody cStringUsingEncoding:gdkEncoding];
		[receiveData appendBytes:gdkString length:strlen(gdkString)];
		
		[self connectionDidFinishLoading:urlConnection];
	}
}

- (void)callservicewithoutbody:(NSString *)operation
{
	NSString *body = [NSString stringWithFormat:@"deviceID=%@", self.deviceId];
	const char *gdkString = [body cStringUsingEncoding:gdkEncoding];
	NSData *bodyData = [[NSData alloc] initWithBytes:gdkString length:strlen(gdkString)];
	[self callhttpservice:operation postBody:bodyData];
	[bodyData release];
}

- (void)callservicewithbody:(NSString *)operation body:(NSString *)body
{
	const char *gdkString = [body cStringUsingEncoding:gdkEncoding];
	NSData *bodyData = [[NSData alloc] initWithBytes:gdkString length:strlen(gdkString)];
	[self callhttpservice:operation postBody:bodyData];
	[bodyData release];
}

- (BOOL) isConnected {
    // Create zero addy
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    // Recover reachability flags
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    if (!didRetrieveFlags) {
//        NSLog(@"Error. Could not recover network reachability flags");
        return NO;
    }
    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
    BOOL nonWiFi = flags & kSCNetworkReachabilityFlagsTransientConnection;
    NSURL *testURL = [NSURL URLWithString:@"http://www.baidu.com/"];
    NSURLRequest *testRequest = [NSURLRequest requestWithURL:testURL  cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:20.0];
    NSURLConnection *testConnection = [[[NSURLConnection alloc] initWithRequest:testRequest delegate:nil] autorelease];
    return ((isReachable && !needsConnection) || nonWiFi) ? (testConnection ? YES : NO) : NO;
}


@end
