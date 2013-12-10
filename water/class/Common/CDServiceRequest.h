//
//  NetWebServiceRequest.h
//  HttpRequest
//
//  Created by Richard Liu on 13-3-18.
//  Copyright (c) 2013年 Richard Liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"


typedef enum _NetworkRequestErrorType {
    NetRequestConnectionFailureErrorType = 1,
    NetRequestTimedOutErrorType = 2,
	
} NetworkRequestErrorType;


extern NSString* const NetWebServiceRequestErrorDomain;

@protocol NetWebServiceRequestDelegate;

@interface CDServiceRequest : NSObject{
    NSString * _ServerURL;
    id<NetWebServiceRequestDelegate> _delegate;

}
@property (nonatomic, retain) NSString * ServerURL;
@property (nonatomic, assign) id<NetWebServiceRequestDelegate> delegate;
@property (nonatomic, assign) NSInteger tag;
-(id)initWithServiceUrl:(NSString *)_url;
+(id)requestServiceUrl:(NSString *)_url withData:(NSData *)body;

+(id)requestServiceUrl:(NSString *)_url jsonString:(NSString *)_jsonString;
-(void)requestServiceUrlWithData:(NSData *)body;
-(void)requestServiceUrlWithjsonString:(NSString *)_jsonString;
- (void)cancel;

- (BOOL)isCancelled;
- (BOOL)isExecuting;
- (BOOL)isFinished;

- (void)startAsynchronous;

@end



@protocol NetWebServiceRequestDelegate <NSObject>

@optional


//开始
- (void)netRequestStarted:(CDServiceRequest *)request;
//失败
- (void)netRequestFailed:(CDServiceRequest *)request didRequestError:(NSError *)error;

@required
//成功
- (void)netRequestFinished:(CDServiceRequest *)request
      finishedInfoToResult:(NSString *)result
              responseData:(NSData *)requestData;


@end

