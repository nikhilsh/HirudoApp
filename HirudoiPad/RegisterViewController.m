//
//  RegisterViewController.m
//  HirudoiPad
//
//  Created by Nikhil Sharma on 28/7/16.
//  Copyright © 2016 Nikhil Sharma. All rights reserved.
//

#import "RegisterViewController.h"
#import "Client.h"
#import <MCAppRouter.h>

@interface RegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *doctorNurseSegmentedControl;
@property (weak, nonatomic) IBOutlet UISegmentedControl *maleFemaleSegmentedControl;
@property (weak, nonatomic) IBOutlet UITextField *teamIDTextField;

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
    
    [[Client sharedInstance] registerDoctorWithUser:self.usernameTextField.text withPassword:self.passwordTextField.text withName:self.nameTextField.text withRole:role withGender:gender withTeamID:[self.teamIDTextField.text intValue] withCompletionHander:^(NSError *error) {
        UIViewController *controller = [[MCAppRouter sharedInstance] viewControllerMatchingRoute:@"patient/list/nav"];
        [UIView transitionWithView:[[self view] window] duration:[[self view] window].rootViewController != nil ? 0.4 : 0 options:UIViewAnimationOptionTransitionFlipFromLeft animations: ^{
            [[self view] window].rootViewController = controller;
        } completion:nil];
    }];
}

- (IBAction)handleLoginButton:(id)sender {
    UIViewController *controller = [[MCAppRouter sharedInstance] viewControllerMatchingRoute:@"login"];
    [UIView transitionWithView:[[self view] window] duration:[[self view] window].rootViewController != nil ? 0.4 : 0 options:UIViewAnimationOptionTransitionFlipFromLeft animations: ^{
        [[self view] window].rootViewController = controller;
    } completion:nil];
}


@end
