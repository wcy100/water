//
//  registerViewController.m
//  JXshop
//
//  Created by yu on 13-5-24.
//  Copyright (c) 2013年 cd. All rights reserved.
//

#import "registerViewController.h"
#import "CDServiceRequest.h"
#import "loginCommand.h"
#import "loginReturn.h"
#import "loginReturnParser.h"
@interface registerViewController ()<NetWebServiceRequestDelegate>
{
    CDServiceRequest *registerService;
    CDServiceRequest *loginRequest;
}
@end

@implementation registerViewController
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
    if (request==registerService) {
        loginReturnParser *parser = [[loginReturnParser alloc]init];
        if ([parser paserReturnCommand:requestData]) {
            [parser paserReturnData];
            if (parser.allDatas!=nil) {
                loginReturn *ret = [parser.allDatas objectAtIndex:0];
                if ([ret.result_code integerValue]==0) {
                    // [self showAlert:@"注册成功"];
                    [self loginAccount:_accountTextView.text withPWD:_PwdTextField.text];
                    }
                else {
                    [self showAlert:ret.description];
                    
                }
            }
        }
        [parser release];
        
    }else
        if (request==loginRequest) {
            loginReturnParser *parser = [[loginReturnParser alloc]init];
            if ([parser paserReturnCommand:requestData]) {
                [parser paserReturnData];
                if (parser.allDatas!=nil) {
                    loginReturn *ret = [parser.allDatas objectAtIndex:0];
                    if ([ret.result_code integerValue]==0) {
                        self.theAppDelegate.loginReturnBean = ret;
                        [self saveLoginAccount];
                        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"注册成功，已经登入" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:Nil, nil];
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

+(registerViewController *)initInstance{
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"注册";
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
    _contentScroll.contentSize = CGSizeMake(320, 550);
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag ==1110) {
         [self.navigationController popViewControllerAnimated:YES];
    }
    
}
-(void)saveLoginAccount{
    
        NSUserDefaults *save = [NSUserDefaults standardUserDefaults];
        [save setObject:self.accountTextView.text forKey:kUserName];
        [save setObject:self.PwdTextField.text  forKey:kPWD];
        [save setObject:[NSNumber numberWithBool:YES] forKey:@"autoLogin"];
        [save synchronize];
    
}
- (void)back:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    [self hiddenTab];
}
- (void)dealloc {
    [registerService cancel];
    [registerService release];
    [loginRequest cancel];
    [loginRequest release];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [_closeKeyBtn release];
    [_contentScroll release];
    [_waitingView release];
    [_accountTextView release];
    [_PwdTextField release];
    [_surePwdTextField release];
    [_registerBtn release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setCloseKeyBtn:nil];
    [self setContentScroll:nil];
    [self setWaitingView:nil];
    [self setAccountTextView:nil];
    [self setPwdTextField:nil];
    [self setSurePwdTextField:nil];
    [self setRegisterBtn:nil];
    [super viewDidUnload];
}
-(void)loginAccount:(NSString *)account withPWD:(NSString *)pwd{
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
-(void)registerAccount:(NSString *)account withPWD:(NSString *)pwd{
    if (registerService==nil) {
        registerService =  [[CDServiceRequest alloc]initWithServiceUrl:BASEURL];
        registerService.delegate = self;
    }
    if ([registerService isExecuting]) {
        [registerService cancel];
    }
    loginCommand *command = [[loginCommand alloc]init];
    command.requestService = @"Register";
    command.userName = account;
    command.userPwd = pwd;
    NSData *data = [command getJsonData];
    [registerService requestServiceUrlWithData:data];
    [command release];
    self.waitingView.hidden = NO;
    
}
- (IBAction)closeKey:(UIButton *)sender {
    [self.accountTextView resignFirstResponder];
    [self.PwdTextField resignFirstResponder];
    [self.surePwdTextField resignFirstResponder];
}
- (IBAction)registerAction:(UIButton *)sender {
    if (!_accountTextView.text||[_accountTextView.text isEqualToString:@""]) {
        [self showAlert:@"用户名不能为空"];
        return;
    }else if (!_PwdTextField.text||[_PwdTextField.text isEqualToString:@""]){
        [self showAlert:@"密码不能为空"];
        return;
    }else if (!_surePwdTextField.text||[_surePwdTextField.text isEqualToString:@""]){
        [self showAlert:@"请再次确认密码"];
        return;
    }else if (![_surePwdTextField.text isEqualToString:_PwdTextField.text]){
        [self showAlert:@"两次输入的密码不一致"];
        return;
    }
    [self registerAccount:_accountTextView.text withPWD:_PwdTextField.text];
    
}

- (IBAction)lookUp:(UIButton *)sender {
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
    _closeKeyBtn.hidden = NO;
    CGRect frame =  self.closeKeyBtn.frame;
  
    frame.origin.y = keyboardRect.origin.y - frame.size.height-44-20;
  
    _closeKeyBtn.frame = frame;
    
    
    [UIView commitAnimations];

       [_contentScroll setContentOffset:CGPointMake(0, 25) animated:YES];
}

-(void)keyboardHide:(NSNotification*)notification
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.2];
    CGRect frame =  _closeKeyBtn.frame;
    
    frame.origin.y = 550;
    
    _closeKeyBtn.frame = frame;
    
    //_closeKeyBtn.hidden = YES;
    
    [UIView commitAnimations];

      [_contentScroll setContentOffset:CGPointMake(0,0) animated:YES];
}

@end
