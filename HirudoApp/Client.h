//
//  Client.h
//  HagglePit
//
//  Created by Nikhil Sharma on 15/5/15.
//  Copyright (c) 2015 Jay Ang. All rights reserved.
//

#import "AFHTTPSessionManager.h"

extern NSString *const ClientDidUpdateUserAccountNotification;

@interface Client : AFHTTPSessionManager

@property (nonatomic, copy, readonly) NSString *authToken;
@property (nonatomic, assign, readonly) BOOL signedIn;

+ (instancetype)sharedInstance;

@end
