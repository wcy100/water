//
//  NSDictionary+JSONCategories.h
//  JXshop
//
//  Created by yu on 13-5-6.
//  Copyright (c) 2013年 cd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (JSONCategories)
+(NSDictionary*)dictionaryWithContentsOfJSONURLString:(NSString*)urlAddress;
-(NSData*)toJSONData;
@end
