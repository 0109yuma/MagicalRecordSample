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
<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self saveBySync];
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
        localUser.name = @"tanaka";
        localUser.ageValue = 24;
        
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
        }
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    return cell;
}

@end
