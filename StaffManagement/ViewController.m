//
//  ViewController.m
//  StaffManagement
//
//  Created by Derek Harasen on 2015-03-14.
//  Copyright (c) 2015 Derek Harasen. All rights reserved.
//

#import "ViewController.h"
#import "Restaurant.h"
#import "RestaurantManager.h"
#import "Waiter.h"
#import "AddWaiterVC.h"


static NSString * const kCellIdentifier = @"CellIdentifier";


@interface ViewController ()
@property IBOutlet UITableView *tableView;
@property (nonatomic, retain) NSArray *waiters;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"viewDidLoad");
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellIdentifier];
    NSSortDescriptor *sortByName = [[NSSortDescriptor alloc]initWithKey:@"name" ascending:YES];
    self.waiters = [[[RestaurantManager sharedManager]currentRestaurant].staff sortedArrayUsingDescriptors:@[sortByName]];
    NSLog(@"%lu", (unsigned long)self.waiters.count);
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - TableView Data Source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.waiters.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];
    Waiter *waiter = self.waiters[indexPath.row];
    cell.textLabel.text = waiter.name;
    
    return cell;
}



//swipe to delete data

-(NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewRowAction *button = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"Delete" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath)
                                    {
                                        NSLog(@"Action to perform with Button 1");
                                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Wait" message:@"Are you sure you want to delete?  This action cannot be undone." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Delete", nil];
                                        [alert show];
                                    }];
    button.backgroundColor = [UIColor redColor];

    return @[button]; //array with the buttons
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1){
        //delete it
        
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES; //tableview must be editable
}



@end
