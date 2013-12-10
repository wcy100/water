//
//  AddSecendHandReturn.m
//  JXshop
//
//  Created by yu on 13-5-28.
//  Copyright (c) 2013年 cd. All rights reserved.
//

#import "AddSecendHandReturn.h"

@implementation AddSecendHandReturn
@synthesize result_code,description;
- (void)dealloc
{
    [result_code release];
    [description release];
    [super dealloc];
}
@end
