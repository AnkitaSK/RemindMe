//
//  CalenderView.h
//  CalenderApp
//
//  Created by Ankita Kalangutkar on 3/7/15.
//  Copyright (c) 2015 Ankita Kalangutkar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalenderView : UICollectionView

- (NSDateComponents*)currentDateDetail:(NSDate *)currentDate;
- (NSString *)currentMonthFromvalue:(int)monthValue;
- (NSDateComponents *)beginningDateDetailFromDate:(NSDate *)beginningDate;
- (NSInteger) daysInMonth: (NSInteger)month andYear: (NSInteger)year;
@end
