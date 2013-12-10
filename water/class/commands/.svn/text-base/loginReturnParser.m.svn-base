//
//  loginReturnParser.m
//  JXshop
//
//  Created by yu on 13-5-20.
//  Copyright (c) 2013年 cd. All rights reserved.
//

#import "loginReturnParser.h"
#import "loginReturn.h"
@implementation loginReturnParser
-(BOOL)paserReturnData
{
    if( nil != self.sRetData )
        {
            loginReturn *Item = [[loginReturn alloc] init];
        Item.user_id = [self.sRetData objectForKey:@"user_id"];
        Item.user_name = [self.sRetData objectForKey:@"user_name"];
        Item.result_code = [self.sRetData objectForKey:@"result_code"];
        Item.description = [self.sRetData objectForKey:@"description"];
            [self.allDatas addObject:Item];
            
            [Item release];
        
        }
    
    return YES;
    
}
@end
