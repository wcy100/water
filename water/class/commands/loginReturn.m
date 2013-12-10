//
//  loginReturn.m
//  JXshop
//
//  Created by yu on 13-5-20.
//  Copyright (c) 2013年 cd. All rights reserved.
//

#import "loginReturn.h"

@implementation loginReturn
@synthesize user_id = _user_id;
@synthesize user_name = _user_name;
@synthesize result_code = _result_code;
@synthesize description = _description;

- (void)dealloc
{
    [_user_name release];
    [_user_id release];
    [_result_code release];
    [_description release];
    [super dealloc];
}
@end
