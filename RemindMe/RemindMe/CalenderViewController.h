//
//  ViewController.h
//  CalenderApp
//
//  Created by Ankita Kalangutkar on 3/7/15.
//  Copyright (c) 2015 Ankita Kalangutkar. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CalenderViewControllerDelegate <NSObject>
- (void)movePanelToRight;
-(void)movePanelToOriginal;
@end

@interface CalenderViewController : UIViewController
@property (weak,nonatomic) id<CalenderViewControllerDelegate> centerViewControllerDelegate;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *barButtonSlide;

@end

