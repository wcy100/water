//
//  CUCallService.h
//  cifco@iPhone
//
//  Created by zhao dan on 9/25/10.
//  Copyright 2010 cucsi. All rights reserved.
//

#import <Foundation/Foundation.h>

#define simulateDataMode 0

@interface CUCallService : NSObject {
	NSString *httpLocation;
	id connectionDelegate;
	NSMutableData *receiveData;
	NSURLConnection *urlConnection;
	NSString* deviceId;
	NSString *appVersion;
	NSTimer *timer;
    BOOL isCalling;
}

@property (nonatomic, retain) NSString *deviceId;
@property (nonatomic, retain) NSString *appVersion;
@property (nonatomic, retain) NSTimer *timer;
@property (nonatomic, readonly) BOOL isCalling;

+ (NSData *)callService:(NSString *)urlString body:(NSString *)body error:(NSString **)error;

- (id)initWithDelegate:(id)delegate;
- (void)cancelConnection;
- (void)callhttpservice:(NSString *)uri postBody:(NSData *)body;
- (void)callservicewithoutbody:(NSString *)operation;
- (void)callservicewithbody:(NSString *)operation body:(NSString *)body;
- (void)getFileWithURL:(NSString*)uri;

- (NSData*)synchronousRequest:(NSString *)uri postBody:(NSData *)body;
- (NSData*)synchronousRequestWithBody:(NSString*)operation body:(NSString*)body;
- (NSData*)synchronousRequestWithOutBody:(NSString*)operation;

- (void)getContentOf:(NSString *)url;

@end

@protocol CUCallServiceDelegate<NSObject>

- (void)callFinish:(CUCallService *)caller withData:(NSData *)data;

@optional
- (void)callFailed:(CUCallService *)caller withError:(NSError *)error;
- (void)callerDidReceiveData:(NSInteger)length;
- (void)sendData:(CUCallService *)connection   didSendBodyData:(NSInteger)bytesWritten
 totalBytesWritten:(NSInteger)totalBytesWritten
totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite;
//全部公告
- (void)allNotice;
@end