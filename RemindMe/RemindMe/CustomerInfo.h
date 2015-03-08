//
//  CustomerInfo.h
//  RemindMe
//
//  Created by Ankita Kalangutkar on 3/8/15.
//  Copyright (c) 2015 Ankita Kalangutkar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CalenderData;

@interface CustomerInfo : NSManagedObject

@property (nonatomic, retain) NSString * customerName;
@property (nonatomic, retain) NSNumber * cutomerID;
@property (nonatomic, retain) NSSet *calenderData;
@end

@interface CustomerInfo (CoreDataGeneratedAccessors)

- (void)addCalenderDataObject:(CalenderData *)value;
- (void)removeCalenderDataObject:(CalenderData *)value;
- (void)addCalenderData:(NSSet *)values;
- (void)removeCalenderData:(NSSet *)values;

@end
