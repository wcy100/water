//
//  NSDictionary+JSONCategories.m
//  JXshop
//
//  Created by yu on 13-5-6.
//  Copyright (c) 2013年 cd. All rights reserved.
//

#import "NSDictionary+JSONCategories.h"

@implementation NSDictionary (JSONCategories)
+(NSDictionary*)dictionaryWithContentsOfJSONURLString:(NSString*)urlAddress{
    NSData* data =[NSData dataWithContentsOfURL:[NSURL URLWithString: urlAddress]];
    __autoreleasing NSError* error =nil;
    id result =[NSJSONSerialization JSONObjectWithData:data
                                               options:kNilOptions error:&error];
    if(error !=nil)return nil;
    return result;
}
-(NSData*)toJSONData{
    
    if ([NSJSONSerialization isValidJSONObject:self]) {
    NSError* error =nil;
    
    id result =[NSJSONSerialization dataWithJSONObject:self
                                               options:NSJSONReadingMutableLeaves error:&error];
    if(error !=nil)return nil;
    return result;
    }else
    return nil;
}

@end
