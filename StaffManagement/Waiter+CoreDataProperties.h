//
//  Waiter+CoreDataProperties.h
//  StaffManagement
//
//  Created by margot on 2018-01-30.
//  Copyright © 2018 Derek Harasen. All rights reserved.
//
//

#import "Waiter+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Waiter (CoreDataProperties)

+ (NSFetchRequest<Waiter *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, retain) Restaurant *restaurant;
@property (nullable, nonatomic, retain) NSSet<Shift *> *toShift;

@end

@interface Waiter (CoreDataGeneratedAccessors)

- (void)addToShiftObject:(Shift *)value;
- (void)removeToShiftObject:(Shift *)value;
- (void)addToShift:(NSSet<Shift *> *)values;
- (void)removeToShift:(NSSet<Shift *> *)values;

@end

NS_ASSUME_NONNULL_END
