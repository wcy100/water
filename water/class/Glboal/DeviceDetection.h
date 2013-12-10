//
//  DeviceDetection.h
//  LiveByTouch
//
//  Created by hao.li on 11-9-22.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sys/utsname.h>

enum {
    MODEL_IPHONE_SIMULATOR,
    MODEL_IPOD_TOUCH,
    MODEL_IPHONE,
    MODEL_IPHONE_3G,
    MODEL_IPAD
};

@interface DeviceDetection : NSObject

+ (uint) detectDevice;

+ (NSString *) returnDeviceName:(BOOL)ignoreSimulator;
+ (BOOL) isIPodTouch;
+ (BOOL) isOS4;
+ (BOOL) canSendSms;

@end
