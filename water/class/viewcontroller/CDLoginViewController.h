//
//  CDLoginViewController.h
//  EMPEE
//
//  Created by chengxiaodong on 13-4-13.
//  Copyright (c) 2013年 CDSoftWare. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "CDServiceRequest.h"

@interface CDLoginViewController : BaseViewController<UITextFieldDelegate,NetWebServiceRequestDelegate>{
    CDServiceRequest *loginRequest;
}
@property (nonatomic, assign) BOOL autoLoginFlag;
@property (nonatomic, assign)  NSString *savedPwd;
@property (nonatomic, assign) NSString *savedPhone;
@property (retain, nonatomic) IBOutlet UITextField *accountTextfield;
@property (retain, nonatomic) IBOutlet UITextField *secretTextfield;
@property (retain, nonatomic) IBOutlet UIButton *sureBtn;
@property (retain, nonatomic) IBOutlet UIButton *resetSecretBtn;
@property (retain, nonatomic) IBOutlet UIButton *autoLogBtn;
@property (retain, nonatomic) IBOutlet UIView *inputView;
- (IBAction)sure:(UIButton *)sender;
- (IBAction)setAutologin:(UIButton *)sender;
- (IBAction)resetSecret:(UIButton *)sender;
@property (retain, nonatomic) IBOutlet UIButton *closeBtn;
- (IBAction)hidenKeyBoard:(UIButton *)sender;
@property (retain, nonatomic) IBOutlet UIView *waitingView;
@property (retain, nonatomic) IBOutlet UIActivityIndicatorView *activityView;
+(CDLoginViewController *)initInstance;
@end
