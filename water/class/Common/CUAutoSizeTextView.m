//
//  CUAutoSizeTextView.m


#import "CUAutoSizeTextView.h"


@implementation CUAutoSizeTextView
@synthesize strShow = _strShow;
//@synthesize _nSingleLineWordsNumber;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
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
    [super dealloc];
}



-(void)setStrShow:(NSString *)strShow
{
	_strShow = strShow;
	self.text = strShow;
    
    NSString *contentStr = _strShow ; 
    
    CGSize textSize = [contentStr sizeWithFont:[UIFont systemFontOfSize:17] constrainedToSize:CGSizeMake(self.frame.size.width-20, CGFLOAT_MAX)lineBreakMode:NSLineBreakByWordWrapping];
    
    if (self.frame.size.width-20>textSize.width) {
        CGRect frameT = self.frame ;
        frameT.size.width = textSize.width+20 ; 
        //frameT.size.height = textSize.height ;
        self.frame = frameT;
    }
    
    CGRect frameT = self.frame ;
    frameT.size.height = textSize.height+10 ; 
    self.frame = frameT;
	/*
	CGRect tmp = self.frame;
	tmp.size = self.contentSize;
	self.frame = tmp;*/
	
}

@end
