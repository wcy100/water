//
//  CDReturnParserBase.h
//  EMPiOS
//
//  Created by liu junchi on 11-6-18.
//  Copyright 2011年 ChengDe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSData+JSONCategories.h"
#import "NSString+JSONCategories.h"
@interface CDReturnParserBase : NSObject {
    
    int nIsSuccess;
	/**
	 * 错误代码
	 */
	NSString *sErrorCode;
	/**
	 * 错误信息
	 */
	NSString *sErrorMessage;
	/**
	 * 返回结果集数据总数
	 */
	int nRowCount;
	/**
	 * 返回结果集分页总数
	 */
	int nPageCount;
	/**
	 * 返回数据
	 */
	NSString *sRetData;
    
    NSMutableArray *allDatas;
    
}

@property (nonatomic, retain) NSMutableArray *allDatas;

@property (nonatomic) int nIsSuccess;
/**
 * 错误代码
 */
@property (nonatomic, retain) NSString *sErrorCode;
/**
 * 错误信息
 */
@property (nonatomic, retain) NSString *sErrorMessage;
/**
 * 返回结果集数据总数
 */
@property (nonatomic) int nRowCount;
/**
 * 返回结果集分页总数
 */
@property (nonatomic) int nPageCount;
/**
 * 返回数据
 */
@property (nonatomic, retain) id sRetData;


-(BOOL)paserReturnCommand: (NSData*)retData;
-(BOOL)paserReturnData;
@end
