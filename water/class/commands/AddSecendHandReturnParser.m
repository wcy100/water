//
//  AddSecendHandReturnParser.m
//  JXshop
//
//  Created by yu on 13-5-28.
//  Copyright (c) 2013年 cd. All rights reserved.
//

#import "AddSecendHandReturnParser.h"
#import "AddSecendHandReturn.h"
@implementation AddSecendHandReturnParser
-(BOOL)paserReturnData
{
    if( nil != self.sRetData )
        {
        AddSecendHandReturn *Item = [[AddSecendHandReturn alloc] init];
        Item.result_code = [self.sRetData objectForKey:@"result_code"];
        Item.description = [self.sRetData objectForKey:@"description"];
        [self.allDatas addObject:Item];
        
        [Item release];
        
        }
    
    return YES;
    
}
@end
