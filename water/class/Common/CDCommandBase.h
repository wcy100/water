//
//  CDCommandBase.h
//  EMPiOS
//
//  Created by liu junchi on 11-6-17.
//  Copyright 2011年 ChengDe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSDictionary+JSONCategories.h"
#import "JSONKit.h"
@interface CDCommandBase : NSObject {
    
    /**
	 * 请求服务
	 */
	
	 NSString *requestService;
		/**
	 * 每页条数
	 * 0、未分页
	 */
	int nPageSize;
	/**
	 * 页码
	 */
	int nCurrentPage;
	/**
	 * 命令数据
	 */
	NSDictionary *sCommandData;
    NSArray *params;
}

/**
 * 请求服务
 */
@property (nonatomic, retain) NSString *requestService;
/**
 * 每页条数
 * 0、未分页
 */
@property (nonatomic) int nPageSize;
/**
 * 页码
 */
@property (nonatomic) int nCurrentPage;
/**
 * 命令数据
 */
@property (nonatomic, retain) NSDictionary *sCommandData;

-(NSString *)EncodeUTF8Str:(NSString *)encodeStr;
-(NSString *)EncodeGB2312Str:(NSString *)encodeStr;
-(NSData*)getJsonData;
-(NSDictionary*)getCommandJSONObj;
@end
