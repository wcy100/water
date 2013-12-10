//
//  BaseViewController.m
//  JXshop
//
//  Created by yu on 13-5-2.
//  Copyright (c) 2013年 cd. All rights reserved.
//

#import "BaseViewController.h"
#import "CDLoginViewController.h"
#import "BDKNotifyHUD.h"
@interface BaseViewController ()
{
    BOOL tabHiden;
    BDKNotifyHUD *notify;
}

@end

@implementation BaseViewController
@synthesize backBtn,rightBtn,theAppDelegate;
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
    theAppDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    // Create a custom back button
    [self setBackButtonImage:[UIImage imageNamed:@"top_后退.png"]];
    //[self setBackButtonText:@"返回"];
    [self setNavBackGround:[UIImage imageNamed:@"top.png"]];
//    [self setTitleImage:[UIImage imageNamed:@"navigationBarLogo.png"]];
    [self setRightButtonImage:nil];
    //    [self setRightButtonText:@"出门"];
    
    
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [notify removeFromSuperview];
}
-(void)hiddenTab{

    tabHiden = YES;
    
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
  //  [self hideTabBar:delegate.tabBarViewController];
}
-(void)showTab{

    tabHiden = NO;
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
//    [self showTabBar:delegate.tabBarViewController];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setRightButtonText:(NSString *)text{

//    UIButton *btn = (UIButton*)self.navigationItem.rightBarButtonItem.customView;
    // Set the text on the button
    [self.rightBtn setTitle:text forState:UIControlStateNormal];
}
-(void)setRightButtonImage:(UIImage *)image{

    UIButton* backButton = [self ButtonWith:image highlight:nil leftCapWidth:14.0];
    self.rightBtn = backButton;
    [backButton addTarget:self action:@selector(right:) forControlEvents:UIControlEventTouchUpInside];
    backButton.titleLabel.textColor = [UIColor colorWithRed:254.0/255.0 green:239.0/255.0 blue:218.0/225.0 alpha:1];
  
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:backButton] autorelease];
}
- (void)setBackButtonText:(NSString *)text {
//    CustomNavigationBar* customNavigationBar = (CustomNavigationBar*)self.navigationController.navigationBar;
//    // [customNavigationBar setText:text onBackButton:(UIButton*)self.navigationItem.leftBarButtonItem.customView];
//     [customNavigationBar setText:text onBackButton:self.backBtn];
    [self.backBtn setTitle:text forState:UIControlStateNormal];

}
-(void)setBackButtonImage:(UIImage *)image{
    // CustomNavigationBar* customNavigationBar = (CustomNavigationBar*)self.navigationController.navigationBar;

    UIButton* backButton = [self ButtonWith:image highlight:nil leftCapWidth:14.0];
    self.backBtn = backButton;
    [backButton addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    backButton.titleLabel.textColor = [UIColor colorWithRed:254.0/255.0 green:239.0/255.0 blue:218.0/225.0 alpha:1];
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:backButton] autorelease];
}

-(void)setNavBackGround:(UIImage *)image{
    // Get our custom nav bar
    CustomNavigationBar* customNavigationBar = (CustomNavigationBar*)self.navigationController.navigationBar;
    
    // Set the nav bar's background
    [customNavigationBar setBackgroundWith:image];
}
-(void)setTitleImage:(UIImage *)image{
    UIImage* titleImage = image;
    UIView* titleView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,titleImage.size.width, self.navigationController.navigationBar.frame.size.height)];
    UIImageView* titleImageView = [[UIImageView alloc] initWithImage:titleImage];
    [titleView addSubview:titleImageView];
    titleImageView.center = titleView.center;
    CGRect titleImageViewFrame = titleImageView.frame;
    // Offset the logo up a bit
    titleImageViewFrame.origin.y = titleImageViewFrame.origin.y + 3.0;
    titleImageView.frame = titleImageViewFrame;
    self.navigationItem.titleView = titleView;
    [titleView release];
    [titleImageView release];
}
-(UIButton*) ButtonWith:(UIImage*)backButtonImage highlight:(UIImage*)backButtonHighlightImage leftCapWidth:(CGFloat)capWidth
{
    // store the cap width for use later when we set the text

    //  UIEdgeInsets inset = UIEdgeInsetsMake(0, capWidth, 0, capWidth);
    // Create stretchable images for the normal and highlighted states
    UIImage* buttonImage = backButtonImage;//[backButtonImage resizableImageWithCapInsets:inset];
    
    UIImage* buttonHighlightImage =backButtonHighlightImage; //[backButtonHighlightImage resizableImageWithCapInsets:inset];
    
    // Create a custom button
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    // Set the title to use the same font and shadow as the standard back button
    button.titleLabel.font = [UIFont boldSystemFontOfSize:[UIFont smallSystemFontSize]];
    button.titleLabel.textColor = [UIColor whiteColor];
    button.titleLabel.shadowOffset = CGSizeMake(0,-1);
    button.titleLabel.shadowColor = [UIColor darkGrayColor];
    
    // Set the break mode to truncate at the end like the standard back button
    button.titleLabel.lineBreakMode =NSLineBreakByTruncatingTail;
    
    // Inset the title on the left and right
    button.titleEdgeInsets = UIEdgeInsetsMake(0, 6.0, 0, 3.0);
    
    // Make the button as high as the passed in image
    button.frame = CGRectMake(0, 0, 44, 44);
    
    // Just like the standard back button, use the title of the previous item as the default back text
    // [self setText:self.topItem.title onBackButton:button];
    
    // Set the stretchable images as the background for the button
    [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [button setBackgroundImage:buttonHighlightImage forState:UIControlStateHighlighted];
    [button setBackgroundImage:buttonHighlightImage forState:UIControlStateSelected];
    
    // Add an action for going back
    //  [button addTarget:self action:@selector(right:) forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}
- (void)back:(UIButton *)sender
{
}
-(void)right:(UIButton *)sender{
    
}
// Method implementations
- (void)hideTabBar:(UITabBarController *) tabbarcontroller
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    
    for(UIView *view in tabbarcontroller.view.subviews)
        {
        if([view isKindOfClass:[UITabBar class]])
            {
            [view setFrame:CGRectMake(view.frame.origin.x, UI_SCREEN_HEIGHT, view.frame.size.width, view.frame.size.height)];
            }
        else
            {
            [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, UI_SCREEN_HEIGHT)];
            }
        }
    
    [UIView commitAnimations];
}

- (void)showTabBar:(UITabBarController *) tabbarcontroller
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    for(UIView *view in tabbarcontroller.view.subviews)
        {
        NSLog(@"%@", view);
        
        if([view isKindOfClass:[UITabBar class]])
            {
            [view setFrame:CGRectMake(view.frame.origin.x, UI_SCREEN_HEIGHT -49, view.frame.size.width, view.frame.size.height)];
            
            }
        else
            {
            [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, UI_SCREEN_HEIGHT -49)];
            }
        }
    
    [UIView commitAnimations]; 
}
-(void)showAlert:(NSString *)message{
//    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
//    alert.tag = 12580;
//    [alert show];
//    [alert release];
    [self displayNotification:[UIImage imageNamed:@"feedback_pop_failed.png"]:message];
}
-(void)showSuccessAlert:(NSString *)message{
    [self displayNotification:[UIImage imageNamed:@"feedback_pop_successful.png"]:message];
}
- (void)displayNotification:(UIImage *)notifiImage :(NSString *)notificationText{
    if (notify.isAnimating)
         [notify removeFromSuperview];
    {
    notify = [BDKNotifyHUD notifyHUDWithImage:notifiImage text:notificationText];
    notify.center = CGPointMake(self.view.center.x, self.view.center.y - 40);
    
    [self.view addSubview:notify];
    [notify presentWithDuration:1.0f speed:0.5f inView:self.view completion:^{
        [notify removeFromSuperview];
    }];
    }
    
}
-(BOOL)isUserLogin{
    
    if (theAppDelegate.loginReturnBean) {
        if (theAppDelegate.loginReturnBean.user_id && theAppDelegate.loginReturnBean.user_name) {
            return  YES;
        }
    }
    CDLoginViewController *loginVc = [CDLoginViewController initInstance ];
    [self.navigationController pushViewController:loginVc animated:YES];
    [loginVc release];
  
    return NO;
}
- (void)dealloc {
    [notify removeFromSuperview];
    [backBtn release];
    [rightBtn release];
    [super dealloc];
}
- (void)viewDidUnload {

    [super viewDidUnload];
}
@end
