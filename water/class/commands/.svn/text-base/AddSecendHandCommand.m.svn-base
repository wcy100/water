//
//  AddSecendHandCommand.m
//  JXshop
//
//  Created by yu on 13-5-28.
//  Copyright (c) 2013年 cd. All rights reserved.
//

#import "AddSecendHandCommand.h"

@implementation AddSecendHandCommand
@synthesize c_title
,groom
,base64_photo
,n_price
,c_content
,seller_type_id
,fbr_id
,linkman
,linkphone;
- (id)init
{
    self = [super init];
    if (self) {
        self.requestService = @"AddSecendHand";
        seller_type_id = [[NSArray alloc]init];
    }
    return self;
}
-(NSString*)getCommandJSONObj
{
    
    NSMutableDictionary *dic = [[[NSMutableDictionary alloc] init]autorelease];
    
    [dic setObject:c_title forKey:@"c_title"];
    [dic setObject:c_content forKey:@"c_content"];
    [dic setObject:groom forKey:@"groom"];
    [dic setObject:base64_photo forKey:@"base64_photo"];
    [dic setObject:n_price forKey:@"n_price"];
    [dic setObject:fbr_id forKey:@"fbr_id"];
    [dic setObject:linkman forKey:@"linkman"];
    [dic setObject:linkphone forKey:@"linkphone"];
    [dic setObject:seller_type_id forKey:@"seller_type_id"];
    return [dic JSONString];
    
}
- (void)dealloc
{
    [c_title release];
    [groom release];
    [base64_photo release];
    [n_price release];
    [c_content release];
    [seller_type_id release];
    [fbr_id release];
    [linkman release];
    [linkphone release];
    [super dealloc];
}
@end
