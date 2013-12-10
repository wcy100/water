//
//  Global.h
//  LiveByTouch
//
//  Created by hao.li on 11-7-18.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
extern NSStringEncoding gdkEncoding;
@class LableView;
@class TableView;
@class BaseController;

#define kUserName  @"kUserName"
#define kPWD  @"PWD"
#define kFirstLogin  @"kFirstLogin"
#define kUse3G  @"kUse3G"


#define BASEURL @"http://192.168.9.191:7782/JXINFO/test"//基链接
#define SYSTEMVERSION [[[UIDevice currentDevice] systemVersion] floatValue]

//sqlite 
#define DB_NAME @"zft.db"
#define KEY @""
//获取地理位置
#define LOCATION [BASEURL stringByAppendingString:@"mapi/geo/latlng2addr"]

#define SEARCHBARBGCOLOR [ UIColor colorWithRed:(0x9A*1.0f)/(0xff*1.0f) green:0xCD/(0xff*1.0f) blue:0x32/(0xff*1.0f) alpha:1];//搜索条背景
#define TEXTCOLOR [UIColor colorWithRed:255.0/255.0 green:127.0/255.0 blue:0.0/255.0 alpha:0.8]//文字颜色

#define NAVBARBGCOLOR  [ UIColor colorWithRed:(0x9A*1.0f)/(0xff*1.0f) green:0xCD/(0xff*1.0f) blue:0x32/(0xff*1.0f) alpha:1];
#define BARCOLOR [UIColor colorWithRed:255.0/255.0 green:250.0/255.0 blue:240.0/255.0 alpha:1.0]//bar 很淡的背景颜色  
#define HEADERBGCOLOR [UIColor colorWithRed:(255.0f/255.0f) green:(250.0f/255.0f) blue:(240.0f/255.0f) alpha:1.0]//PersonCenter header背景
#define BLACKBGCOLOR [UIColor colorWithRed:(0.0f/255.0f) green:(0.0f/255.0f) blue:(0.0f/255.0f) alpha:0.8f]//黑色的背景
//bar背景
#define BARBACKGROUND  [ UIColor colorWithRed:(0xed*1.0f)/(0xff*1.0f) green:0xed/(0xff*1.0f) blue:0xee/(0xff*1.0f) alpha:1];
#define BORDERCOLOR [UIColor colorWithRed:(180.0f/255.0f) green:(180.0f/255.0f) blue:(180.0f/255.0f) alpha:1.0f]//灰色的边框
#define BGCOLOR [UIColor colorWithRed:(180.0f/255.0f) green:(180.0f/255.0f) blue:(180.0f/255.0f) alpha:0.4f]//整体背景效果
#define TABLEBG [UIColor colorWithRed:(255.0f/255.0f) green:(250.0f/255.0f) blue:(240.0f/255.0f) alpha:1.0f]//表格背景效果
//个人中心链接
#define LOGINGINFOURL [BASEURL stringByAppendingString:@"login"]//登录接连
#define REGISTERUSER [BASEURL stringByAppendingString:@"register"]//注册


#define WEIBO_LIST [BASEURL stringByAppendingString:@"weibo_list"]//品客动态
#define COMMENT_RECIVE [BASEURL stringByAppendingString:@"comment_recive"]//评论接收接口







#define GETFOLLOWLIST [BASEURL stringByAppendingString:@"mapi/user/followLst"]//关注列表
//#define GETFOLLOWUSERINFO [BASEURL stringByAppendingString:@"mapi/user/getInfo"]//关注列表的个人相信信息
#define FOLLOWCHANGE [BASEURL stringByAppendingString:@"mapi/user/followChange"]//关注和取消关注
#define MODIFYUSERINFOURL [BASEURL stringByAppendingString:@"mapi/user/postMyinfo2"]//修改用户信息链接
#define GETFANSLIST [BASEURL stringByAppendingString:@"mapi/user/fanLst"]//获取粉丝列表
#define GETZFB [BASEURL stringByAppendingString:@"mapi/user/getBalance"]//获取支付币
#define SYNCSNSPAGE [BASEURL stringByAppendingString:@"mapi/oauth/getauthurl"]//同步sns获取url
#define SNSCONFIRM [BASEURL stringByAppendingString:@"mapi/oauth/saveAuth"]//缺人SNS同步
#define SNSLIST [BASEURL stringByAppendingString:@"mapi/oauth/list"]//获取同步列表
#define SNSCANCEL [BASEURL stringByAppendingString:@"mapi/oauth/cancel"]//取消同步
#define FINDFRIENDBYNICKNAME [BASEURL stringByAppendingString:@"mapi/friends/listByNickname"]//搜索好友（根据昵称）
#define SAMEFRIENDLY [BASEURL stringByAppendingString:@"mapi/friends/listBySamefollow"]//查找共同好友
#define SAMESPENDING [BASEURL stringByAppendingString:@"mapi/friends/listBySameshop"]//查找共同消费过的好友
#define DAREN [BASEURL stringByAppendingString:@"mapi/friends/listPowerUser"]//查找共同消费过的好友

#define REVIEWSLIST [BASEURL stringByAppendingString:@"mapi/reviews/list"]//根据userid来获取评论列表
#define ACCOUNTLIST [BASEURL stringByAppendingString:@"mapi/user/usercodeLst"]//指付通帐号

//团购 热门活动
#define HOTACTIVELIST [BASEURL stringByAppendingString:@"mapi/active/fetchLatest"]//热门活动
#define TOGETHERBUYLIST [BASEURL stringByAppendingString:@"mapi/zft/fetchLatest"]//团购信息
#define CHEAPLIST [BASEURL stringByAppendingString:@"mapi/active/search"]//附近优惠
#define FINDCHEAPINFO [BASEURL stringByAppendingString:@"mapi/active/findByPoscode"]//查找优惠信息
#define ACTIVEDETAIL [BASEURL stringByAppendingString:@"mapi/webview/active.html"]//活动详情
#define TUANGOUDETAIL [BASEURL stringByAppendingString:@"mapi/webview/tuangou.html"]//团购详情 

//体验站
#define FEELLIST [BASEURL stringByAppendingString:@"mapi/tyz/fetchNearby"]//体验站列表

//商户信息
#define REVIEWSDETAIL [BASEURL stringByAppendingString:@"mapi/shanghu/getDetail"]//商户的详细信息
#define SHOPLIST [BASEURL stringByAppendingString:@"mapi/shanghu/list"]//商户信息列表
#define SHOPDETAIL [BASEURL stringByAppendingString:@"mapi/shanghu/getDetail"]//商户详细信息
#define PHOTOLIST [BASEURL stringByAppendingString:@"mapi/reviews/listPhotos"]//获取所有的图片
#define ADDFORWORD [BASEURL stringByAppendingString:@"mapi/reviewforward/addForward"]//添加转发

//点评链接
#define SPENDINGLIST [BASEURL stringByAppendingString:@"mapi/user/debitlogLst"]//关注列表
#define SUBMITREVIEWS [BASEURL stringByAppendingString:@"mapi/reviews/postReview2"]//提交评论信息
#define COMMENTS [BASEURL stringByAppendingString:@"mapi/reviews/comment"]//好评 差评论
#define REVIEWLINK [BASEURL stringByAppendingString:@"mapi/reviewlink/addLink"]//我要优惠

//排行榜
#define SHANGHUSORT [BASEURL stringByAppendingString:@"mapi/topn/list"]

//我要兑换
#define SWAPLIST [BASEURL stringByAppendingString:@"mapi/exchange/queryExchangeGoods"]//兑换列表
#define EXCHANGE [BASEURL stringByAppendingString:@"mapi/exchange/addExchangeInfo"] //兑换
#define GETEXCHANGINFO [BASEURL stringByAppendingString:@"mapi/exchange/queryExchangeGoodsByUserid"]//获取兑换记录

#define KCancerSwapurl [BASEURL stringByAppendingString:@"mapi/exchange/returnExchange"]//取消兑换

//版本升级
#define CHECKNEWVERSION [BASEURL stringByAppendingString:@"mapi/upgrade/checkNewApple"]//检测版本升级

//文件 目录
//#define HEADERNAME @"livebytouchIcon.jpg"//用户图标的名字
#define DOCUMENTS_FOLDER [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]//获取程序根目录文件夹
#define IMAGECACHE [DOCUMENTS_FOLDER stringByAppendingPathComponent:@"ImageCache"]
#define USERIMAGE [IMAGECACHE stringByAppendingPathComponent:@"UserImage"]//下载用户图片文件夹
#define REVIEWIMAGE [IMAGECACHE stringByAppendingPathComponent:@"ReviewImage"]//缓存图片信息
#define SHANGHUIMAGE  [IMAGECACHE stringByAppendingPathComponent:@"ShanghuImage"]//缓存图片信息
#define TYZIMAGE [IMAGECACHE stringByAppendingPathComponent:@"TyzImage"]//体验站图标
#define ACTIVEIMAGE [IMAGECACHE stringByAppendingPathComponent:@"ActiveImage"]//活动图标
typedef enum {
    GreatLev,
    GoodLev,
    BadLev
}commentLevel;
typedef enum{
	ProcessNone=0,//无
	ProcessDefault=1,//默认效果  黑色遮盖  
	ProcessSimple=2,//一般  只有转圈
} ProcessType;

typedef enum{
	BreakSubReviews=1,//我要点评
	BreakFriendReviews=2,//好友点评
	BreakFriendFrowordReviews=3,//好友转发
	BreakMyFrowordReviews = 14,//我的转发
	BreakRandomReviews=4,//随便看看
	BreakMyReviews=5,//我的点评
	BreakFindFriend = 6,//查找好友
	BreakShopReviewList = 7,//商户点评列表
	BreakFromPersonCenter = 8,//从个人中心跳转过来的，我的点评
	BreakMyContrctReviews = 9,//与我相关的评论
	BreakFromDetailCenter = 10,//从详细中心跳转过来的
	BreakFromReviewsList = 11,//从点评列表跳转过来的
	BreakFromMainPage=12,//从主页跳转过来的
	BreakFromNearCheap=13,//从附近优惠信息跳转过来的
	BreakFavoriteReviews=15,//收藏的点评
	BreakToSuper = 16,//返回到上级
	BreakNeedLogin = 17,//需要登录  干掉堆栈里面的自己
}BreakType;

typedef enum{
	CacheForever=0,//永久不变
	CacheChange=1,//可变的
}CacheType;

typedef enum{
	ImageDefault=0,//默认无效果
	ImageCorner=1,//圆角
	ImageShadow=2,//阴影效果
	ImageCustomBg1=3,//自定义背景1
	ImageSizeFirst=4,//图片大小优先
}ImageType;

typedef enum{
	PageLastRefreshYourCare=0,
	PageLastRefreshYourFans=1,
	PageLastRefreshFriendReviews=2,//好友点评
	PageLastRefreshFriendFrowordReviews=3,//好友转发页面
	PageLastRefreshRandomReviews=4,//随便看看页面
	PageLastRefreshMyReviews=5,//我的点评页面
	PageLastRefreshContrctMyReviews=6,//与我相关的评论
	PageLastRefreshSheReviews=7,//他的点评
	PageLastRefreshSpendingList=8,//我的消费记录
}PageLastRefreshTime;

typedef enum{
	TableViewConfirmOne=0,//table提示类型1
	TableViewConfirmTwo=1,//table提示类型2
}TableViewConfirm;

typedef enum{
	DataTypeDistance=0,//数据类型为字符串
	DataTypeCategory=1,//数据类型为实体
	DataTypeSort=2,//排序类型
	DataTypeType=3,//类型
	DataTypeArea=4,//区域 地名
}DataType;

typedef enum{
	DocumentsUser=0,//用户图标
	DocumentsReview=1,//评论图标
	DocumentsShanghu=2,//商户图标
	DocumentsTyz = 3,//体验站
	DocumentsActive = 4,//活动
}Document;

//网路请求
@protocol GlobalDelegate <NSObject>

-(void) _requestFailed:(int)processType;
-(void) _requestSuccess:(int)processType;
-(void) _requestStart:(int)processType;

@end

//单击事件
@protocol ClickedDelegate <NSObject>

-(void) someLikeButton:(id)sender;

@end

@protocol AlertDelegate <NSObject>

-(void) alertCallBack:(id)sender;

@end

//自定义cell
//@protocol CellsDelegate <NSObject>
//
//-(void) notifyToController:(id)sender;
//-(TableView*) getTableView;
//
//@end

@interface Global : NSObject {
	int ScreenWidth;
	int ScreenHeight;
	float lat;
	float lng;
	UIViewController *mainViewController;
	NSString *locationConfirm;
	LableView *lblConfirm;
	
	id<AlertDelegate> alertDelegate;
	
	UIView *targetView;
	
	BOOL hasNetwork;
}

+(Global*) GetInstance;
+ (void)messagebox:(NSString*)string;
+ (void)messagetoast:(NSString*)string target:(UIViewController*)pt;
- (void) messageboxdelegate:(NSString*)string Delegate:(id<AlertDelegate>)dg;


-(void)drawRect:(CGRect)rect;

//从硬盘保存图片
-(void) savingImage:(NSString*)fileName Image:(UIImage*)image Type:(Document)type;

//从硬盘获取图片
-(UIImage*) getDiskImage:(NSString*)fileName Type:(Document)type;
-(NSData*) getDiskNSData:(NSString*)fileName Type:(Document)type;

- (UIView *)bubbleView:(NSString *)text Path:(NSString*)path;

//截取upload目录下的路径
-(NSString*) getSubFilePath:(NSString*)str;

+(NSString*) encodedUrlString:(NSString*)str;
-(BOOL) isOk;

+(NSDate*)NSStringDateToNSDate:(NSString*)dateString;
+(NSString*)NSDateToNSString:(NSDate*)date;
+(NSString*)GetCurrentDate:(NSDate*)date;
+(NSString*)GetGoodReviews:(int) good :(int)bad;
+(NSString*)intToString:(int)value;
+(NSString*)doubleToString:(double)value;
+(NSString*)floatToString:(float)value;

+(NSString*)formatMoney:(float)value;
+(NSString*)formatZfb:(float)value;
+(void) cancelKeyBoard:(UIView*)view;
+(void) removeChilds:(UIView*)view;

+(NSString*) getFileSize:(NSString*)folderPath;
+(NSString*) deleteFiles:(NSString*)folderPath;

+(UIImage*) getStaticImage:(NSString*)path;

+ (UIImage*)resizeImage:(UIImage*)image toWidth:(NSInteger)width height:(NSInteger)height;

+(NSString *)md5:(NSString *)str;
//图片base64编解码方法

+ (NSString *)encodeUIImageToBase64:(UIImage *)toEncodeUIImage;
+ (UIImage *)decodeUIImageFromBase64:(NSString *)toDecodeString;
/**
 alpha 从0到1
 */
+(void) AlphaToOne:(UIView*)targetView;
+(void) AlphaToZero:(UIView*)targetView;


+(CGFloat)getHeight:(NSString *) str width:(CGFloat)viewWidth font:(UIFont *)font;

@property(nonatomic) int ScreenWidth;
@property(nonatomic) int ScreenHeight;
@property(nonatomic) float lat;
@property(nonatomic) float lng;
@property(nonatomic,retain) NSString *locationConfirm;
@property(nonatomic,retain) UIViewController *mainViewController;
@property(nonatomic,retain) LableView *lblConfirm;
@property(nonatomic,retain) UIView *targetView;
@property(nonatomic) BOOL hasNetwork;

@end
