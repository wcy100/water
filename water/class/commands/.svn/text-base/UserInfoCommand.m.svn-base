//
//  UserInfoCommand.m
//  JXshop
//
//  Created by yu on 13-5-29.
//  Copyright (c) 2013年 cd. All rights reserved.
//

#import "UserInfoCommand.h"

@implementation UserInfoCommand
@synthesize user_name;
- (id)init
{
    self = [super init];
    if (self) {
        self.requestService = @"UserInfo";
    }
    return self;
}
-(NSString*)getCommandJSONObj
{
    
    NSMutableDictionary *dic = [[[NSMutableDictionary alloc] init]autorelease];
    
    [dic setObject:user_name forKey:@"user_name"];

    return [dic JSONString];
    
}
- (void)dealloc
{
    [user_name release];
    [super dealloc];
}
@end
