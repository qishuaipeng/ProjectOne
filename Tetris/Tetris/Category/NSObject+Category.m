//
//  NSObject+Category.m
//  JDZBorrower
//
//  Created by WangXueqi on 2018/4/10.
//  Copyright © 2018年 Jingbeijinrong. All rights reserved.
//

#import "NSObject+Category.h"

@implementation NSObject (Category)

- (NSString *)className {
    NSString * classStr = NSStringFromClass([self class]);
    return classStr;
}

- (NSString *)safeString {
    if (!self) {
        return @"";
    }
    if ([self isEqual:[NSNull null]]) {
        return @"";
    }
    //    if ([self isKindOfClass:[NSNumber class]]) {
    //        return [self description];
    //    }
    NSString * str = [NSString stringWithFormat:@"%@",self];
    if ([str isEqualToString:@"<null>"]) {
        return @"";
    }
    if ([str isKindOfClass:[NSString class]]&&!str.length) {
        return @"";
    }
    return  str;
}

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        DebugLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

- (NSString *)dateStringFromDate:(NSDate *)date {
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss.SSS";
    return [fmt stringFromDate:date];
}

@end
