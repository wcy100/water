//
//  CDLoginViewController.m
//  EMPEE
//
//  Created by chengxiaodong on 13-4-13.
//  Copyright (c) 2013年 CDSoftWare. All rights reserved.
//

#import "CDLoginViewController.h"
#import "loginCommand.h"
#import "loginReturn.h"
#import "loginReturnParser.h"
#import "registerViewController.h"
@interface CDLoginViewController ()
{
    CGRect orignFrame;
}
@end

@implementation CDLoginViewController
@synthesize autoLoginFlag,savedPwd,savedPhone;
//开始
- (void)netRequestStarted:(CDServiceRequest *)request{
    
}
//失败
- (void)netRequestFailed:(CDServiceRequest *)request didRequestError:(NSError *)error{
    self.waitingView.hidden = YES;
    NSLog(@"err:%@",error);
    [self showAlert:@"您的网络不给力哦!"];
}

//成功
- (void)netRequestFinished:(CDServiceRequest *)request
      finishedInfoToResult:(NSString *)result
              responseData:(NSData *)requestData{
    self.waitingView.hidden = YES;
    if (request==loginRequest) {
        loginReturnParser *parser = [[loginReturnParser alloc]init];
        if ([parser paserReturnCommand:requestData]) {
            [parser paserReturnData];
            if (parser.allDatas!=nil) {
                loginReturn *ret = [parser.allDatas objectAtIndex:0];
                if ([ret.result_code integerValue]==0) {
                    [self saveLoginAccount];
                    self.theAppDelegate.loginReturnBean = ret;
                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"登入成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:Nil, nil];
                    alert.tag = 1110;
                    [alert show];
                    [alert release];

                }else {
                    [self showAlert:ret.description];

                }
            }
        }
        [parser release];
        
    }
    return;
}
+(CDLoginViewController *)initInstance{
    return [[[self class] alloc]initWithNibName:NSStringFromClass([self class]) bundle:nil];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [loginRequest cancel];
    [loginRequest release];
    [_accountTextfield release];
    [_secretTextfield release];
    [_sureBtn release];
    [_resetSecretBtn release];
    [_autoLogBtn release];
    [savedPhone release];
    [savedPwd release];
    [_closeBtn release];
    [_inputView release];
    [_waitingView release];
    [_activityView release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setAccountTextfield:nil];
    [self setSecretTextfield:nil];
    [self setSureBtn:nil];
    [self setResetSecretBtn:nil];
    [self setAutoLogBtn:nil];
    
    [self setCloseBtn:nil];
    [self setInputView:nil];
    [self setWaitingView:nil];
    [self setActivityView:nil];
    [super viewDidUnload];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"登入";
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
   
    [self getSaveAccount];
    
    orignFrame = self.inputView.frame;
  
}
- (void)back:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)getSaveAccount{
        NSUserDefaults *save = [NSUserDefaults standardUserDefaults];
        self.autoLogBtn.selected =[[save objectForKey:@"autoLogin"]boolValue];
       self.accountTextfield.text =[save objectForKey:kUserName];
       self.secretTextfield.text =[save objectForKey:kPWD];
}
-(void)saveLoginAccount{
    if (self.autoLogBtn.selected) {
    NSUserDefaults *save = [NSUserDefaults standardUserDefaults];
    [save setObject:self.accountTextfield.text forKey:kUserName];
    [save setObject:self.secretTextfield.text  forKey:kPWD];
    [save setObject:[NSNumber numberWithBool:YES] forKey:@"autoLogin"];
    [save synchronize];
    }else{
        NSUserDefaults *save = [NSUserDefaults standardUserDefaults];
        [save setObject:self.accountTextfield.text forKey:kUserName];
        [save removeObjectForKey:kPWD];
        [save setObject:[NSNumber numberWithBool:NO] forKey:@"autoLogin"];
        [save synchronize];
    }
}
-(void)loginAccount:(NSString *)account withPWD:(NSString *)pwd{
    if ([self.theAppDelegate.loginReturnBean.user_name isEqualToString:account]) {
        [self showAlert:@"该账户已经登入"];
        return;
    }
    if (loginRequest==nil) {
        loginRequest =  [[CDServiceRequest alloc]initWithServiceUrl:BASEURL];
        loginRequest.delegate = self;
    }
    if ([loginRequest isExecuting]) {
        [loginRequest cancel];
    }
    loginCommand *command = [[loginCommand alloc]init];
    command.userName = account;
    command.userPwd = pwd;
    NSData *data = [command getJsonData];
    [loginRequest requestServiceUrlWithData:data];
    [command release];
    self.waitingView.hidden = NO;
    
}

-(void)keyboardShow:(NSNotification*)notification{
    
    NSDictionary* info = [notification userInfo];
    NSValue* aValue = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    
    // Get the duration of the animation.
    NSValue *animationDurationValue = [info objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:animationDuration];
    _closeBtn.hidden = NO;
    CGRect frame =  _closeBtn.frame;
  
    frame.origin.y = keyboardRect.origin.y - frame.size.height-44-20;
    _closeBtn.frame = frame;
    
    [UIView commitAnimations];
 
//    CGRect frame1 = _inputView.frame;
//    frame1.origin.y =frame.origin.y-frame1.size.height;
//    _inputView.frame =frame1;
}

-(void)keyboardHide:(NSNotification*)notification
{
     NSDictionary* info = [notification userInfo];
    NSValue *animationDurationValue = [info objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:animationDuration];
    CGRect frame =  _closeBtn.frame;
    
    frame.origin.y = 550;
    
    _closeBtn.frame = frame;
    
    //_closeKeyBtn.hidden = YES;
    
    [UIView commitAnimations];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)login{
    
    if (!self.accountTextfield.text||[_accountTextfield.text isEqualToString:@""]) {
        [self showAlert:@"请输入账号"];
        return;
    }else if (!self.secretTextfield.text||[_secretTextfield.text isEqualToString:@""]){
        [self showAlert:@"请输入密码"];
        return;
    }
    else
        {
        [self.accountTextfield resignFirstResponder];
        [self.secretTextfield resignFirstResponder];
        
        [self loginAccount:self.accountTextfield.text withPWD:self.secretTextfield.text];

        }
}

- (IBAction)sure:(UIButton *)sender {

    [self login];
}
- (IBAction)setAutologin:(UIButton *)sender {
    sender.selected = !sender.selected;
    autoLoginFlag = sender.selected;
    NSUserDefaults *save = [NSUserDefaults standardUserDefaults];
    [save setObject:[NSNumber numberWithBool:autoLoginFlag] forKey:@"autoLogin"];
    [save synchronize];
}

- (IBAction)resetSecret:(UIButton *)sender {
    registerViewController *vc = [registerViewController initInstance];
    [self.navigationController pushViewController:vc animated:YES];
    [vc release];
}

#pragma mark ---textfield delegate---
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self login];
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    return YES;
}
- (IBAction)hidenKeyBoard:(UIButton *)sender {
    
    [self.accountTextfield resignFirstResponder];
    [self.secretTextfield resignFirstResponder];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag ==1110) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}
@end
