//
//  RegisterViewController.m
//  HirudoiPad
//
//  Created by Nikhil Sharma on 28/7/16.
//  Copyright © 2016 Nikhil Sharma. All rights reserved.
//

#import "RegisterViewController.h"
#import "Client.h"

@interface RegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *doctorNurseSegmentedControl;
@property (weak, nonatomic) IBOutlet UISegmentedControl *maleFemaleSegmentedControl;
@property (weak, nonatomic) IBOutlet UITextField *teamIDTextField;
@property (weak, nonatomic) IBOutlet UITextField *workIDTextField;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)handleSignUpButton:(id)sender {
    NSString *role;
    NSString *gender;
    if (self.doctorNurseSegmentedControl.selectedSegmentIndex == 0) {
        role = @"d";
    }
    else {
        role = @"n";
    }
    if (self.maleFemaleSegmentedControl.selectedSegmentIndex == 0) {
        gender = @"m";
    }
    else {
        gender = @"f";
    }
    
    [[Client sharedInstance] registerDoctorWithUser:self.usernameTextField.text withPassword:self.passwordTextField.text withName:self.nameTextField.text withRole:role withGender:gender withTeamID:[self.teamIDTextField.text intValue] withWorkID:[self.workIDTextField.text intValue] withCompletionHander:^(NSError *error, NSArray *patients) {
        NSLog(@"signed up");
    }];
}

@end
