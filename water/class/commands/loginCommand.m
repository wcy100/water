//
//  loginCommand.m
//  JXshop
//
//  Created by yu on 13-5-20.
//  Copyright (c) 2013年 cd. All rights reserved.
//

#import "loginCommand.h"

@implementation loginCommand
@synthesize userName = _userName;
@synthesize userPwd = _userPwd;
-(id)init
{
    self = [super init];
    
    if(self)
        {
        self.requestService = @"Login";//Delqm";
        }
    
    return self;
}

-(NSString*)getCommandJSONObj
{
    
    NSMutableDictionary *dic = [[[NSMutableDictionary alloc] init]autorelease];
    [dic setObject:self.userName forKey:@"user_name"];
    [dic setObject:self.userPwd forKey:@"password"];
    return [dic JSONString];
     
}

-(void)dealloc
{
    [_userName release];
    [_userPwd release];
    
    [super dealloc];
}
@end
