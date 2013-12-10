//
//  NSData+JSONCategories.m
//  JXshop
//
//  Created by yu on 13-5-6.
//  Copyright (c) 2013年 cd. All rights reserved.
//

#import "NSData+JSONCategories.h"

@implementation NSData (JSONCategories)
-(id)toJSONObject{
    NSError* error =nil;
    id json =[NSJSONSerialization
                         JSONObjectWithData:self //1
                         options:kNilOptions
                         error:&error];
    if(error !=nil)return nil;
    return json;
}
@end
