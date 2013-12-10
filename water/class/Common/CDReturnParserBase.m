//
//  CDReturnParserBase.m
//  EMPiOS
//
//  Created by liu junchi on 11-6-18.
//  Copyright 2011年 ChengDe. All rights reserved.
//

#import "CDReturnParserBase.h"

#import <UIKit/UIKit.h>


@implementation CDReturnParserBase

@synthesize nIsSuccess;
/**
 * 错误代码
 */
@synthesize sErrorCode;
/**
 * 错误信息
 */
@synthesize sErrorMessage;
/**
 * 返回结果集数据总数
 */
@synthesize nRowCount;
/**
 * 返回结果集分页总数
 */
@synthesize nPageCount;
/**
 * 返回数据
 */
@synthesize sRetData;

@synthesize allDatas;

-(id)init
{
    self = [super init];
    
    if(self)
    {
        allDatas = [[NSMutableArray alloc] init];
    }
    
    return self;
}


-(void)dealloc
{
    [sErrorCode release];
	[sErrorMessage release];
	[sRetData release];
    [allDatas release];
    
    [super dealloc];
}

-(BOOL)paserReturnCommand: (NSData*)retData
{
    BOOL ret = YES;
    
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
	NSString *retJSONStr = [[NSString alloc] initWithData:retData encoding:enc];
#ifdef DEBUG
	NSLog(@"返回数据:%@", retJSONStr);
#endif
	retData = [retJSONStr dataUsingEncoding:NSUTF8StringEncoding];
    [retJSONStr release];
  
    NSDictionary *items = [retData toJSONObject];
    
    self.sErrorCode = [items valueForKey:@"sErrorCode"];

    self.nIsSuccess = [[items valueForKey:@"nIsSuccess"]integerValue];
    self.sErrorMessage = [items valueForKey:@"sErrorMessage"];

    NSString *Retstr = [items valueForKey:@"sRetData"];
    retData = [Retstr dataUsingEncoding:NSUTF8StringEncoding];
   
    self.sRetData = [retData toJSONObject];
    if( self.nIsSuccess > 0 )
    {
        ret = NO;
    }
    
    
    return ret;
}

-(BOOL)paserReturnData
{
    return  YES;
}


@end
