//
//  Restaurant.m
//  StaffManagement
//
//  Created by Derek Harasen on 2015-03-14.
//  Copyright (c) 2015 Derek Harasen. All rights reserved.
//

#import "Restaurant.h"



@implementation Restaurant

@dynamic name;
@dynamic staff;
@dynamic appDelegate;


- (void)removeStaffObject:(NSManagedObject *)value{
    NSLog(@"Attempt tp remove");
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSError *error = nil;
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    [context deleteObject:value];
    [appDelegate.managedObjectContext save:&error];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reload_data" object:self];
}


@end
