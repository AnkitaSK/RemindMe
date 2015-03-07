//
//  CalenderData.h
//  RemindMe
//
//  Created by Ankita Kalangutkar on 3/7/15.
//  Copyright (c) 2015 Ankita Kalangutkar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface CalenderData : NSManagedObject

@property (nonatomic, retain) NSNumber * day;
@property (nonatomic, retain) NSNumber * weekday;
@property (nonatomic, retain) NSNumber * month;
@property (nonatomic, retain) NSNumber * year;

@end
