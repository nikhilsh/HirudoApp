//
//  PatientListTableViewController.m
//  HirudoiPad
//
//  Created by Nikhil Sharma on 20/6/16.
//  Copyright © 2016 Nikhil Sharma. All rights reserved.
//

#import "PatientListTableViewController.h"
#import "PatientTableViewCell.h"
#import "DoctorViewController.h"
#import <MCAppRouter.h>
#import "Cache.h"
#import "Client.h"

@interface PatientListTableViewController ()

@property (strong, nonatomic) NSArray *patientListArray;

@end

@implementation PatientListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = [Cache sharedInstance].doctorName;
    
    [[Client sharedInstance] retrievePatientList:^(NSError *error, NSArray *patients) {
        self.patientListArray = [patients copy];
        [self.tableView reloadData];
    }];

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
    return self.patientListArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PatientTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PatientCell" forIndexPath:indexPath];
    Patient *patient = self.patientListArray[indexPath.row];
    cell.patientNameLabel.text = patient.name;
    cell.patientDetailsLabel.text = [NSString stringWithFormat:@"Gender: %@\nAdmitted Date: %@\nWard: %i", [patient.gender isEqualToString:@"m"] ? @"Male" : @"Female" , patient.admittedDate, patient.wardID];
//    if (indexPath.row == 0) {
//        cell.patientNameLabel.text = @"Jermaine Cheng";
//        cell.patientDetailsLabel.text = [NSString stringWithFormat:@"%@\n%@\n%@", @"Gender: Male", @"Admitted Date: 2016-06-07", @"Ward: 1A"];
//        cell.patientDetailsLabel.numberOfLines = 3;
//    }
//    else {
//        cell.patientNameLabel.text = @"Francisco Caetano Dos Remedios Furtado";
//        cell.patientDetailsLabel.text = [NSString stringWithFormat:@"%@\n%@\n%@", @"Gender: Male", @"Admitted Date: 2016-06-08", @"Ward: 8D"];
//        cell.patientDetailsLabel.numberOfLines = 3;
//    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DoctorViewController *controller = [[MCAppRouter sharedInstance] viewControllerMatchingRoute:@"doctor"];
    Patient *patient = self.patientListArray[indexPath.row];
    controller.pid = [patient.patientID intValue];
    [self.navigationController pushViewController:controller animated:YES];
}


@end
