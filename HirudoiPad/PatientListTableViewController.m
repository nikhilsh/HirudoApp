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
    if (indexPath.row == 0) {
        cell.patientNameLabel.text = @"Jermaine Cheng";
        cell.patientDetailsLabel.text = [NSString stringWithFormat:@"%@,\n%@,\n%@", @"Gender: Male", @"Admitted Date: 2016-06-07", @"Ward: 1A"];
        cell.patientDetailsLabel.numberOfLines = 3;
    }
    else {
        cell.patientNameLabel.text = @"Francisco Caetano Dos Remedios Furtado";
        cell.patientDetailsLabel.text = [NSString stringWithFormat:@"%@,\n%@,\n%@", @"Gender: Male", @"Admitted Date: 2016-06-08", @"Ward: 8D"];
        cell.patientDetailsLabel.numberOfLines = 3;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *controller;
    if (indexPath.row == 0) {
        controller = [[MCAppRouter sharedInstance] viewControllerMatchingRoute:@"patient/list"];
    }
    else {
        controller = [[MCAppRouter sharedInstance] viewControllerMatchingRoute:@"doctor"];
    }
    [self.navigationController pushViewController:controller animated:YES];
}


@end
