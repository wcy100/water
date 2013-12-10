//
//  Paging.m
//  LiveByTouch
//
//  Created by hao.li on 11-9-26.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Paging.h"


@implementation Paging
@synthesize pageSize,rowCount,pageCount,isEnd;
@synthesize current = current;
- (id)init
{
    self = [super init];
    if (self) {
        self.pageCount = 1;
        self.rowCount = -1;
        self.pageSize = 0;
        self.isEnd = YES;
        current = 1;
    }
    return self;
}
-(void)setCurrent:(long)val{
    current = val;

    self.isEnd = NO;
    if (current==pageCount) {
        self.isEnd = YES;
    }
   
}
-(void)setRowCount:(long)val{
    if (val==0) {
        self.isEnd = YES;
    }else
        self.isEnd = NO;
}
@end
