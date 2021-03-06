//
//  AddWaiterVC.m
//  StaffManagement
//
//  Created by margot on 2018-01-26.
//  Copyright © 2018 Derek Harasen. All rights reserved.
//

#import "AddWaiterVC.h"

#import "Waiter+CoreDataClass.h"
#import "Restaurant.h"
#import "ViewController.h"
#import "RestaurantManager.h"


@interface AddWaiterVC ()

@property (nonatomic, retain) Restaurant *currentRes;
@property (weak, nonatomic) IBOutlet UITextField *nameField;
- (IBAction)saveBtn:(id)sender;


@end

@implementation AddWaiterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    _currentRes = [[RestaurantManager sharedManager]currentRestaurant];

}

- (IBAction)saveBtn:(id)sender {
    
NSError *error = nil;
    
    if (![_nameField.text isEqualToString:@""]) {
        
        NSEntityDescription *waiterEntity = [NSEntityDescription entityForName:@"Waiter" inManagedObjectContext:_appDelegate.managedObjectContext];
        Restaurant *aRestaurant = _currentRes;
        
        //add waiter object
        Waiter *newWaiter = [[Waiter alloc] initWithEntity:waiterEntity insertIntoManagedObjectContext:_appDelegate.managedObjectContext];
        newWaiter.name = _nameField.text;
        
        //add waiter to current restaurant
        [aRestaurant addStaffObject:newWaiter];
    
        [_appDelegate.managedObjectContext save:&error];
        _nameField.text =@"";
        
        //send notification to update the view
        [[NSNotificationCenter defaultCenter] postNotificationName:@"reload_data" object:self];
        [self.navigationController popToRootViewControllerAnimated:YES];
        
        
        
    }else{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Warning" message:@"All fields must contain text" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"oK" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:nil];
        
    }
}
@end
