//
//  AddSecendHandCommand.h
//  JXshop
//
//  Created by yu on 13-5-28.
//  Copyright (c) 2013年 cd. All rights reserved.
//

#import "CDCommandBase.h"

@interface AddSecendHandCommand : CDCommandBase
@property (nonatomic, retain) NSString * c_title;
@property (nonatomic, retain) NSString *groom;
@property (nonatomic, retain) NSString *base64_photo;
@property (nonatomic, retain) NSString *n_price;
@property (nonatomic, retain) NSString *c_content;
@property (nonatomic, retain) NSArray *seller_type_id;
@property (nonatomic, retain) NSString *fbr_id;
@property (nonatomic, retain) NSString *linkman;
@property (nonatomic, retain) NSString *linkphone;

@end
