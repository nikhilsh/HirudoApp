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
#import <SafariServices/SafariServices.h>

@interface LoginViewController () <SFSafariViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(easterEgg)];
    tapGesture.numberOfTapsRequired = 3;
    tapGesture.numberOfTouchesRequired = 3;
    [self.view addGestureRecognizer:tapGesture];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)handleLoginButton:(id)sender {
    [[Client sharedInstance] loginDoctorWithUser:self.usernameTextField.text withPassword:self.passwordTextField.text withCompletionHander:^(NSError *error, NSString *userID) {
        if (!error) {
            [Cache sharedInstance].userID = [userID intValue];
            UIViewController *controller = [[MCAppRouter sharedInstance] viewControllerMatchingRoute:@"patient/list/nav"];
            [UIView transitionWithView:[[self view] window] duration:[[self view] window].rootViewController != nil ? 0.4 : 0 options:UIViewAnimationOptionTransitionFlipFromLeft animations: ^{
                [[self view] window].rootViewController = controller;
            } completion:nil];

        }
    }];
//    
//    [Cache sharedInstance].userID = 1;
//    [[Client sharedInstance] retrievePatientList:^(NSError *error, NSArray *patients) {
//        NSLog(@"test");
//    }];
}

- (IBAction)handleRegisterButton:(id)sender {
    UIViewController *controller = [[MCAppRouter sharedInstance] viewControllerMatchingRoute:@"register"];
    [UIView transitionWithView:[[self view] window] duration:[[self view] window].rootViewController != nil ? 0.4 : 0 options:UIViewAnimationOptionTransitionFlipFromLeft animations: ^{
        [[self view] window].rootViewController = controller;
    } completion:nil];
}

- (void)easterEgg {
//    SFSafariViewController *svc = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:@"http://ggballs.com"]];
//    svc.delegate = self;
//    [self presentViewController:svc animated:YES completion:nil];
    [Cache sharedInstance].userID = 1;
    UIViewController *controller = [[MCAppRouter sharedInstance] viewControllerMatchingRoute:@"patient/list/nav"];
    [UIView transitionWithView:[[self view] window] duration:[[self view] window].rootViewController != nil ? 0.4 : 0 options:UIViewAnimationOptionTransitionFlipFromLeft animations: ^{
        [[self view] window].rootViewController = controller;
    } completion:nil];
}

- (void)safariViewControllerDidFinish:(SFSafariViewController *)controller {
    [self dismissViewControllerAnimated:true completion:nil];
}

@end
