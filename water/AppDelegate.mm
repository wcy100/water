//
//  AppDelegate.m
//  JXshop
//
//  Created by yu on 13-5-2.
//  Copyright (c) 2013年 cd. All rights reserved.
//

#import "AppDelegate.h"
#import "Global.h"
#import "CDServiceRequest.h"
#import "loginCommand.h"
#import "loginReturn.h"
#import "loginReturnParser.h"
@interface AppDelegate ()<NetWebServiceRequestDelegate>
{
    CDServiceRequest *loginRequest;
}
@end
@implementation AppDelegate
@synthesize window ;
@synthesize  userNum = _userNum;
@synthesize userPWD = _userPWD;
@synthesize autoLoginFlag,loginReturnBean;
- (void)dealloc
{
    [loginRequest cancel];
    [loginRequest release];
    [window release];
    [loginReturnBean release];
 
    [_userNum release];
    [_userPWD release];
    [_viewController release];
    [super dealloc];
}
- (BOOL)getSavedPwd
{
    NSUserDefaults *save = [NSUserDefaults standardUserDefaults];
    
    NSObject *obj =[save objectForKey:@"autoLogin"];
    if (obj) {
        autoLoginFlag = [((NSNumber*)obj)boolValue];
    }
    else {
        autoLoginFlag = NO;
    }
    
    
    self.userNum = [save objectForKey:kUserName];
    self.userPWD = [save objectForKey:kPWD];
    
    if (_userNum&&_userPWD) {
        return YES;
    }
    else {
        return NO;
    }
    
    return NO;
}

//开始
- (void)netRequestStarted:(CDServiceRequest *)request{
    
}
//失败
- (void)netRequestFailed:(CDServiceRequest *)request didRequestError:(NSError *)error{
    
    NSLog(@"err:%@",error);
    
}

//成功
- (void)netRequestFinished:(CDServiceRequest *)request
      finishedInfoToResult:(NSString *)result
              responseData:(NSData *)requestData{
    
    if (request==loginRequest) {
        loginReturnParser *parser = [[loginReturnParser alloc]init];
        if ([parser paserReturnCommand:requestData]) {
            [parser paserReturnData];
            if (parser.allDatas!=nil) {
                loginReturn *ret = [parser.allDatas objectAtIndex:0];
                if ([ret.result_code integerValue]==0) {
                    self.loginReturnBean = ret;
                    
                }else {
                    
                }
            }
        }
        [parser release];
        
    }
    return;
}
-(void)loginAccount:(NSString *)account withPWD:(NSString *)pwd{
    if (loginRequest==nil) {
        loginRequest =  [[CDServiceRequest alloc]initWithServiceUrl:BASEURL];
        loginRequest.delegate = self;
    }
    loginCommand *command = [[loginCommand alloc]init];
    command.userName = account;
    command.userPwd = pwd;
    NSData *data = [command getJsonData];
    [loginRequest requestServiceUrlWithData:data];
    [command release];
    
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    gdkEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    autoLoginFlag = NO;
    [self getSavedPwd];
    if (autoLoginFlag) {
        if (_userNum&&_userPWD) {
            [self loginAccount:_userNum withPWD:_userPWD];
        }
    }
    _mapManager = [[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    BOOL ret = [_mapManager start:@"在此处输入您的授权Key"  generalDelegate:nil];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    _viewController = [[SidebarViewController alloc] initWithNibName:@"SidebarViewController" bundle:nil];
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
//    self.window.rootViewController = self.tabBarViewController;
//    [self.window makeKeyAndVisible];
    // Override point for customization after application launch.
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
