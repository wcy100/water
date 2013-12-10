//
//  NSString+JSONCategories.h
//  JXshop
//
//  Created by yu on 13-5-6.
//  Copyright (c) 2013年 cd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (JSONCategories)
+(NSString *) jsonStringWithDictionary:(NSDictionary *)dictionary;

+(NSString *) jsonStringWithArray:(NSArray *)array;

+(NSString *) jsonStringWithString:(NSString *) string;

+(NSString *) jsonStringWithObject:(id) object;

@end
