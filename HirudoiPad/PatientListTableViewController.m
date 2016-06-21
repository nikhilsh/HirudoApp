//
//  PatientListTableViewController.m
//  HirudoiPad
//
//  Created by Nikhil Sharma on 20/6/16.
//  Copyright © 2016 Nikhil Sharma. All rights reserved.
//

#import "PatientListTableViewController.h"
#import "PatientTableViewCell.h"
#import <MCAppRouter.h>

@interface PatientListTableViewController ()

@end

@implementation PatientListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Meech";
//    [self.navigationController.navigationBar setTitleTextAttributes:@{
//       NSFontAttributeName:[UIFont fontWithName:@"AvenirNext-Medium" size:21]}];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PatientTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PatientCell" forIndexPath:indexPath];
    UIViewController *controller;
    if (indexPath.row == 0) {
        controller = [[MCAppRouter sharedInstance] viewControllerMatchingRoute:@"patient/list"];
    }
    else {
        controller = [[MCAppRouter sharedInstance] viewControllerMatchingRoute:@"doctor"];
    }
    
    [self.navigationController pushViewController:controller animated:YES];
    // Configure the cell...
    
    return cell;
}


@end
