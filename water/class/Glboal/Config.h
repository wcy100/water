//
//  Config.h
//  LiveByTouch
//
//  Created by hao.li on 11-9-7.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class loginReturn;
@class UserInfo;

@interface Config : NSObject {
	NSString *firstTime;
	NSString *lastTime;
	NSString *version;
	UserInfo *userInfo;
	loginReturn *loginResult;
	BOOL isFirstTime;
}
@property(nonatomic) BOOL isFirstTime;
@property(nonatomic,retain) NSString *firstTime;
@property(nonatomic,retain) NSString *lastTime;
@property(nonatomic,retain) NSString *version;
@property(nonatomic,retain) UserInfo *userInfo;
@property(nonatomic,retain) loginReturn *loginResult;

+(Config*) GetInstance;

- (id) initWithCoder: (NSCoder *)coder;
- (void) encodeWithCoder: (NSCoder *)coder;
@end
