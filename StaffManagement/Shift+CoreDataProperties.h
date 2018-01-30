//
//  Shift+CoreDataProperties.h
//  StaffManagement
//
//  Created by margot on 2018-01-29.
//  Copyright © 2018 Derek Harasen. All rights reserved.
//
//

#import "Shift+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Shift (CoreDataProperties)

+ (NSFetchRequest<Shift *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSDate *startTime;
@property (nullable, nonatomic, copy) NSDate *endTime;
@property (nullable, nonatomic, retain) Waiter *toWaiter;

@end

NS_ASSUME_NONNULL_END
