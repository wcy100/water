//
//  CustomNavigationBar.h
//  CustomBackButton
//  JXshop
//
//  Created by yu on 13-5-2.
//  Copyright (c) 2013年 cd. All rights reserved.
//

#define MAX_BACK_BUTTON_WIDTH 160.0
@interface CustomNavigationBar : UINavigationBar
{
  UIImageView *navigationBarBackgroundImage;
  CGFloat backButtonCapWidth;
  IBOutlet UINavigationController* navigationController;
}

@property (nonatomic, retain) UIImageView *navigationBarBackgroundImage;
@property (nonatomic, retain) IBOutlet UINavigationController* navigationController;

-(void) setBackgroundWith:(UIImage*)backgroundImage;
-(void) clearBackground;
-(UIButton*) backButtonWith:(UIImage*)backButtonImage highlight:(UIImage*)backButtonHighlightImage leftCapWidth:(CGFloat)capWidth;
-(void) setText:(NSString*)text onBackButton:(UIButton*)backButton;
-(void)hidenBackButton:(UIButton*)backButton hiden:(BOOL)hiden;
@end
