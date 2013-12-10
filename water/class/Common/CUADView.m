//
//  CUADView.m
//  NewLuckyMedia
//
//  Created by liujc on 12-11-29.
//
//

#import "CUADView.h"

#import "CUURLImageView.h"

#import "touchButton.h"
#define INDEXWIDTH 7
@interface CUADView ()
{
    NSInteger timeCount;
    UIScrollView *scrollView;
}
@end
@implementation CUADView
@synthesize imgArray,imgViewArray;
@synthesize delegate;
@synthesize thumbnailPickerView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [UIColor clearColor];
        UIImageView *backGround = [[UIImageView alloc]initWithFrame:self.frame];
        backGround.image = [UIImage imageNamed:@"首页_轮换图片边框.png"];
        [self addSubview:backGround];
        [backGround release];
        CGRect frame = self.frame;
//        frame.size.height -=30;

        

//        frame = CGRectMake(0.0, frame.size.height-30, frame.size.width, 30.0);
//        thumbnailPickerView = [[ThumbnailPickerView alloc]initWithFrame:frame];
//        thumbnailPickerView.delegate = self;
//        thumbnailPickerView.dataSource = self;
//        [self addSubview:thumbnailPickerView];
        
 
        frame.origin.y += frame.size.height/3;
        _pageControl = [[UIPageControl alloc] initWithFrame:frame];
        _pageControl.userInteractionEnabled = FALSE;
        // [_pageControl addTarget:self action:@selector(pageAction:) forControlEvents:UIControlEventTouchUpInside];
        _pageControl.backgroundColor = [UIColor clearColor];
        _pageControl.alpha = 0.8;
        _pageControl.hidesForSinglePage = YES;
        _pageControl.numberOfPages = 1;
        _pageControl.currentPage = 0;
        [self addSubview:_pageControl];
   
        if (!imgArray) {
            imgArray = [[NSMutableArray alloc]init];
            
        }
        if (!imgViewArray) {
            imgViewArray = [[NSMutableArray alloc]init];
        }
    }
    return self;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

- (void)dealloc
{
    if ([theTimer isValid]) 
    [theTimer invalidate];
   
    [imgViewArray release];
    //  [thumbnailPickerView release];
    [imgArray release];
    [super dealloc];
}


-(void)setup:(NSInteger)type{

}



-(void)freshScrollView
{
    timeCount  = 0;
    int count = [imgArray count] ;

    _pageControl.numberOfPages = count;
    if (scrollView) {
        [scrollView removeFromSuperview];
        [scrollView release];
        scrollView =nil;
    }
    if (!scrollView) {
    scrollView = [[UIScrollView alloc] initWithFrame:self.frame];
    scrollView.backgroundColor = [UIColor clearColor];
    scrollView.delegate = self ;
    scrollView.showsHorizontalScrollIndicator = FALSE ;
    scrollView.pagingEnabled = YES;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:scrollView];
    } 
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width*count, scrollView.frame.size.height);
    
    for (int i=0 ; i<count; i++) {
        CGRect frame = CGRectMake(scrollView.frame.size.width*i, 0,scrollView.frame.size.width, scrollView.frame.size.height) ;
        frame.origin.x +=INDEXWIDTH/2;
        frame.origin.y +=3;
        frame.size.width -=INDEXWIDTH;
        frame.size.height-=10+3;
        NSURL *imageurl = [NSURL URLWithString:[imgArray objectAtIndex:i]];
        CUURLImageView *urlImageView = [[CUURLImageView alloc] initWithImageURL:imageurl];
        [imgViewArray addObject:urlImageView];
        
        urlImageView.indicatorNotCenter = NO ;
        urlImageView.frame = frame;

        [scrollView addSubview:urlImageView ];
        [urlImageView release];

        touchButton *button = [[touchButton alloc] initWithFrame:frame];
        [button addTarget:self action:@selector(turnBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i ; 
        [scrollView addSubview:button];
        [button release];
    }
    
    scrollView.pagingEnabled = TRUE ;
    scrollView.scrollEnabled = TRUE ;
    
    //  [self.thumbnailPickerView reloadData];
    if ([theTimer isValid]) {
        [theTimer invalidate]; 
    }
    if (imgArray.count ==1) {
        return;
    }
    theTimer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(scrollTimer) userInfo:nil repeats:YES];
}



//定时滚动
-(void)scrollTimer{
    timeCount =_pageControl.currentPage +1;
    BOOL isanimate = YES;
    if (timeCount == imgArray.count) {
        timeCount = 0;
        isanimate = NO;
    }
    CGRect toFrame = CGRectMake( timeCount * (scrollView.frame.size.width), 0, scrollView.frame.size.width, scrollView.frame.size.height);
    NSLog(@"xxxx:%f",toFrame.origin.x);
    [scrollView scrollRectToVisible:toFrame animated:isanimate];
}
-(IBAction)turnBtnClick:(id)sender
{
    int index = ((UIButton *)sender).tag ;
    if (self.delegate !=nil&& [self.delegate respondsToSelector:@selector(turnBtnClick:)]) {
        [self.delegate turnBtnClick:sender];
    }
}


//滚动条滚动函数
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    ctr = NO;
}
- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    if (sender ==scrollView && !ctr) {
    
    CGFloat pageWidth = scrollView.frame.size.width;
    NSInteger nPage = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
     _pageControl.currentPage = nPage;
        // [self.thumbnailPickerView setSelectedIndex:nPage animated:YES usedelegate:NO];
        //  NSLog(@"%d",_pageControl.numberOfPages);

    }
    
}


- (void)_updateUIWithSelectedIndex:(NSUInteger)index
{
    CGPoint point = CGPointMake(index*320, 0);
    [scrollView setContentOffset:point animated:YES];
    ctr = YES;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    if ([theTimer isValid]) {
        [theTimer invalidate];
        theTimer = [NSTimer scheduledTimerWithTimeInterval:6 target:self selector:@selector(scrollTimer) userInfo:nil repeats:YES];
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];

}
#pragma mark - ThumbnailPickerView data source

- (NSUInteger)numberOfImagesForThumbnailPickerView:(ThumbnailPickerView *)thumbnailPickerView
{
    return [imgArray count];
}

- (NSURL *)thumbnailPickerView:(ThumbnailPickerView *)thumbnailPickerView imageAtIndex:(NSUInteger)index
{
    NSURL *imageurl = [self.imgArray objectAtIndex:index];
     usleep(10*1000);
    return imageurl;
}

#pragma mark - ThumbnailPickerView delegate

- (void)thumbnailPickerView:(ThumbnailPickerView *)thumbnailPickerView didSelectImageWithIndex:(NSUInteger)index
{
    [self _updateUIWithSelectedIndex:index];
}
@end
