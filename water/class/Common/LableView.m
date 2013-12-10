//
//  LableView.m
//  LiveByTouch
//
//  Created by hao.li on 11-7-26.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LableView.h"


@implementation LableView
@dynamic lblDelegate;
@synthesize record;
@synthesize object,recordId;
- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code.
    }
	
    return self;
}

- (id)initWithString:(NSString*)str FontSize:(int)fontSize{
	CGRect frame = CGRectMake(0, 0, [str length]*fontSize, [str length]*fontSize);
	self = [super initWithFrame:frame];
    if (self) {
		
        // Initialization code.
		UIFont *font = [UIFont fontWithName:@"Arial" size:fontSize];
		CGSize size = CGSizeMake(320, 2000);
		CGSize lablesize = [str sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];//UILineBreakModeWordWrap];
		[self setFont:[UIFont systemFontOfSize:fontSize]];
		frame.size.width = lablesize.width;
		frame.size.height = lablesize.height;
		self.frame = frame;
		self.backgroundColor = [UIColor clearColor];
		
		//text
		self.numberOfLines = 1;
		self.lineBreakMode = NSLineBreakByTruncatingMiddle;//UILineBreakModeMiddleTruncation;
		self.text = str;
		[self sizeToFit];
    }
	
    return self;
}

- (id)initWithFrameAndMore:(CGRect)frame String:(NSString*)str FontSize:(int)fontSize{
	self = [super initWithFrame:CGRectZero];
    if (self) {
		
        // Initialization code.
		UIFont *font = [UIFont fontWithName:@"Arial" size:fontSize];
		CGSize size = CGSizeMake(320, 2000);
		CGSize lablesize = [str sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping ];
		[self setFont:[UIFont systemFontOfSize:fontSize]];
		frame.size.width = lablesize.width;
		frame.size.height = lablesize.height;
		self.frame = frame;
		self.backgroundColor = [UIColor clearColor];
		
		//text
		self.numberOfLines = 1;
		self.lineBreakMode = NSLineBreakByTruncatingMiddle;// UILineBreakModeMiddleTruncation;
		self.text = str;
		[self sizeToFit];
    }
	
    return self;
}

-(void) setLblDelegate:(id <ClickedDelegate>)delegate{
	super.userInteractionEnabled = YES;
	lblDelegate = delegate;
}

-(void) setRecord:(NSString *)sid{
	if (record != sid) {
		[sid retain];
		[record release];
		record = sid;
	}
}


-(void) setFont:(UIFont *)ft{
	super.font = ft;
	[self setText:self.text];
}

- (int) getWidth{
	return self.frame.size.width;
}
- (int) getHeigth{
	return self.frame.size.height;
}
- (int) getX{
	return self.frame.origin.x;
}
- (int) getY{
	return self.frame.origin.y;
}
- (void) setText:(NSString *)t{
	super.numberOfLines = 1;
	super.lineBreakMode =NSLineBreakByTruncatingMiddle;// UILineBreakModeMiddleTruncation;
	super.text = t;
	[super sizeToFit];
}
- (void) setContent:(NSString *)c{
	super.numberOfLines = 0;
	super.text = c;
	[super sizeToFit];
}
- (void) setPosition:(CGPoint)point{
	self.frame = CGRectMake(point.x, point.y, [self getWidth], [self getHeigth]);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *aTouch = [touches anyObject];
	
	if (aTouch.tapCount == 1) {
        [NSObject cancelPreviousPerformRequestsWithTarget:self];		
		
    }
	
} 


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *theTouch = [touches anyObject];
	
	if(theTouch.tapCount == 1 || theTouch.tapCount==0) //主界面只接受单击
	{
		[NSObject cancelPreviousPerformRequestsWithTarget:self];
		CGPoint touchPoint = [theTouch locationInView:self];	
		if (touchPoint.x>0&&touchPoint.y>0) {
			if (lblDelegate != nil) {
				[lblDelegate someLikeButton:self];
			}
		}
		
	}
}
-(void) dealloc{
	[record release];
	record = nil;
	[super dealloc];
}
@end
