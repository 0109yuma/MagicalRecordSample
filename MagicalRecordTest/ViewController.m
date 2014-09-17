//
//  ViewController.m
//  MagicalRecordTest
//
//  Created by oda yuma on 2014/09/17.
//  Copyright (c) 2014年 yuma oda. All rights reserved.
//

#import "ViewController.h"
#import "CoreData+MagicalRecord.h"
#import "Bike.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self saveBySync];
    [self saveByAsync];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)saveBySync
{
    // 同期
    Bike *bike = [Bike MR_createEntity];
    bike.name = @"kana_bike";
    bike.comment = @"bad";
    bike.tag = @"america";
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];

    NSLog(@"count::%d", [[Bike MR_numberOfEntities] intValue]);
    NSArray *bikeArray = [Bike MR_findAll];
    [bikeArray enumerateObjectsUsingBlock:^(Bike *obj, NSUInteger idx, BOOL *stop) {
        NSLog(@"--------------------------");
        NSLog(@"name::%@", obj.name);
        NSLog(@"comment::%@", obj.comment);
        NSLog(@"tag::%@", obj.tag);
    }];
}

-(void)saveByAsync
{
    // 非同期
    [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
        Bike *localBike = [Bike MR_createInContext:localContext];
        localBike.name = @"tanaka";
        localBike.comment = @"wonderful";
        localBike.tag = @"korea";
        
    } completion:^(BOOL success, NSError *error) {
        if (!success) {
            
        } else {
            NSLog(@"count::%d", [[Bike MR_numberOfEntities] intValue]);
            NSArray *bikeArray = [Bike MR_findAll];
            [bikeArray enumerateObjectsUsingBlock:^(Bike *obj, NSUInteger idx, BOOL *stop) {
                NSLog(@"--------------------------");
                NSLog(@"name::%@", obj.name);
                NSLog(@"comment::%@", obj.comment);
                NSLog(@"tag::%@", obj.tag);
            }];
        }
    }];
}

@end
