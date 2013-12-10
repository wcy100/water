//
//  UserInfoUpdateCommand.h
//  JXshop
//
//  Created by yu on 13-5-29.
//  Copyright (c) 2013年 cd. All rights reserved.
//

#import "CDCommandBase.h"
#import "account.h"
@interface UserInfoUpdateCommand : CDCommandBase
@property (nonatomic, retain) account *user;
@end
