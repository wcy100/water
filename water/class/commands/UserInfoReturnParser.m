//
//  UserInfoReturnParser.m
//  JXshop
//
//  Created by yu on 13-5-29.
//  Copyright (c) 2013年 cd. All rights reserved.
//

#import "UserInfoReturnParser.h"
#import "UserInfoReturn.h"
#import "account.h"
@implementation UserInfoReturnParser
-(BOOL)paserReturnData
{
    if( nil != self.sRetData )
        {
        UserInfoReturn *Item = [[UserInfoReturn alloc] init];
        Item.user.user_name = [self.sRetData objectForKey:@"user_name"];
        Item.user.screen_name = [self.sRetData objectForKey:@"screen_name"];
        Item.user.head_photo = [self.sRetData objectForKey:@"head_photo"];
        Item.user.c_email  = [self.sRetData objectForKey:@"c_email"];
        Item.user.phone_number = [self.sRetData objectForKey:@"phone_number"];
        Item.addressValid = NO;
        NSEnumerator *enumerator;
        id key;
         enumerator=[self.sRetData keyEnumerator];
        while((key=[enumerator nextObject]))
        {
        if ([key isEqualToString:@"sh_address"]) {
            Item.addressValid = YES;
            break;
        }
        }
        Item.user.sh_address = [self.sRetData objectForKey:@"sh_address"];
        [self.allDatas addObject:Item];
        
        [Item release];
        
        }
    
    return YES;
    
}
@end
