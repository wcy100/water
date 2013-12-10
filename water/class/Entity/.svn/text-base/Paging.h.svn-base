//
//  Paging.h
//  LiveByTouch
//
//  Created by hao.li on 11-9-26.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Paging :NSObject{

	int pageSize;//每页多少条
	long rowCount;//总记录数
	
	long current;//当前页
	long pageCount;//总页数
	BOOL isEnd;
}
@property(nonatomic) int pageSize;
@property(nonatomic) long rowCount;//总记录数
@property(nonatomic) long current;//当前页
@property(nonatomic) long pageCount;//总页数
@property(nonatomic) BOOL isEnd;

-(void)setCurrent:(long)val;
@end
