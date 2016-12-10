//
//  TimeDiff.m
//  GoEuro
//
//  Created by Алексей Неронов on 10.12.16.
//  Copyright © 2016 Алексей Неронов. All rights reserved.
//

#import "TimeDiff.h"

@implementation TimeDiff

+(NSString*) departure:(NSString*)depTime andArrival:(NSString*)arrTime {
    int dep = [self strTimeToMin:depTime];
    int arr = [self strTimeToMin:arrTime];
    if (dep > arr) dep = dep - 24 * 60;
    int dif = arr - dep;
    NSString* result = [self minutesToHourMin:dif];
    return result;
}

+(int)strTimeToMin:(NSString*)string {
    int hours = [string substringToIndex:[string rangeOfString:@":"].location].intValue;
    int minutes = [string substringFromIndex:[string rangeOfString:@":"].location + 1].intValue;
    return hours * 60 + minutes;
}
    
+(NSString*)minutesToHourMin:(int)minutes {
    int hour = minutes/60;
    int min = minutes - hour * 60;
    NSString* zero = @"";
    if (min<10) zero = @"0";
    return [NSString stringWithFormat:@"%d:%@%d",hour,zero,min];
}
    
@end
