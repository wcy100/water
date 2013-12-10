//
//  Config.m
//  LiveByTouch
//
//  Created by hao.li on 11-9-7.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Config.h"
#import "loginReturn.h"

@implementation Config
@synthesize lastTime,version,userInfo,firstTime,isFirstTime,loginResult;

static Config *global;
+(Config*) GetInstance
{
	
	@synchronized(self)
	{
		if (!global){
			global = [[Config alloc] init];
		}
		return global;
	}
}

-(id) init{
	self = [super init];
	if (self) {
		//userInfo = [[UserInfo alloc] init];
		loginResult = [[loginReturn alloc] init];
	}
	return self;
}


- (id) initWithCoder: (NSCoder *)coder
{
	self = [[Config alloc] init];
	if (self != nil)
    {
        self.lastTime = [coder decodeObjectForKey:@"lastTime"];
        self.version = [coder decodeObjectForKey:@"version"];
		self.userInfo = [coder decodeObjectForKey:@"userInfo"];
		self.loginResult = [coder decodeObjectForKey:@"loginReturn"];
		
		self.firstTime = [coder decodeObjectForKey:@"firstTime"];
		self.isFirstTime = [coder decodeBoolForKey:@"isFirstTime"];
    }
	return self;
}


- (void) encodeWithCoder: (NSCoder *)coder
{
    [coder encodeObject:lastTime forKey:@"lastTime"];
    [coder encodeObject:version forKey:@"version"];
	[coder encodeObject:userInfo forKey:@"userInfo"];
	[coder encodeObject:loginResult forKey:@"loginResult"];
	[coder encodeObject:firstTime forKey:@"firstTime"];
	[coder encodeBool:isFirstTime forKey:@"isFirstTime"];
}
-(void) dealloc{
	
	[firstTime release];
	firstTime = nil;
	
	[lastTime release];
	lastTime = nil;
	
	[version release];
	version = nil;
	
	[userInfo release];
	userInfo = nil;
	
	[loginResult release];
	loginResult = nil;
	[super dealloc];
}
@end
