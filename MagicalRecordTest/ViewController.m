//
//  ViewController.m
//  MagicalRecordTest
//
//  Created by oda yuma on 2014/09/17.
//  Copyright (c) 2014年 yuma oda. All rights reserved.
//

#import "ViewController.h"
#define MR_LOGGING_ENABLED 0
#define MR_ENABLE_ACTIVE_RECORD_LOGGING 0
#import "CoreData+MagicalRecord.h"
#import "Bike.h"
#import "User.h"


@interface ViewController ()
<UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //[self saveBySync];
    [self saveByAsync];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)saveBySync
{
    // 同期
    Bike *bike = [Bike MR_createEntity];
    bike.name = @"masa_bike";
    bike.comment = @"bad";
    bike.tag = @"america";
    bike.date = [NSDate date];
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];

    NSLog(@"count::%d", [[Bike MR_numberOfEntities] intValue]);
    NSArray *bikeArray = [Bike MR_findAll];
    [bikeArray enumerateObjectsUsingBlock:^(Bike *obj, NSUInteger idx, BOOL *stop) {
        NSLog(@"--------------------------");
        NSLog(@"bike_name::%@", obj.name);
        NSLog(@"bike_comment::%@", obj.comment);
        NSLog(@"bike_tag::%@", obj.tag);
    }];
}

-(void)saveByAsync
{
    // 非同期
    [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
        User *localUser = [User MR_createInContext:localContext];
        localUser.name = @"sama-zu";
        localUser.ageValue = 27;
        localUser.date = [NSDate date];
    } completion:^(BOOL success, NSError *error) {
        if (!success) {
            
        } else {
            NSLog(@"count::%d", [[User MR_numberOfEntities] intValue]);
            NSArray *bikeArray = [User MR_findAll];
            [bikeArray enumerateObjectsUsingBlock:^(User *obj, NSUInteger idx, BOOL *stop) {
                NSLog(@"--------------------------");
                NSLog(@"user_name::%@", obj.name);
                NSLog(@"user_age::%d", obj.ageValue);
            }];
            
            [self.tableView reloadData];
        }
    }];
}

-(void)configureCell:(UITableViewCell*)cell atIndexPath:(NSIndexPath*)indexPath
{
    User *user = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", user.name];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd 'at' HH:mm";
    NSString *dateStr = [formatter stringFromDate:user.date];
    cell.detailTextLabel.text = dateStr;
}

#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id<NSFetchedResultsSectionInfo>sectionInfo = self.fetchedResultsController.sections[section];
    return [sectionInfo numberOfObjects];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.fetchedResultsController.sections.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

#pragma mark - NSFetchedResultController

-(NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }

    self.fetchedResultsController = [User MR_fetchAllSortedBy:@"date,name"
                                                    ascending:NO
                                                withPredicate:nil
                                                      groupBy:nil
                                                     delegate:self
                                                    inContext:[NSManagedObjectContext MR_contextForCurrentThread]];
    return self.fetchedResultsController;
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView reloadData];
}

@end
