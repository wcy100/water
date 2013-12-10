//
//  CDGuideViewController.h
//  EMPiOS
//
//  Created by liu deaming on 12-4-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface GuideViewController : UIViewController

@property(nonatomic, strong) IBOutlet UIScrollView *scroll;
@property(nonatomic, strong) NSString *baseViewClassName;


@end
