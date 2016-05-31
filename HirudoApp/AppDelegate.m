//
//  AppDelegate.m
//  HirudoApp
//
//  Created by Nikhil Sharma on 27/5/16.
//  Copyright © 2016 Nikhil Sharma. All rights reserved.
//

#import "AppDelegate.h"
#import <MCAppRouter.h>
#import <Jibber/JibberClient.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)setupViewControllerRoutes {
    [[MCAppRouter sharedInstance] mapRoute:@"patient/list" toViewControllerInStoryboardWithName:@"Main" withIdentifer:@"PatientViewTableViewController"];
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self setupViewControllerRoutes];
    [JibberClient sharedInstance].connectionMode = JibberClientTetheredConnection;
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {

}

- (void)applicationDidEnterBackground:(UIApplication *)application {

}

- (void)applicationWillEnterForeground:(UIApplication *)application {

}

- (void)applicationDidBecomeActive:(UIApplication *)application {

}

- (void)applicationWillTerminate:(UIApplication *)application {

}

@end
