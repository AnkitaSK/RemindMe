//
//  ViewController.h
//  CalenderApp
//
//  Created by Ankita Kalangutkar on 3/7/15.
//  Copyright (c) 2015 Ankita Kalangutkar. All rights reserved.
//

#import "CalenderViewController.h"
#import "DBManager.h"

#define kHeaderHeight 1
#define kInterSectionMargin 1

int count = 0;

@interface CalenderViewController ()<UICollectionViewDataSource,UICollectionViewDelegate> {
    BOOL isDatesDisplayed;
    int starttingBlanks;
    BOOL isBlankSet;
    BOOL isMonthChanged;
    BOOL isItemDoubleTapped;
    BOOL isBeginningOfNewYear;
    BOOL isNewYearSet;
}

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic) NSInteger weekDay;
@property (nonatomic) NSInteger day;
@property (nonatomic) NSInteger daysInMonth;
@property (nonatomic) NSInteger todaysDay;
@property (nonatomic) NSInteger monthCount;
@property (nonatomic) int yearCount;
@property (strong,nonatomic) NSMutableArray *dataArray;
@property (strong,nonatomic) NSMutableArray *dayArray;
@property (strong,nonatomic) NSMutableArray *weekDaysArray;


@property (strong,nonatomic) NSDateComponents *originalDateComponent;
@property (strong,nonatomic) NSDateComponents *presentDateComponent;
@property (strong, nonatomic) IBOutlet UILabel *labelTitle;
@property (strong,nonatomic) CalenderData *calenderData;
@end

@implementation CalenderViewController

- (void)configureLayout {
    // Configure layout
    self.flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [self.flowLayout setItemSize:CGSizeMake(45, 45)];
    [self.flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    self.flowLayout.minimumInteritemSpacing = 0.0f;
    self.flowLayout.minimumLineSpacing = 1.0f;
    [self.calenderView setCollectionViewLayout:self.flowLayout];
    //    self.calenderView.bounces = YES;
    [self.calenderView setShowsHorizontalScrollIndicator:NO];
    [self.calenderView setShowsVerticalScrollIndicator:NO];
}

- (NSDateComponents *)generatingNewDateComponent:(NSDateComponents *)dateComponents {
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDate *newDate = [calendar dateFromComponents:dateComponents];
    
    NSDateComponents *beginningDateComponents =[self.calenderView beginningDateDetailFromDate:newDate];
    self.weekDay = beginningDateComponents.weekday;
    self.day  = beginningDateComponents.day;
    return dateComponents;
}

- (NSDateComponents *)beginningOfMonthDetailWithCurrentDate:(NSDate *)currentDate {
    NSDateComponents *dateComponents = [self.calenderView currentDateDetail:currentDate];
    self.todaysDay = dateComponents.day;
    
    [dateComponents setDay:(self.day - (self.day - 1))];
    
    NSDateComponents *newDateComponent = [self generatingNewDateComponent:dateComponents];
    return newDateComponent;
}

- (void)updateNavigationBarTitle:(NSDateComponents *)dateComponents {
    self.presentDateComponent = dateComponents;
    //    update title
    //    self.navigationController.navigationBar.topItem.title = [NSString stringWithFormat:@"%@ %ld",[self.calenderView currentMonthFromvalue:(int)dateComponents.month],(long)dateComponents.year];
    self.labelTitle.text = [NSString stringWithFormat:@"%@ %ld",[self.calenderView currentMonthFromvalue:(int)dateComponents.month],(long)dateComponents.year];
}

- (void)updatingDays:(NSDateComponents *)dateComponents {
    self.daysInMonth = [self.calenderView daysInMonth:dateComponents.month andYear:dateComponents.year];
    //    days
    if (!self.dayArray) {
        self.dayArray = [[NSMutableArray alloc] init];
    }
    else {
        [self.dayArray removeAllObjects];
    }
    
    for (int i=1; i<=self.daysInMonth; i++) {
        [self.dayArray addObject:[NSNumber numberWithInt:i]];
    }
    if (!self.dataArray) {
        self.dataArray = [[NSMutableArray alloc]init];
    }
    else {
        [self.dataArray removeAllObjects];
    }
    [self.dataArray addObjectsFromArray:@[self.weekDaysArray,self.dayArray]];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.selectedItems = [[NSMutableArray alloc] init];
    //    configure a cell layout
    [self configureLayout];
    
    //    get a month detail, inorder to display in a calender
    NSDateComponents *dateComponents;
    dateComponents = [self beginningOfMonthDetailWithCurrentDate:[NSDate date]];
    //    weekdays
    
    self.weekDaysArray = [[NSMutableArray alloc] initWithArray:@[@"Sun",@"Mon",@"Tue",@"Wed",@"Thur",@"Fri",@"Sat"]];
    
    [self updatingDays:dateComponents];
    
    //    register a custom cell
    UINib *cellNib = [UINib nibWithNibName:@"CustomCell" bundle:nil];
    [self.calenderView registerNib:cellNib forCellWithReuseIdentifier:@"cvCell"];
    
    self.calenderView.delegate = self;
    self.calenderView.dataSource = self;
    
    [self updateNavigationBarTitle:dateComponents];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

#pragma mark - UICollectionViewDataSource,UICollectionViewDelegate Methods
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    //    return 1;
    return self.dataArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return [[self.dataArray objectAtIndex:section] count];
    }
    else {
        return ([[self.dataArray objectAtIndex:section] count] + self.weekDay);
    }
    
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"cvCell";
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    UILabel *titleLabel = (UILabel *)[cell viewWithTag:100];
    
    
    if (indexPath.section == 0) {
        NSMutableArray *data = [self.dataArray objectAtIndex:indexPath.section];
        NSString *cellData = [data objectAtIndex:indexPath.row];
        
        [titleLabel setText:cellData];
    }
    else if (indexPath.section == 1) {
        for (CalenderData *data in self.selectedItems) {
            if ([data.itemNo integerValue] == indexPath.item && nil != data && !isItemDoubleTapped && [data.month integerValue] == self.presentDateComponent.month) {
                cell.backgroundColor = [UIColor redColor];
                //            isItemTapped = FALSE;
            }
            //            else {
            //                cell.backgroundColor = [UIColor whiteColor];
            //            }
        }
        
        {
            isItemDoubleTapped = NO;
            if (!isDatesDisplayed) {
                if (indexPath.item +1 == self.weekDay) {
                    if (indexPath.item + 1 == self.todaysDay + starttingBlanks && !isMonthChanged) {
                        cell.backgroundColor = [UIColor grayColor];
                    }
                    count = (int)self.day;
                    [titleLabel setText:[NSString stringWithFormat:@"%@",[self.dayArray objectAtIndex:count-1]]];
                    count ++;
                }
                else {
                    if (count > 0 && count< self.daysInMonth +1) {
                        isBlankSet = YES;
                        //                    add number of blank spaces inorder to get the current date
                        if (indexPath.item + 1 == self.todaysDay + starttingBlanks && !isMonthChanged) {
                            cell.backgroundColor = [UIColor grayColor];
                        }
                        
                        [titleLabel setText:[NSString stringWithFormat:@"%@",[self.dayArray objectAtIndex:count-1]]];
                        count ++;
                    }
                    else if (count >= self.daysInMonth +1) {
                        isDatesDisplayed = YES;
                        [titleLabel setText:@""];
                    }
                    else {
                        [titleLabel setText:@""];
                        
                        //                    count number of blank spaces in the beginning
                        if (!isBlankSet) {
                            starttingBlanks++;
                        }
                    }
                    
                }
            }
        }
        
    }
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return CGSizeMake(0, kHeaderHeight);
    }
    return CGSizeMake(0, kHeaderHeight + kInterSectionMargin);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSManagedObjectContext *context = [[DBManager sharedInstance] managedObjectContext];
    self.calenderData = [NSEntityDescription insertNewObjectForEntityForName:@"CalenderData" inManagedObjectContext:context];
    
    
    NSMutableArray *tempArray = [NSMutableArray array];
    for (CalenderData *data in self.selectedItems) {
        if (indexPath.item == [data.itemNo integerValue]) {
            [tempArray addObject:data];
        }
        else{
            isItemDoubleTapped = FALSE;
            
        }
    }
    if (tempArray.count >0) {
        isItemDoubleTapped = TRUE;
        [self.selectedItems removeObjectsInArray:tempArray];
    }
    //    isItemTapped = !isItemTapped;
    //    self.selectedItem = indexPath;
    if (!isItemDoubleTapped) {
        //        [self.selectedItems addObject:indexPath];
        
        self.calenderData.customerID = self.customerID;
        self.calenderData.day = [self.dayArray objectAtIndex:indexPath.item];
        self.calenderData.itemNo = [NSNumber numberWithInteger:indexPath.item];
        self.calenderData.month = [NSNumber numberWithInteger:self.presentDateComponent.month];
        self.calenderData.year = [NSNumber numberWithInteger:self.presentDateComponent.year];
        
        NSError *error;
        if (![context save:&error]) {
            NSLog(@"error while saving: %@",[error localizedDescription]);
        }
        
        [self.selectedItems addObject: self.calenderData];
    }
    
    [self reset];
    [collectionView reloadData];
}


#pragma mark - IBAction
- (NSDate *)nextYearDateWithYearCount:(int)yearCount {
    NSCalendar *calender = [NSCalendar currentCalendar];
    //        create January 01, 2014
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setYear:self.originalDateComponent.year];
    [components setMonth:1];
    [components setDay:1];
    NSDate *jan012014 = [calender dateFromComponents:components];
    
    //        increement the year by 1
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setYear:yearCount];
    
    NSDate *nextYear = [calender dateByAddingComponents:offsetComponents toDate:jan012014 options:0];
    return nextYear;
}

//- (IBAction)nextButtonPressed:(UIButton *)sender {
- (IBAction)nextButtonPressed:(id)sender {
    ++ self.monthCount;
    if (self.originalDateComponent.month == 12) {
        isNewYearSet = NO;
    }
    
    if (!isBeginningOfNewYear) {
        self.originalDateComponent = [self beginningOfMonthDetailWithCurrentDate:[NSDate date]];
        if (self.originalDateComponent.month + self.monthCount <= 12) {
            [self.originalDateComponent setMonth:self.originalDateComponent.month + self.monthCount];
            if (self.originalDateComponent.month + self.monthCount == 12) {
                isNewYearSet = NO;
            }
        }
        else if(!isNewYearSet){
            ++ self.yearCount;
            self.monthCount = 0;
            isBeginningOfNewYear = YES;
            NSDate *nextYear;
            nextYear = [self nextYearDateWithYearCount:self.yearCount];
            self.originalDateComponent = [self beginningOfMonthDetailWithCurrentDate:nextYear];
            
            isNewYearSet = YES;
        }
    }
    else {
        if (self.originalDateComponent.month < 12) {
            [self.originalDateComponent setMonth:self.originalDateComponent.month + 1];
        }
        else if (self.originalDateComponent.month == 12) {
            isNewYearSet = NO;
            ++self.yearCount;
            NSDate *nextYear;
            nextYear = [self nextYearDateWithYearCount:1];
            self.originalDateComponent = [self beginningOfMonthDetailWithCurrentDate:nextYear];
        }
    }
    
    //    generating a date component for a new date of next month
    NSDateComponents *nextMonthsDateComponent = [self generatingNewDateComponent:self.originalDateComponent];
    [self updateNavigationBarTitle:nextMonthsDateComponent];
    
    //    get todays date
    NSDateComponents *currentDateComponent = [self.calenderView currentDateDetail:[NSDate date]];
    if ((currentDateComponent.month == nextMonthsDateComponent.month) && (currentDateComponent.weekday == nextMonthsDateComponent.weekday)) {
        self.todaysDay = currentDateComponent.day;
        isMonthChanged = FALSE;
    }
    else {
        self.todaysDay = 0;
        isMonthChanged = TRUE;
    }
    
    
    [self reset];
    
    [self updatingDays:nextMonthsDateComponent];
    [self.calenderView reloadData];
}


//}

- (void)reset {
    isDatesDisplayed = FALSE;
    isBlankSet = FALSE;
    count = 0;
    starttingBlanks = 0;
}
- (IBAction)previousButtonPressed:(id)sender {
    -- self.monthCount;
    if (self.originalDateComponent.month == 12) {
        isNewYearSet = NO;
    }
    
    if (!isBeginningOfNewYear) {
        self.originalDateComponent = [self beginningOfMonthDetailWithCurrentDate:[NSDate date]];
        if (self.originalDateComponent.month + self.monthCount <= 12) {
            [self.originalDateComponent setMonth:self.originalDateComponent.month + self.monthCount];
            if (self.originalDateComponent.month + self.monthCount == 12) {
                isNewYearSet = NO;
            }
        }
        else if(!isNewYearSet){
            -- self.yearCount;
            self.monthCount = 0;
            isBeginningOfNewYear = YES;
            NSDate *nextYear;
            nextYear = [self nextYearDateWithYearCount:self.yearCount];
            self.originalDateComponent = [self beginningOfMonthDetailWithCurrentDate:nextYear];
            
            isNewYearSet = YES;
        }
    }
    else {
        if (self.originalDateComponent.month < 12) {
            [self.originalDateComponent setMonth:self.originalDateComponent.month + 1];
        }
        else if (self.originalDateComponent.month == 12) {
            isNewYearSet = NO;
            -- self.yearCount;
            NSDate *nextYear;
            nextYear = [self nextYearDateWithYearCount:1];
            self.originalDateComponent = [self beginningOfMonthDetailWithCurrentDate:nextYear];
        }
    }
    
    //    generating a date component for a new date of next month
    NSDateComponents *previousMonthsDateComponent = [self generatingNewDateComponent:self.originalDateComponent];
    [self updateNavigationBarTitle:previousMonthsDateComponent];
    
    //    get todays date
    NSDateComponents *currentDateComponent = [self.calenderView currentDateDetail:[NSDate date]];
    if ((currentDateComponent.month == previousMonthsDateComponent.month) && (currentDateComponent.weekday == previousMonthsDateComponent.weekday)) {
        self.todaysDay = currentDateComponent.day;
        isMonthChanged = FALSE;
    }
    else {
        self.todaysDay = 0;
        isMonthChanged = TRUE;
    }
    
    
    [self reset];
    
    [self updatingDays:previousMonthsDateComponent];
    [self.calenderView reloadData];
}

//- (IBAction)previousButtonPressed:(UIButton *)sender {


//}
- (IBAction)barButtonSlideClicked:(UIBarButtonItem *)sender {
    [self reset];
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
