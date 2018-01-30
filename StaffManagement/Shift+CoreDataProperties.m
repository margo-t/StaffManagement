//
//  Shift+CoreDataProperties.m
//  StaffManagement
//
//  Created by margot on 2018-01-29.
//  Copyright © 2018 Derek Harasen. All rights reserved.
//
//

#import "Shift+CoreDataProperties.h"

@implementation Shift (CoreDataProperties)

+ (NSFetchRequest<Shift *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Shift"];
}

@dynamic startTime;
@dynamic endTime;
@dynamic toWaiter;

@end
