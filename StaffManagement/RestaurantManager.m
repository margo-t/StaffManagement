//
//  RestaurantManager.m
//  StaffManagement
//
//  Created by Derek Harasen on 2015-03-14.
//  Copyright (c) 2015 Derek Harasen. All rights reserved.
//

#import "RestaurantManager.h"
#import "AppDelegate.h"
#import "Waiter.h"
#import "Restaurant.h"
@interface RestaurantManager()
@property (nonatomic, retain) Restaurant *restaurant;
@end

@implementation RestaurantManager
+ (id)sharedManager {
    static RestaurantManager *sharedManager = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}
-(Restaurant*)currentRestaurant{
    if(self.restaurant == nil)
    {
        NSLog(@"restaurant == nil");
        Restaurant *aRestaurant;
        NSError *error = nil;
        AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
        NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"Restaurant"];
        NSArray *results = [appDelegate.managedObjectContext executeFetchRequest:request error:&error];
        
        

        if(results.count > 0){
            NSLog(@"results.count > 0?");
            NSLog(@"%lu", (unsigned long)results.count);
            aRestaurant = results[0];
        
        }
        else{
            NSLog(@"results.count NOT > 0?");
            NSEntityDescription *restaurantEntity = [NSEntityDescription entityForName:@"Restaurant" inManagedObjectContext:appDelegate.managedObjectContext];
            NSEntityDescription *waiterEntity = [NSEntityDescription entityForName:@"Waiter" inManagedObjectContext:appDelegate.managedObjectContext];
            aRestaurant = [[Restaurant alloc] initWithEntity:restaurantEntity insertIntoManagedObjectContext:appDelegate.managedObjectContext];
            
            Waiter *initialWaiter = [[Waiter alloc]initWithEntity:waiterEntity insertIntoManagedObjectContext:appDelegate.managedObjectContext];
            initialWaiter.name = NSLocalizedString(@"John Smith", nil);
            [aRestaurant addStaffObject:initialWaiter];
            [appDelegate.managedObjectContext save:&error];
        }
        self.restaurant = aRestaurant;
    }
    return self.restaurant;
}
@end
