//
//  LableView.h
//  LiveByTouch
//
//  Created by hao.li on 11-7-26.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Global.h"

@interface LableView : UILabel {
	id<ClickedDelegate> lblDelegate;
	NSString *record;//记录字符串
	int recordId;//记录id
	id object;
}
@property(assign) id<ClickedDelegate> lblDelegate;
@property(nonatomic,retain) NSString *record;
@property(nonatomic,retain) id object;
@property(nonatomic) int recordId;

- (id)initWithString:(NSString*)str FontSize:(int)fontSize;

- (id)initWithFrameAndMore:(CGRect)frame String:(NSString*)str FontSize:(int)fontSize;

- (int) getWidth;
- (int) getHeigth;
- (int) getX;
- (int) getY;

- (void) setText:(NSString *)t;
- (void) setContent:(NSString *)c;
- (void) setPosition:(CGPoint)point;

@end
