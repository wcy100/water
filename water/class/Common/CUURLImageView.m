//
//  CUURLImageView.m
//  HuaTaiZhangLe
//
//  Created by Yan Minghao on 10-1-11.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CUURLImageView.h"
#import "UIImageView+WebCache.h"
#import <QuartzCore/QuartzCore.h>
@interface CUURLImageView()
{
   
}
- (void)startRetrieve:(NSURL *)url;

@end

@implementation CUURLImageView
@synthesize  animated = _animated;
@synthesize indicatorNotCenter;

@synthesize indicator;
@synthesize isNotShowIndicator;
@synthesize ForTable,title;
//- (id)initWithFrame:(CGRect)frame {
//    if (self = [super initWithFrame:frame]) {
//        
//    }
//    return self;
//}
//
//-(id)initWithImage:(UIImage *)image
//{
//    if (self = [super initWithImage:image]) {
//        
//    }
//    return self;
//}
//-(id)init
//{
//    if (self = [super init]) {
//        
//    }
//    return self;
//}
//
//- (id)initWithCoder:(NSCoder *)decoder {
//    if (self = [super initWithCoder:decoder]) {
//        // Initialization code
//		receivedData = [[NSMutableData alloc] init];
//    }
//    return self;
//}

- (id)initWithImageURL:(NSURL *)url {
	if (self = [super init]) {
        self.isNotShowIndicator = NO;
		[self startRetrieve:url];
	}
	return self;
}
- (id)initWithImageURL:(NSURL *)url :(BOOL)ISanimated{
    
    if (self = [super init]) {
        self.isNotShowIndicator = NO;
        _animated = ISanimated;
		[self startRetrieve:url];
	}
	return self;
}
- (void)dealloc {
    [title release];
    [self stopIndicator];
    [super dealloc];
}



#pragma mark Accessor methods
- (void)setImageURL:(NSURL *)url {
	
	[self startRetrieve:url];
}

- (NSURL *)imageURL {
	return nil;
}

#pragma mark Private methods
- (void)startRetrieve:(NSURL *)url {
//	if (nil != url && self.image == nil) {
    if (url==nil) {
         [self setImage:[UIImage imageNamed:@"商铺图片边框1.png"]];
        if (self.ForTable) {
           UIImageView* thebound = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"商铺展示框.png"]];
            CGRect frame = self.frame;
            frame.origin.x=-5;
            frame.origin.y=-5;
            frame.size.height+=10;
            frame.size.width+=10;
            thebound.frame = frame;
            frame.origin.x +=10;
            frame.origin.y = frame.size.height - 30-3;
            frame.size.height = 20;
            frame.size.width -=25;
          UILabel*  nameLab = [[UILabel alloc]initWithFrame:frame];
            nameLab.text = self.title;
            nameLab.backgroundColor = [UIColor clearColor];
            nameLab.font = [UIFont systemFontOfSize:10];
            nameLab.textColor = [UIColor whiteColor];
            [nameLab setAdjustsFontSizeToFitWidth:YES];
            [nameLab setMinimumFontSize:5];
            [self addSubview:thebound];
            [thebound release];
            [self addSubview:nameLab];
            [nameLab release];
        }

    }else
    if (nil != url ) {

		indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        indicator.tag = -10 ; //add
		indicator.hidesWhenStopped = YES;
		indicator.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin |
		UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
		CGRect rect = indicator.frame;
		rect.origin.x = (self.frame.size.width - rect.size.width) / 2;
		rect.origin.y = (self.frame.size.height - rect.size.height) / 2;
		if ( indicatorNotCenter ) {
			rect.origin.x = self.frame.size.width - rect.size.width - 5;
			rect.origin.y = self.frame.size.height - rect.size.height - 5;
		}
		
		indicator.frame = rect;
        if(!self.isNotShowIndicator)
            [self addSubview:indicator];
		indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
		indicator.hidesWhenStopped = YES;
		[indicator startAnimating];
        UIImageView *thebound=Nil;
        UILabel *nameLab = Nil;
        if (self.ForTable) {
        thebound = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"商铺展示框.png"]];
        CGRect frame = self.frame;
        frame.origin.x=-5;
        frame.origin.y=-5;
        frame.size.height+=10;
        frame.size.width+=10;
        thebound.frame = frame;
            frame.origin.x +=10;
            frame.origin.y = frame.size.height - 30-3;
            frame.size.height = 20;
            frame.size.width -=25;
            nameLab = [[UILabel alloc]initWithFrame:frame];
            nameLab.text = self.title;
            nameLab.backgroundColor = [UIColor clearColor];
            nameLab.font = [UIFont systemFontOfSize:10];
            nameLab.textColor = [UIColor whiteColor];
            [nameLab setAdjustsFontSizeToFitWidth:YES];
          //  [nameLab setMinimumFontSize:5];
        }
        [self setImageWithURL:url
                     placeholderImage:[UIImage imageNamed:@"商铺图片边框1.png"]
                              success:^(UIImage *image, BOOL cached)
         {
         // do something with image
         [self stopIndicator];
  
         if (self&&_animated&&!cached) {
             CATransition *transtion = [CATransition animation];
             transtion.duration = 0.5;
             [transtion setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
             [transtion setType:@"oglFlip"];//@"cube",@"oglFlip" ,kCATransitionFade,
             
             [transtion setSubtype:kCATransitionFromRight];
             
             [self.layer addAnimation:transtion forKey:@"transtionKey"];
             
             [self setImage:image];
          
         }
         if (self.ForTable) {
             [self addSubview:thebound];
             [thebound release];
             [self addSubview:nameLab];
             [nameLab release];
         }
         }
                      failure:^(NSError *error){
                          [self stopIndicator];
                          if (self.ForTable) {
                              [self addSubview:thebound];
                              [thebound release];
                              [self addSubview:nameLab];
                              [nameLab release];
                          }
                      }];
	}
}

-(void)stopIndicator{
    if (indicator!=nil) {
    [indicator stopAnimating];
    [indicator removeFromSuperview];
    [indicator release];
    indicator = nil;
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [[self nextResponder] touchesBegan:touches withEvent:event];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesMoved:touches withEvent:event];
    [[self nextResponder] touchesMoved:touches withEvent:event];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches withEvent:event];
    [[self nextResponder] touchesEnded:touches withEvent:event];
}
@end
