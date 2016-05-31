//
//  PatientViewTableViewController.m
//  HirudoApp
//
//  Created by Nikhil Sharma on 31/5/16.
//  Copyright © 2016 Nikhil Sharma. All rights reserved.
//

#import "PatientViewTableViewController.h"
#import "Client.h"
#import "Patient.h"
#import "PatientTableViewCell.h"

static NSString *const HealthDataViewCell = @"HealthDataViewCell";

@interface PatientViewTableViewController ()

@property (strong, nonatomic) NSArray *patients;

@end

@implementation PatientViewTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[Client sharedInstance] retrievePatients:^(NSError *error, NSArray *patients) {
        self.patients = [patients copy];
        [self.tableView reloadData];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PatientTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:HealthDataViewCell forIndexPath:indexPath];
    cell.patient = self.patients[indexPath.row];
    
    
    if (indexPath.row == 1) {
        cell.title = @"Temperature";
    }
    
    
    
    
    return cell;
}

@end
