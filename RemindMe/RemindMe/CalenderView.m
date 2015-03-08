//
//  CalenderView.m
//  CalenderApp
//
//  Created by Ankita Kalangutkar on 3/7/15.
//  Copyright (c) 2015 Ankita Kalangutkar. All rights reserved.
//

#import "CalenderView.h"

@implementation CalenderView

- (NSDateComponents*)currentDateDetail:(NSDate *)currentDate {
//    NSDate *currentDate = [NSDate date];
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday fromDate:currentDate]; // Get necessary date components
    
    return components;
}

- (NSDateComponents *)beginningDateDetailFromDate:(NSDate *)beginningDate {
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday fromDate:beginningDate]; // Get necessary date components
    
    return components;
}

- (NSString *)currentMonthFromvalue:(int)monthValue {
    NSString *month;
    switch (monthValue) {
        case 1:
            month = @"Jan";
            break;
        case 2:
            month = @"Feb";
            break;

        case 3:
            month = @"March";
            break;

        case 4:
            month = @"April";
            break;

        case 5:
            month = @"May";
            break;

        case 6:
            month = @"June";
            break;

        case 7:
            month = @"July";
            break;

        case 8:
            month = @"Aug";
            break;

        case 9:
            month = @"Sept";
            break;

        case 10:
            month = @"Oct";
            break;

        case 11:
            month = @"Nov";
            break;

        case 12:
            month = @"Dec";
            break;

            
        default:
            break;
    }
    return month;
}

-(BOOL) leapYear: (NSInteger) year {
    BOOL leap = FALSE;
    if ((year % 4 == 0) && ((year % 100 !=0) || (year % 400 == 0)))
        leap = TRUE;
    
    return leap;
    
}
- (NSInteger) daysInMonth: (NSInteger)month andYear: (NSInteger)year {
    switch (month) {
        case 1:
        case 3:
        case 5:
        case 7:
        case 8:
        case 10:
        case 12: return 31;
            break;
        case 2: {
            if ([self leapYear:year])
                return 29;
            else
                return 28;
        }
            break;
            
        default: return 30;
            break;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
