//
//  UserInfoUpdateReturnParser.m
//  JXshop
//
//  Created by yu on 13-5-29.
//  Copyright (c) 2013年 cd. All rights reserved.
//

#import "UserInfoUpdateReturnParser.h"
#import "UserInfoUpdateReturn.h"
@implementation UserInfoUpdateReturnParser
-(BOOL)paserReturnData
{
    if( nil != self.sRetData )
        {
        UserInfoUpdateReturn *Item = [[UserInfoUpdateReturn alloc] init];
        Item.result_code = [self.sRetData objectForKey:@"result_code"];
        Item.description = [self.sRetData objectForKey:@"description"];
        [self.allDatas addObject:Item];
        
        [Item release];
        
        }
    
    return YES;
    
}
@end
