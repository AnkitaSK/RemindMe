//
//  CenterViewController.m
//  RemindMe
//
//  Created by Ankita Kalangutkar on 3/7/15.
//  Copyright (c) 2015 Ankita Kalangutkar. All rights reserved.
//

#import "CenterViewController.h"

@interface CenterViewController ()
- (IBAction)barButtonSlideClicked:(UIBarButtonItem *)sender;

@end

@implementation CenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)barButtonSlideClicked:(UIBarButtonItem *)sender {
    switch (sender.tag) {
        case 0:
            [self.centerViewControllerDelegate movePanelToRight];
            break;
            
        case 1:
            [self.centerViewControllerDelegate movePanelToOriginal];
            break;
            
        default:
            break;
    }
}
@end
