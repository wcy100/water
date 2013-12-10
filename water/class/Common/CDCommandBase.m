//
//  CDCommandBase.m
//  EMPiOS
//
//  Created by liu junchi on 11-6-17.
//  Copyright 2011年 ChengDe. All rights reserved.
//

#import "CDCommandBase.h"


@implementation CDCommandBase


@synthesize requestService;
/**
 * 每页条数
 * 0、未分页
 */
@synthesize nPageSize;
/**
 * 页码
 */
@synthesize nCurrentPage;
/**
 * 命令数据
 */
@synthesize sCommandData;
- (id)init
{
    self = [super init];
    if (self) {
        self.nCurrentPage = 0;
        self.nPageSize = 0;
    }
    return self;
}

-(void)dealloc
{
    [requestService release];
	
    if(nil != sCommandData )
        [sCommandData release];
    
    [super dealloc];
}

-(NSData*)getJsonData;
{
    self.sCommandData = [self getCommandJSONObj];
    
    NSData *retjson = nil;
    
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    
    [dic setObject:self.requestService forKey:@"requestService"];
    // [dic setObject: [NSNumber numberWithInt:0] forKey:@"nEmpID"];
    //[dic setObject: [NSNumber numberWithInt:0] forKey:@"nDeptID"];
    [dic setObject:[NSNumber numberWithInt:self.nPageSize] forKey:@"nPageSize"];
    [dic setObject:[NSNumber numberWithInt:self.nCurrentPage] forKey:@"nCurrentPage"];
    NSObject *tempDic = self.sCommandData ;    
    BOOL flag = NO;
    NSString *singleValue = nil;
    if([tempDic isKindOfClass:[NSDictionary class]])
    {
        if( 1 == [(NSDictionary *)tempDic allValues].count  )
        {
            singleValue = [[(NSDictionary*)tempDic allValues]  objectAtIndex:0];
            
            if([singleValue isKindOfClass:[NSString class]] || [singleValue isKindOfClass:[NSNumber class]] )
            {
                flag = YES;
            }
            
        }
    }
    
    if(flag)
    {
        [dic setObject:[NSArray arrayWithObject:singleValue] forKey:@"sCommandData"];
//        NSLog(@"%@",singleValue);
    }
    else {
        
        [dic setObject:[NSArray arrayWithObject:tempDic] forKey:@"sCommandData"];//sCommandData
    
    }
      NSLog(@"发送数据格式：%@",dic);
    retjson = [[dic JSONString]dataUsingEncoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)];
    
    [dic release];

    return retjson;
}

-(NSDictionary*)getCommandJSONObj
{
    return nil;
}

@end
