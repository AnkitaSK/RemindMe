//
//  LeftPanelViewController.m
//  RemindMe
//
//  Created by Ankita Kalangutkar on 3/7/15.
//  Copyright (c) 2015 Ankita Kalangutkar. All rights reserved.
//

#import "LeftPanelViewController.h"
#import "DBManager.h"
#import "CalenderData.h"
#import "CustomerInfo.h"

@interface LeftPanelViewController ()<UITableViewDataSource,UITabBarDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableviewCustomer;
@property (strong,nonatomic) NSArray *customerInfoArray;
@end

@implementation LeftPanelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.customerInfoArray = [[NSArray alloc] init];

//    connect to parse and fetch from parse
    
//    store it in a db
    NSManagedObjectContext *context = [[DBManager sharedInstance] managedObjectContext];
    CustomerInfo *customerInfo1 = [NSEntityDescription insertNewObjectForEntityForName:@"CustomerInfo" inManagedObjectContext:context];
    customerInfo1.customerName = @"Ankita";
    customerInfo1.cutomerID = @1;
    
    CustomerInfo *customerInfo2 = [NSEntityDescription insertNewObjectForEntityForName:@"CustomerInfo" inManagedObjectContext:context];
    customerInfo2.customerName = @"Pranita";
    customerInfo2.cutomerID = @2;
    
    CalenderData *calenderData1 = [NSEntityDescription insertNewObjectForEntityForName:@"CalenderData" inManagedObjectContext:context];
    calenderData1.customerID = @1;
    calenderData1.day = @10;
    calenderData1.month = @3;
    calenderData1.year = @2015;
    
    CalenderData *calenderData2 = [NSEntityDescription insertNewObjectForEntityForName:@"CalenderData" inManagedObjectContext:context];
    calenderData2.customerID = @2;
    calenderData2.day = @12;
    calenderData2.month = @3;
    calenderData2.year = @2015;
    
    
    //save context
    NSError *error;
    if (![context save:&error]) {
        NSLog(@"error while saving: %@",[error localizedDescription]);
    }

//    fetch it from db
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription * entity = [NSEntityDescription entityForName:@"CustomerInfo" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSError *err;
    self.customerInfoArray = [context executeFetchRequest:fetchRequest error:&err];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.customerInfoArray.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    CustomerInfo *info = [self.customerInfoArray objectAtIndex:indexPath.row];
    cell.textLabel.text = info.customerName;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
