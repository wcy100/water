//
//  account.m
//  JXshop
//
//  Created by yu on 13-5-29.
//  Copyright (c) 2013年 cd. All rights reserved.
//

#import "account.h"

@implementation account
@synthesize  user_id,user_name
,screen_name
,head_photo,headBase64
,c_email
,phone_number
,sh_address;
- (void)dealloc
{
    [headBase64 release];
    [user_id release];
    [user_name release];
    [screen_name release];
    [head_photo release];
    [c_email release];
    [phone_number release];
    [sh_address release];
    [super dealloc];
}
@end
