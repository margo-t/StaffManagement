//
//  Waiter+CoreDataProperties.m
//  StaffManagement
//
//  Created by margot on 2018-01-30.
//  Copyright © 2018 Derek Harasen. All rights reserved.
//
//

#import "Waiter+CoreDataProperties.h"

@implementation Waiter (CoreDataProperties)

+ (NSFetchRequest<Waiter *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Waiter"];
}

@dynamic name;
@dynamic restaurant;
@dynamic toShift;

@end
