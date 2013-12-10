//
//  UserInfoUpdateCommand.m
//  JXshop
//
//  Created by yu on 13-5-29.
//  Copyright (c) 2013年 cd. All rights reserved.
//

#import "UserInfoUpdateCommand.h"

@implementation UserInfoUpdateCommand
@synthesize user;
- (id)init
{
    self = [super init];
    if (self) {
        user = [[account alloc]init];
        self.requestService = @"UserInfoUpdate";
    }
    return self;
}
-(NSString*)getCommandJSONObj
{
    
    NSMutableDictionary *dic = [[[NSMutableDictionary alloc] init]autorelease];
    
    [dic setObject:user.user_id forKey:@"user_id"];
    if (user.screen_name) 
    [dic setObject:user.screen_name forKey:@"screen_name"];
    if (user.headBase64) 
    [dic setObject:user.headBase64 forKey:@"head_photo"];
    if (user.c_email) 
    [dic setObject:user.c_email forKey:@"c_email"];
    if (user.phone_number) 
    [dic setObject:user.phone_number forKey:@"phone_number"];
    if (user.sh_address)
    [dic setObject:user.sh_address forKey:@"sh_address"];
    return [dic JSONString];
    
}
- (void)dealloc
{
    [user release];
    [super dealloc];
}
@end
