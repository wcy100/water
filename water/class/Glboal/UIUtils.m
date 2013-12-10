//
//  UIUtils.m
//  LiveByTouch
//
//  Created by hao.li on 11-9-22.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UIUtils.h"
#import "Global.h"
#import "DeviceDetection.h"

@implementation UIUtils
+ (void)alert:(NSString *)msg
{
    //UIAlertView *alertView = [[[UIAlertView alloc] initWithTitle:msg message:@"" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] autorelease];
    //[alertView showWithBackground];
}

+ (NSString*) cleanPhoneNumber:(NSString*)phoneNumber
{
    NSString* number = [NSString stringWithString:phoneNumber];
    NSString* number1 = [[[number stringByReplacingOccurrencesOfString:@" " withString:@""]
                          //                        stringByReplacingOccurrencesOfString:@"-" withString:@""]
                          stringByReplacingOccurrencesOfString:@"(" withString:@""] 
                         stringByReplacingOccurrencesOfString:@")" withString:@""];
    
    return number1;    
}

+ (BOOL) makeCall:(NSString *)phoneNumber
{
    if ([DeviceDetection isIPodTouch]){
        //[UIUtils alert:kCallNotSupportOnIPod];
		[Global messagebox:@"该设备不支持拨打电话功能！"];
        return NO;
    }
    
    NSString* numberAfterClear = [UIUtils cleanPhoneNumber:phoneNumber];    
    
    NSURL *phoneNumberURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", numberAfterClear]];
    NSLog(@"make call, URL=%@", phoneNumberURL);
    
    BOOL con = [[UIApplication sharedApplication] openURL:phoneNumberURL];
	if (!con) {
		[Global messagebox:@"该设备不支持拨打电话功能！"];
	}
	return con;
}

+ (void) sendSms:(NSString *)phoneNumber
{
    if ([DeviceDetection isIPodTouch]){
        //[UIUtils alert:kSmsNotSupportOnIPod];
        return;
    }
    
    NSString* numberAfterClear = [UIUtils cleanPhoneNumber:phoneNumber];
    
    NSURL *phoneNumberURL = [NSURL URLWithString:[NSString stringWithFormat:@"sms:%@", numberAfterClear]];
    NSLog(@"send sms, URL=%@", phoneNumberURL);
    [[UIApplication sharedApplication] openURL:phoneNumberURL];    
}

+ (void) sendEmail:(NSString *)phoneNumber
{
    NSURL *phoneNumberURL = [NSURL URLWithString:[NSString stringWithFormat:@"mailto:%@", phoneNumber]];
    NSLog(@"send sms, URL=%@", phoneNumberURL);
    [[UIApplication sharedApplication] openURL:phoneNumberURL];    
}

+ (void) sendEmail:(NSString *)to cc:(NSString*)cc subject:(NSString*)subject body:(NSString*)body
{
    NSString* str = [NSString stringWithFormat:@"mailto:%@?cc=%@&subject=%@&body=%@",
                     to, cc, subject, body];
	
    str = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    
}

@end
