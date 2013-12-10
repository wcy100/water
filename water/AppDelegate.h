//
//  AppDelegate.h
//  water
//
//  Created by chunyu.wang on 13-12-10.
//  Copyright (c) 2013年 cn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Global.h"
#import "loginReturn.h"
#import "SidebarViewController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    
    NSString *_userNum;
    NSString *_userPWD;
    BOOL autoLoginFlag;
}
@property (retain, nonatomic) SidebarViewController *viewController;
@property (retain, nonatomic) UIWindow *window;
@property (nonatomic, retain) loginReturn *loginReturnBean;
@property (retain,nonatomic) NSString *userNum;
@property (retain,nonatomic) NSString *userPWD;
@property (nonatomic, assign) BOOL autoLoginFlag;
@end
