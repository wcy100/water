//
//  UserInfoReturn.h
//  JXshop
//
//  Created by yu on 13-5-29.
//  Copyright (c) 2013年 cd. All rights reserved.
//

#import <Foundation/Foundation.h>
@class account;
@interface UserInfoReturn : NSObject
@property (nonatomic, retain) account *user;
@property (nonatomic, assign) BOOL addressValid;
@end
