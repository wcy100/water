//
//  account.h
//  JXshop
//
//  Created by yu on 13-5-29.
//  Copyright (c) 2013年 cd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface account : NSObject
@property (nonatomic, retain) NSString *user_id;
@property (nonatomic, retain) NSString *user_name;
@property (nonatomic, retain) NSString *screen_name;
@property (nonatomic, retain) NSString *head_photo;
@property (nonatomic, retain) NSString *headBase64;
@property (nonatomic, retain) NSString *c_email;
@property (nonatomic, retain) NSString *phone_number;
@property (nonatomic, retain) NSString *sh_address;
@end
