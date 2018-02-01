//
//  Waiter+CoreDataClass.h
//  StaffManagement
//
//  Created by margot on 2018-01-30.
//  Copyright © 2018 Derek Harasen. All rights reserved.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Restaurant, Shift;

NS_ASSUME_NONNULL_BEGIN

@interface Waiter : NSManagedObject

@end

NS_ASSUME_NONNULL_END

#import "Waiter+CoreDataProperties.h"
