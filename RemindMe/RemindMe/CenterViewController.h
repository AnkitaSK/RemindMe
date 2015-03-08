//
//  CenterViewController.h
//  RemindMe
//
//  Created by Ankita Kalangutkar on 3/7/15.
//  Copyright (c) 2015 Ankita Kalangutkar. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CenterViewControllerDelegate <NSObject>
- (void)movePanelToRight;
-(void)movePanelToOriginal;
@end

@interface CenterViewController : UIViewController
@property (weak,nonatomic) id<CenterViewControllerDelegate> centerViewControllerDelegate;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *barButtonSlide;
@end
