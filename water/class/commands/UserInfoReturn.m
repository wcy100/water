//
//  UserInfoReturn.m
//  JXshop
//
//  Created by yu on 13-5-29.
//  Copyright (c) 2013年 cd. All rights reserved.
//

#import "UserInfoReturn.h"
#import "account.h"
@implementation UserInfoReturn
@synthesize user,addressValid;
- (id)init
{
    self = [super init];
    if (self) {
        user = [[account alloc]init];
    }
    return self;
}
- (void)dealloc
{
    [user release];
    [super dealloc];
}
@end
