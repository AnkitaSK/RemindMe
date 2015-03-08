//
//  LeftPanelViewController.h
//  RemindMe
//
//  Created by Ankita Kalangutkar on 3/7/15.
//  Copyright (c) 2015 Ankita Kalangutkar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalenderData.h"

@protocol LeftPanelViewControllerDelegate <NSObject>

-(void)customerSelectedWithCalendarData:(CalenderData *)calendarData;

@end

@interface LeftPanelViewController : UIViewController
@property (weak,nonatomic) id<LeftPanelViewControllerDelegate>leftPanelViewControllerDelegate;
@end
