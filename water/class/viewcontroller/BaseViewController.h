//
//  BaseViewController.h
//  JXshop
//
//  Created by yu on 13-5-2.
//  Copyright (c) 2013年 cd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomNavigationBar.h"
#import "AppDelegate.h"
@interface BaseViewController : UIViewController
@property (nonatomic, retain) UIButton *backBtn;
@property (nonatomic, retain) UIButton *rightBtn;
@property (nonatomic, assign) AppDelegate *theAppDelegate;

-(void)setBackButtonImage:(UIImage *)image;
- (void)setBackButtonText:(NSString *)text;
-(void)setRightButtonText:(NSString *)text;
-(void)setRightButtonImage:(UIImage *)image;
-(void)setNavBackGround:(UIImage *)image;
-(void)setTitleImage:(UIImage *)image;
-(void)hiddenTab;
-(void)showTab;
-(void)showAlert:(NSString *)message;
-(void)showSuccessAlert:(NSString *)message;
- (void)displayNotification:(UIImage *)notifiImage :(NSString *)notificationText;
-(void)right:(UIButton *)sender;
-(void)back:(UIButton *)sender;

-(BOOL)isUserLogin;
@end
