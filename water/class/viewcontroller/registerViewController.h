//
//  registerViewController.h
//  JXshop
//
//  Created by yu on 13-5-24.
//  Copyright (c) 2013年 cd. All rights reserved.
//

#import "BaseViewController.h"

@interface registerViewController : BaseViewController<UITextFieldDelegate>
@property (retain, nonatomic) IBOutlet UIButton *closeKeyBtn;
- (IBAction)closeKey:(UIButton *)sender;
@property (retain, nonatomic) IBOutlet UIScrollView *contentScroll;
@property (retain, nonatomic) IBOutlet UIView *waitingView;
@property (retain, nonatomic) IBOutlet UITextField *accountTextView;
@property (retain, nonatomic) IBOutlet UITextField *PwdTextField;
@property (retain, nonatomic) IBOutlet UITextField *surePwdTextField;
- (IBAction)registerAction:(UIButton *)sender;
- (IBAction)lookUp:(UIButton *)sender;
+(registerViewController *)initInstance;
@property (retain, nonatomic) IBOutlet UIButton *registerBtn;
@end
