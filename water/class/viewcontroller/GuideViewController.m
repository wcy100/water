//
//  CDGuideViewController.m
//  EMPiOS
//
//  Created by liu deaming on 12-4-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GuideViewController.h"
#import "AppDelegate.h"


@interface GuideViewController ()
@end

@implementation GuideViewController
@synthesize baseViewClassName;
@synthesize scroll;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(UIImage *)scaleimage :(UIView *)theView
{
    CGRect newFrame = theView.frame;
    
    
    if(UIGraphicsBeginImageContextWithOptions != NULL)
    {
        UIGraphicsBeginImageContextWithOptions(newFrame.size, NO, 0.0);
    } else {
        UIGraphicsBeginImageContext(newFrame.size);
    }            
    
    [theView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image; 
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImageView *guide0 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"引导页1"]];
    guide0.frame = CGRectMake(0, 0, 320, UI_SCREEN_HEIGHT - UI_STATUS_BAR_HEIGHT);
   
    UIImageView *guide1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"引导页2"]];
    guide1.frame = CGRectMake(320, 0, 320, UI_SCREEN_HEIGHT - UI_STATUS_BAR_HEIGHT);
    
    UIImageView *guide2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"引导页3"]];
    guide2.frame = CGRectMake(640, 0, 320, UI_SCREEN_HEIGHT - UI_STATUS_BAR_HEIGHT);
    
    UIImageView *guide3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"引导页4"]];
    guide3.frame = CGRectMake(960, 0, 320, UI_SCREEN_HEIGHT - UI_STATUS_BAR_HEIGHT);
    
    UIImageView *guide4 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"引导页5"]];
    guide4.frame = CGRectMake(1280, 0, 320, UI_SCREEN_HEIGHT - UI_STATUS_BAR_HEIGHT);
    
    UIImageView *guide5 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"引导页6"]];
    guide5.frame = CGRectMake(1600, 0, 320, UI_SCREEN_HEIGHT - UI_STATUS_BAR_HEIGHT);
    

    
    UIViewController *controller = [[NSClassFromString(baseViewClassName) alloc] initWithNibName:baseViewClassName bundle:nil];
	controller.view.frame = CGRectMake(1920, 0, 320, UI_SCREEN_HEIGHT - UI_STATUS_BAR_HEIGHT);
    UIImage *startImage = [self scaleimage:controller.view];
    
    UIImageView *guide6 = [[UIImageView alloc] initWithImage:startImage];
    int orignY = 64;
    
    if( NSOrderedSame == [baseViewClassName compare:@"RootViewController"] )
    {
        orignY = 0;
    }
    
    
    guide6.frame = CGRectMake(1920, orignY, 320, UI_SCREEN_HEIGHT - UI_STATUS_BAR_HEIGHT);
    
    

	if( NSOrderedSame != [baseViewClassName compare:@"RootViewController"] )
    {
    	UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        titleLabel.text = @"设置";
        UIImageView *imv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"top_bg_4.0.png"]];
        imv.frame = CGRectMake(1920, orignY - 44, 320, 44);
        imv.contentMode = UIViewContentModeScaleToFill;
        [scroll addSubview:imv];
        [imv release];
        
        titleLabel.frame = CGRectMake(1980, orignY - 44, 200, 44);
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.font = [UIFont boldSystemFontOfSize:21];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [scroll addSubview:titleLabel];
        [titleLabel release];
    }
    

    [scroll addSubview:guide0];
    [scroll addSubview:guide1];
    [scroll addSubview:guide2];
    [scroll addSubview:guide3];
    [scroll addSubview:guide4];
    [scroll addSubview:guide5];
    [scroll addSubview:guide6];
    
    scroll.contentSize = CGSizeMake(320*7, UI_SCREEN_HEIGHT - UI_STATUS_BAR_HEIGHT);
    
    
    [guide0 release];
    [guide1 release];
    [guide2 release];
    [guide3 release];
    [guide4 release];
    [guide5 release];
    [guide6 release];
    
    
    
    
//	[scroll insertSubview:controller.view atIndex:0];
	
	
    [controller release];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)theScrollView {
	
    CGPoint offset = scroll.contentOffset;
	
	if (offset.x == 1920) {
        
        if( NSOrderedSame == [baseViewClassName compare:@"RootViewController"] )
        {
            AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
            
          //  appDelegate.window.rootViewController = appDelegate.tabBarViewController;
            [appDelegate.window makeKeyAndVisible];
        }
        
        [self.view removeFromSuperview];
	}
}

@end
