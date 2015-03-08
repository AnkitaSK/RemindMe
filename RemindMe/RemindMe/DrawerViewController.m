//
//  DrawerViewController.m
//  RemindMe
//
//  Created by Ankita Kalangutkar on 3/7/15.
//  Copyright (c) 2015 Ankita Kalangutkar. All rights reserved.
//

#import "DrawerViewController.h"
#import "CalenderViewController.h"
#import "LeftPanelViewController.h"
#import "CalenderData.h"

#define DRAWER_WIDTH    240

@interface DrawerViewController ()<CalenderViewControllerDelegate,LeftPanelViewControllerDelegate>
@property (strong, nonatomic) IBOutlet UIView *containerLeftPanelView;
@property (strong, nonatomic) IBOutlet UIView *containerRightPanelView;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *barButtonSlide;

@property (strong,nonatomic) CalenderViewController *centerViewController;
@property (strong,nonatomic) LeftPanelViewController *leftPanelViewController;
//@property (strong,nonatomic) CalenderData *calData;

- (IBAction)slideDrawerBarButtonClicked:(UIBarButtonItem *)sender;
@end

@implementation DrawerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"%@", segue.identifier);
    if ([segue.identifier isEqualToString:@"CenterViewSegue"])
    {   UINavigationController *navigationController = [segue destinationViewController];
        
        for (UIViewController *viewConntroller in navigationController.viewControllers)
        {
            if ([viewConntroller isKindOfClass:[CalenderViewController class]])
            {
                self.centerViewController =(CalenderViewController *) viewConntroller;
                self.centerViewController.centerViewControllerDelegate = self;
            }
            
        }
        
        
    }
    
    if ([segue.identifier isEqualToString:@"LeftPanelViewSegue"])
    {
        self.leftPanelViewController =(LeftPanelViewController *) [segue destinationViewController];
        self.leftPanelViewController.leftPanelViewControllerDelegate = self;
    }
}

#pragma mark - CalenderViewControllerDelegate Methods
-(void) movePanelToRight {
    
//    self.transparentView.frame = CGRectMake(0, 0, self.mainContainerView.frame.size.width, self.mainContainerView.frame.size.height);
//    
//    [self.mainContainerView addSubview:self.transparentView];
    
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.containerLeftPanelView.frame = CGRectMake(0, 0, DRAWER_WIDTH, self.containerLeftPanelView.frame.size.height);
                         self.containerRightPanelView.frame = CGRectMake(DRAWER_WIDTH, self.containerRightPanelView.frame.origin.y, self.containerRightPanelView.frame.size.width, self.containerRightPanelView.frame.size.height);
                         
                         //Apply shadow border
                         [self.containerLeftPanelView.layer setBorderWidth:0.5];
                         [self.containerLeftPanelView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
                         
                     }
                     completion:^(BOOL finished){
                         //
                     }];
    
    self.centerViewController.barButtonSlide.tag = 1;
}

-(void) movePanelToOriginal {
//    [self.settingsViewController.userNameTextField resignFirstResponder];
//    
//    [self.transparentView removeFromSuperview];
    
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.containerLeftPanelView.frame = CGRectMake(0, 0, 0, self.containerLeftPanelView.frame.size.height);
                         self.containerRightPanelView.frame = CGRectMake(0, self.containerRightPanelView.frame.origin.y, self.containerRightPanelView.frame.size.width, self.containerRightPanelView.frame.size.height);
                     }
                     completion:^(BOOL finished){
                         
                         
                         //Remove  border
                         [self.containerLeftPanelView.layer setBorderWidth:0.0];
                         
                     }];
    
    self.centerViewController.barButtonSlide.tag = 0;
}

#pragma mark - LeftPanelViewControllerDelegate Methods
-(void)customerSelectedWithCalendarData:(NSArray *)calendarDataArray {
    CalenderData *data = [calendarDataArray objectAtIndex:0];
    self.centerViewController.customerID = data.customerID;
    if (self.centerViewController.selectedItems >0) {
        [self.centerViewController.selectedItems removeAllObjects];
    }
    [self.centerViewController.selectedItems addObjectsFromArray:calendarDataArray];
    [self movePanelToOriginal];
    [self.centerViewController.calenderView reloadData];
}
@end
