//
//  UserInfoUpdateReturn.m
//  JXshop
//
//  Created by yu on 13-5-29.
//  Copyright (c) 2013年 cd. All rights reserved.
//

#import "UserInfoUpdateReturn.h"

@implementation UserInfoUpdateReturn
@synthesize result_code,description;
- (void)dealloc
{
    [result_code release];
    [description release];
    [super dealloc];
}
@end
