//
//  LoginViewController.m
//  HirudoiPad
//
//  Created by Nikhil Sharma on 28/7/16.
//  Copyright © 2016 Nikhil Sharma. All rights reserved.
//

#import "LoginViewController.h"
#import "Cache.h"
#import "Client.h"
#import <MCAppRouter.h>

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)handleLoginButton:(id)sender {
    [[Client sharedInstance] loginDoctorWithUser:self.usernameTextField.text withPassword:self.passwordTextField.text withCompletionHander:^(NSError *error, NSString *userID) {
        [Cache sharedInstance].userID = [userID intValue];
        UIViewController *controller = [[MCAppRouter sharedInstance] viewControllerMatchingRoute:@"patient/list/nav"];
        [UIView transitionWithView:[[self view] window] duration:[[self view] window].rootViewController != nil ? 0.4 : 0 options:UIViewAnimationOptionTransitionFlipFromLeft animations: ^{
            [[self view] window].rootViewController = controller;
        } completion:nil];
    }];
}

- (IBAction)handleRegisterButton:(id)sender {
    UIViewController *controller = [[MCAppRouter sharedInstance] viewControllerMatchingRoute:@"register"];
    [UIView transitionWithView:[[self view] window] duration:[[self view] window].rootViewController != nil ? 0.4 : 0 options:UIViewAnimationOptionTransitionFlipFromLeft animations: ^{
        [[self view] window].rootViewController = controller;
    } completion:nil];
}

@end
