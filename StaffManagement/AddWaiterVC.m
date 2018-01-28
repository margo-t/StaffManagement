//
//  AddWaiterVC.m
//  StaffManagement
//
//  Created by margot on 2018-01-26.
//  Copyright © 2018 Derek Harasen. All rights reserved.
//

#import "AddWaiterVC.h"

#import "Waiter.h"
#import "Restaurant.h"
#import "ViewController.h"

@interface AddWaiterVC ()

@property (weak, nonatomic) IBOutlet UITextField *nameField;
- (IBAction)saveBtn:(id)sender;


@end

@implementation AddWaiterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (IBAction)saveBtn:(id)sender {
    
NSError *error = nil;
    
    if (![_nameField.text isEqualToString:@""]) {
        
        NSEntityDescription *restaurantEntity = [NSEntityDescription entityForName:@"Restaurant" inManagedObjectContext:_appDelegate.managedObjectContext];
        NSEntityDescription *waiterEntity = [NSEntityDescription entityForName:@"Waiter" inManagedObjectContext:_appDelegate.managedObjectContext];
        
        Restaurant *aRestaurant = [[Restaurant alloc] initWithEntity:restaurantEntity insertIntoManagedObjectContext:_appDelegate.managedObjectContext];
        Waiter *initialWaiter = [[Waiter alloc] initWithEntity:waiterEntity insertIntoManagedObjectContext:_appDelegate.managedObjectContext];
        initialWaiter.name = _nameField.text;
        NSLog(@"COME TO SAVING");
        [aRestaurant addStaffObject:initialWaiter];
        [_appDelegate.managedObjectContext save:&error];
        
        _nameField.text =@"";

        UIViewController * lvc = (UIViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"MainViewController"];
        [self.navigationController pushViewController:lvc animated:YES];
        
        
        
    }else{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Warning" message:@"All fields must contain text" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"oK" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:nil];
        
    }
}
@end
