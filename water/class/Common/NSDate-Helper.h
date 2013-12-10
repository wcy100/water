//
//  NSDate-Helper.h


#import <Foundation/Foundation.h>


@interface NSDate(Helpers)


/*
 
 * This guy can be a little unreliable and produce unexpected results,
 
 * you're better off using daysAgoAgainstMidnight
 
 */
+(BOOL)isToday:(NSString*) strSomeDate;
+(NSString*)fetchTimeToSomeFormat:(NSString*)strSomeDate;
+(BOOL)isInOneMinuteBetweenTwoTime:(NSString*) strOldDate :(NSString*) strNewDate;
+(BOOL)isInOneDay:(NSString*) strOldDate :(NSString*) strNewDate;

//获取年月日如:19871127.

- (NSString *)getFormatYearMonthDay;

//返回当前月一共有几周(可能为4,5,6)

- (int )getWeekNumOfMonth;

//该日期是该年的第几周

- (int )getWeekOfYear;

//返回day天后的日期(若day为负数,则为|day|天前的日期)

- (NSDate *)dateAfterDay:(int)day;
- (NSDate *)dateAfterDayFromDate:(int)day fromDate:(NSDate*)date;

//month个月后的日期

- (NSDate *)dateafterMonth:(int)month;
- (NSDate *)dateafterMonthFromDate:(int)month dateSetting:(NSDate*)setDate;

//获取日

- (NSUInteger)getDay;

- (NSUInteger)getDayFromDate:(NSDate*)fromDate;

//获取月

- (NSUInteger)getMonth;

//获取年

- (NSUInteger)getYear;

//获取小时

- (int )getHour;

//获取分钟

- (int)getMinute;
- (int )getHour:(NSDate *)date;

- (int)getMinute:(NSDate *)date;

//在当前日期前几天

- (NSUInteger)daysAgo;

//午夜时间距今几天

- (NSUInteger)daysAgoAgainstMidnight;

- (NSString *)stringDaysAgo;

- (NSString *)stringDaysAgoAgainstMidnight:(BOOL)flag;

//返回一周的第几天(周末为第一天)

- (NSUInteger)weekday;

//转为NSString类型的
+ (NSDate *)dateFromString:(NSString *)string;


+ (NSDate *)dateFromString:(NSString *)string withFormat:(NSString *)format;



+ (NSString *)stringFromDate:(NSDate *)date withFormat:(NSString *)format;


+ (NSString *)stringFromDate:(NSDate *)date;



+ (NSString *)stringForDisplayFromDate:(NSDate *)date prefixed:(BOOL)prefixed;



+ (NSString *)stringForDisplayFromDate:(NSDate *)date;

- (NSString *)stringWithFormat:(NSString *)format;

- (NSString *)string;

- (NSString *)stringWithDateStyle:(NSDateFormatterStyle)dateStyle timeStyle:(NSDateFormatterStyle)timeStyle;

//返回周日的的开始时间

- (NSDate *)beginningOfWeek;

//返回当前天的年月日.

- (NSDate *)beginningOfDay;

//返回该月的第一天

- (NSDate *)beginningOfMonth;
- (NSDate *)beginningOfMonthFromNow:(NSInteger)mouth;

//该月的最后一天

- (NSDate *)endOfMonth;

- (NSDate *)endOfMonthFromNow:(NSInteger)mouth;

//返回当前周的周末

- (NSDate *)endOfWeek;



+ (NSString *)dateFormatString;


+ (NSString *)timeFormatString;



+ (NSString *)timestampFormatString;


// preserving for compatibility

+ (NSString *)dbFormatString;

@end
