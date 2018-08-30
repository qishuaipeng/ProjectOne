//
//  NSObject+Category.h
//  JDZBorrower
//
//  Created by WangXueqi on 2018/4/10.
//  Copyright © 2018年 Jingbeijinrong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Category)

//获取类名
- (NSString *)className;
//转换有效字符串
- (NSString *)safeString;
//json字符串转NSDictionary
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
//获取时间
- (NSString *)dateStringFromDate:(NSDate *)date;
@end
