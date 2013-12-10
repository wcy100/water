//
//  CUADView.h
//  NewLuckyMedia
//
//  Created by liujc on 12-11-29.
//
//

#import <UIKit/UIKit.h>
#import "ThumbnailPickerView.h"

@interface CUADView : UIView<UIScrollViewDelegate,ThumbnailPickerViewDelegate,ThumbnailPickerViewDataSource>
{
    NSTimer *theTimer;
    NSMutableArray *imgArray ;

    
    id delegate ;
    
    UIPageControl * _pageControl;
    
    BOOL ctr;
}
@property (nonatomic, retain) ThumbnailPickerView *thumbnailPickerView;
@property (nonatomic, retain)NSMutableArray *imgArray ;
@property (nonatomic, retain)NSMutableArray *imgViewArray ;
@property (nonatomic, assign)id delegate ;
-(void)freshScrollView;
-(void)setup:(NSInteger)type ;

@end
