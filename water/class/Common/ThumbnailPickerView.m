//
//  ThumbnailPickerView.m
//  ThumbnailPickerView
//
//  Created by Dominik Kapusta on 11-12-20.
//  Copyright (c) 2011 Dominik Kapusta.
//
//  Latest code can be found on GitHub: https://github.com/ayoy/ThumbnailPickerView
// 
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
// 
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
// 
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "ThumbnailPickerView.h"
#import "CUURLImageView.h"
#define MinWidth 25
CGSize kThumbnailSize        = {25, 20};
CGSize kBigThumbnailSize     = {36, 25};
 NSUInteger kThumbnailSpacing = 1;

static const NSUInteger kTagOffset = 100;
static const NSUInteger kBigThumbnailTagOffset = 1000;

@interface ThumbnailPickerView()
- (CUURLImageView *)_createThumbnailImageViewWithSize:(CGSize)size;
- (void)_setup;
- (void)_updateSelectedIndexForTouch:(UITouch *)touch fineGrained:(BOOL)fineGrained;
- (void)_updateBigThumbnailPositionVerbose:(BOOL)verbose animated:(BOOL)animated;
- (void)_memoryWarning:(NSNotification *)notification;

- (void)_prepareImageViewForReuse:(CUURLImageView *)imageView;
- (CUURLImageView *)_dequeueReusableImageView;

@property (nonatomic, assign) NSUInteger visibleThumbnailsCount;
@property (nonatomic, retain) UIView *contentView;
@property (nonatomic, assign) CUURLImageView *bigThumbnailImageView;
@property (nonatomic, retain, readonly) NSMutableSet *reusableThumbnailImageViews;
@end

@implementation ThumbnailPickerView

@synthesize selectedIndex = _selectedIndex;
@synthesize dataSource = _dataSource, delegate = _delegate;
@synthesize visibleThumbnailsCount = _visibleThumbnailsCount;
@synthesize contentView = _contentView, bigThumbnailImageView = _bigThumbnailImageView;
@synthesize reusableThumbnailImageViews = _reusableThumbnailImageViews;

- (CUURLImageView *)_createThumbnailImageViewWithSize:(CGSize)size
{
    CUURLImageView *imageView = [[[CUURLImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)]autorelease];
    
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.backgroundColor = [UIColor grayColor];

//    imageView.layer.borderWidth = 1;
//    imageView.layer.borderColor = [UIColor whiteColor].CGColor;
    imageView.clipsToBounds = YES;
    imageView.userInteractionEnabled = NO;
    return imageView;
}

- (void)_setup
{
    self.selectedIndex = NSNotFound;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_memoryWarning:) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self _setup];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _setup];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
    [super dealloc];
}

- (void)_memoryWarning:(NSNotification *)notification
{
    [self.reusableThumbnailImageViews removeAllObjects];
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex animated:(BOOL)animated
{
    if (_selectedIndex != selectedIndex) {
        _selectedIndex = selectedIndex;
        if (_selectedIndex != NSNotFound)
            [self _updateBigThumbnailPositionVerbose:NO animated:animated];
    }
}
- (void)setSelectedIndex:(NSUInteger)selectedIndex animated:(BOOL)animated usedelegate:(BOOL)used{
    if (_selectedIndex != selectedIndex) {
          _selectedIndex = selectedIndex;
        if (_selectedIndex != NSNotFound)
            [self _updateBigThumbnailPositionVerbose:NO animated:animated useDelegete:used];
    }
}
- (void)setSelectedIndex:(NSUInteger)selectedIndex
{
    [self setSelectedIndex:selectedIndex animated:NO];
}

- (NSMutableSet *)reusableThumbnailImageViews
{
    if (!_reusableThumbnailImageViews) {
        _reusableThumbnailImageViews = [NSMutableSet set];
    }
    return _reusableThumbnailImageViews;
}

- (CUURLImageView *)_dequeueReusableImageView
{
    CUURLImageView *imageView = [self.reusableThumbnailImageViews anyObject];
    
    if (imageView) {
        [self.reusableThumbnailImageViews removeObject:imageView];
//        NSLog(@"found reusable image view!");
    }

    return imageView;
}

- (void)_prepareImageViewForReuse:( CUURLImageView*)imageView
{
    if (imageView.tag != 0) {
        imageView.image = nil;
        imageView.tag = 0;
        [self.reusableThumbnailImageViews addObject:imageView];
        [imageView removeFromSuperview];
    }
}

- (void)setDataSource:(id<ThumbnailPickerViewDataSource>)dataSource
{
    if (_dataSource != dataSource) {
        _dataSource = dataSource;
        [self setNeedsLayout]; // layoutSubviews calls reloadData
    }
}

- (void)reloadData
{
    NSUInteger totalItemsCount = [self.dataSource numberOfImagesForThumbnailPickerView:self];
    if (totalItemsCount == 0)
        return;
//    {
//    NSInteger temp =  (self.frame.size.width -((totalItemsCount+1) * kThumbnailSpacing));
//    kThumbnailSize.width =temp/totalItemsCount;
//    temp = temp - kThumbnailSize.width*totalItemsCount;
//    //kThumbnailSize.width += temp/totalItemsCount;
//    }
     CGFloat contentsWidth = totalItemsCount * kThumbnailSize.width + (totalItemsCount-1) * kThumbnailSpacing; // cw = i*w + (i-1)*s
    
    if (contentsWidth > self.bounds.size.width) {
        self.visibleThumbnailsCount = floor((self.bounds.size.width+kThumbnailSpacing)/(kThumbnailSize.width+kThumbnailSpacing)); // i = (c+s)/(w+s)
        NSLog(@"items count: %d, new items count: %d, width: %.0f", totalItemsCount, self.visibleThumbnailsCount, self.bounds.size.width);
        contentsWidth = self.visibleThumbnailsCount * kThumbnailSize.width + (self.visibleThumbnailsCount-1) * kThumbnailSpacing;
    } else {
        self.visibleThumbnailsCount = totalItemsCount;
    }
    
    NSMutableArray *indices = [NSMutableArray arrayWithCapacity:self.visibleThumbnailsCount];
    if (self.visibleThumbnailsCount < totalItemsCount) {
        for (NSUInteger i = 0; i < self.visibleThumbnailsCount; i++) {
            [indices addObject:[NSNumber numberWithUnsignedInteger:(float)i/(self.visibleThumbnailsCount-1)*(totalItemsCount-1)]];
        }
    } else {
        for (NSUInteger i = 0; i < self.visibleThumbnailsCount; i++) {
            [indices addObject:[NSNumber numberWithUnsignedInteger:i]];
        }
    }
    
    if (!self.contentView) {
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, contentsWidth, kThumbnailSize.height)];
        self.contentView.userInteractionEnabled = NO;
        self.contentView.backgroundColor = [UIColor clearColor];
        [self addSubview:self.contentView];
    } else {
        
        [self.contentView.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if (![indices containsObject:[NSNumber numberWithInt:[obj tag]-kTagOffset]]) {
                [self _prepareImageViewForReuse:obj];
            }
        }];
        
        CGRect contentViewFrame = self.contentView.frame;
        contentViewFrame.size.width = contentsWidth;
        self.contentView.frame = contentViewFrame;
    }
    
    CUURLImageView *imageView = nil;
    CGRect imageViewFrame;
    NSUInteger index;
    NSInteger tag;
    
    for (NSUInteger i = 0; i < self.visibleThumbnailsCount; i++) {
        index = [[indices objectAtIndex:i] unsignedIntegerValue];
        tag = index + kTagOffset;
        
        imageView = (CUURLImageView *)[self.contentView viewWithTag:tag];
        if (!imageView) {
            imageView = [self _dequeueReusableImageView];
            if (!imageView) {
                imageView = [self _createThumbnailImageViewWithSize:kThumbnailSize];
            }
            imageView.tag = tag;
        }
        
        imageViewFrame = imageView.frame;
        imageViewFrame.origin.x = i * (kThumbnailSize.width + kThumbnailSpacing);
        imageView.frame = imageViewFrame;
        
        [self.contentView addSubview:imageView];

        dispatch_queue_t imageLoadingQueue = dispatch_queue_create("image loading queue", NULL);
        dispatch_async(imageLoadingQueue, ^{
            NSURL *image = [self.dataSource thumbnailPickerView:self imageAtIndex:index];
            dispatch_async(dispatch_get_main_queue(),^{
                imageView.imageURL = image ;
            });
        });
        dispatch_release(imageLoadingQueue);
    }
    [self _updateBigThumbnailPositionVerbose:NO animated:NO];
}

- (void)reloadThumbnailAtIndex:(NSUInteger)index
{
    CUURLImageView *imageView = (CUURLImageView *)[self.contentView viewWithTag:index + kTagOffset];
    if (imageView) {
        dispatch_queue_t imageLoadingQueue = dispatch_queue_create("image loading queue", NULL);
        dispatch_async(imageLoadingQueue, ^{
            NSURL *image = [self.dataSource thumbnailPickerView:self imageAtIndex:index];
            dispatch_async(dispatch_get_main_queue(),^{
                imageView.imageURL = image ;
                if (index == self.selectedIndex) {
                    self.bigThumbnailImageView.imageURL = image;
                }
            });
        });
        dispatch_release(imageLoadingQueue);
    }
}

- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    [self _updateSelectedIndexForTouch:touch fineGrained:NO];
    [self _updateBigThumbnailPositionVerbose:YES animated:NO];
    return YES;
}

- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    [self _updateSelectedIndexForTouch:touch fineGrained:YES];
    [self _updateBigThumbnailPositionVerbose:YES animated:NO];
    return YES;
}

- (void)_updateSelectedIndexForTouch:(UITouch *)touch fineGrained:(BOOL)fineGrained
{
    CGPoint pos = [touch locationInView:self.contentView];
    NSUInteger totalItemsCount = [self.dataSource numberOfImagesForThumbnailPickerView:self];
    NSInteger idx;
    if (fineGrained)
        idx = floor(pos.x / self.contentView.frame.size.width * (totalItemsCount-1));
    else
        idx = floor(floor(pos.x/(kThumbnailSize.width+kThumbnailSpacing)) / (self.visibleThumbnailsCount-1) * (totalItemsCount-1));

    idx = MAX(0, idx);
    idx = MIN(totalItemsCount-1, idx);

    _selectedIndex = idx;
}

- (void)_updateBigThumbnailPositionVerbose:(BOOL)verbose animated:(BOOL)animated 
{
    if (self.selectedIndex != NSNotFound && self.contentView.subviews.count > 0) {
        UIView *subview = nil;
        NSInteger tag = self.selectedIndex+kTagOffset;
        NSInteger tagOffset = 0;
//        NSLog(@"trying tag %d, tagOffset %d", tag, tagOffset);
        while (!(subview = [self.contentView viewWithTag:tag])) {
            tag += (tagOffset = (tagOffset + (tagOffset>0 ? 1 : -1)) * -1); // 0, 1, -2, 3, -4, 5, -6 ...
//            NSLog(@"trying tag %d, tagOffset %d", tag, tagOffset);
        }
        
        if (!self.bigThumbnailImageView) {
            CUURLImageView *bigThumb = [self _createThumbnailImageViewWithSize:kBigThumbnailSize];
            self.bigThumbnailImageView = bigThumb;
            [self addSubview:self.bigThumbnailImageView];
        }

        void (^animations)(void) = ^ {
            self.bigThumbnailImageView.center = [self.contentView convertPoint:subview.center toView:self];
            dispatch_queue_t imageLoadingQueue = dispatch_queue_create("image loading queue", NULL);
            dispatch_async(imageLoadingQueue, ^{
                NSURL *image = [self.dataSource thumbnailPickerView:self imageAtIndex:self.selectedIndex];
                dispatch_async(dispatch_get_main_queue(),^{
                    self.bigThumbnailImageView.imageURL = image;
                });
            });
            dispatch_release(imageLoadingQueue);
        };

        if (animated)
            [UIView animateWithDuration:0.2 animations:animations];
        else
            animations();

        self.bigThumbnailImageView.tag = tag-kTagOffset+kBigThumbnailTagOffset;
        [self bringSubviewToFront:self.bigThumbnailImageView];
        
        if (verbose && [self.delegate respondsToSelector:@selector(thumbnailPickerView:didSelectImageWithIndex:)])
            [self.delegate thumbnailPickerView:self didSelectImageWithIndex:self.selectedIndex];
    }
}
- (void)_updateBigThumbnailPositionVerbose:(BOOL)verbose animated:(BOOL)animated useDelegete:(BOOL)used
{
    if (self.selectedIndex != NSNotFound && self.contentView.subviews.count > 0) {
        UIView *subview = nil;
        NSInteger tag = self.selectedIndex+kTagOffset;
        NSInteger tagOffset = 0;
        //        NSLog(@"trying tag %d, tagOffset %d", tag, tagOffset);
        while (!(subview = [self.contentView viewWithTag:tag])) {
            tag += (tagOffset = (tagOffset + (tagOffset>0 ? 1 : -1)) * -1); // 0, 1, -2, 3, -4, 5, -6 ...
                                                                            //            NSLog(@"trying tag %d, tagOffset %d", tag, tagOffset);
        }
        
        if (!self.bigThumbnailImageView) {
            CUURLImageView *bigThumb = [self _createThumbnailImageViewWithSize:kBigThumbnailSize];
            self.bigThumbnailImageView = bigThumb;
            [self addSubview:self.bigThumbnailImageView];
        }
        
        void (^animations)(void) = ^ {
            self.bigThumbnailImageView.center = [self.contentView convertPoint:subview.center toView:self];
            dispatch_queue_t imageLoadingQueue = dispatch_queue_create("image loading queue", NULL);
            dispatch_async(imageLoadingQueue, ^{
                NSURL *image = [self.dataSource thumbnailPickerView:self imageAtIndex:self.selectedIndex];
                dispatch_async(dispatch_get_main_queue(),^{
                    self.bigThumbnailImageView.imageURL = image;
                });
            });
            dispatch_release(imageLoadingQueue);
        };
        
        if (animated)
            [UIView animateWithDuration:0.2 animations:animations];
        else
            animations();
        
        self.bigThumbnailImageView.tag = tag-kTagOffset+kBigThumbnailTagOffset;
        [self bringSubviewToFront:self.bigThumbnailImageView];
        
        if (used&&verbose && [self.delegate respondsToSelector:@selector(thumbnailPickerView:didSelectImageWithIndex:)])
            [self.delegate thumbnailPickerView:self didSelectImageWithIndex:self.selectedIndex];
    }
}

- (void)layoutSubviews
{
    [self reloadData];
    self.contentView.center = [self convertPoint:self.center fromView:self.superview];
    if (self.bigThumbnailImageView) {
        // center big thumbnail view vertically
        CGRect frame = self.bigThumbnailImageView.frame;
        frame.origin.y = (self.bounds.size.height - frame.size.height) / 2;
        self.bigThumbnailImageView.frame = frame;

        UIView *subview = [self.contentView viewWithTag:self.bigThumbnailImageView.tag-kBigThumbnailTagOffset+kTagOffset];
        if (subview)
            self.bigThumbnailImageView.center = [self.contentView convertPoint:subview.center toView:self];
    }
}

@end
