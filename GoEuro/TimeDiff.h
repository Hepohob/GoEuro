//
//  TimeDiff.h
//  GoEuro
//
//  Created by Алексей Неронов on 10.12.16.
//  Copyright © 2016 Алексей Неронов. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimeDiff : NSObject

+(NSString*) departure:(NSString*)depTime andArrival:(NSString*)arrTime;
    
@end
