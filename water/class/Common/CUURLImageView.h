//
//  CUURLImageView.h
//  HuaTaiZhangLe
//
//  Created by Yan Minghao on 10-1-11.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIImage-Extensions.h"


@interface CUURLImageView : UIImageView {
	UIActivityIndicatorView *indicator;
	
	BOOL indicatorNotCenter;
	BOOL animated; 
}
@property (nonatomic, assign) BOOL ForTable;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, assign) NSURL *imageURL;

@property(nonatomic,readwrite)BOOL indicatorNotCenter;

@property(nonatomic,retain) UIActivityIndicatorView *indicator;
@property(nonatomic) BOOL isNotShowIndicator;
@property (nonatomic, assign)  BOOL animated; 

//- (id)initWithCoder:(NSCoder *)decoder;
- (id)initWithImageURL:(NSURL *)url ;
- (id)initWithImageURL:(NSURL *)url :(BOOL)ISanimated;
@end
