//
//  Client.m
//  HagglePit
//
//  Created by Nikhil Sharma on 15/5/15.
//  Copyright (c) 2015 Jay Ang. All rights reserved.
//

#import "Client.h"

static NSString *const kAPIBaseUrl = @"http://hirudo-dev.ap-southeast-1.elasticbeanstalk.com";
static NSString *const kAPIVersionHeader = @"X-Api-Version";
static NSString *const kAuthTokenHeader = @"X-Auth-Token";

NSString *const ClientDidUpdateUserAccountNotification = @"ClientDidUpdateUserAccountNotification";


@implementation Client

+ (instancetype)sharedInstance {
	static dispatch_once_t pred = 0;
	__strong static id _sharedObject = nil;
	dispatch_once(&pred, ^{
		_sharedObject = [[self alloc] init];
	});
	return _sharedObject;
}

- (instancetype)init {
	self = [super initWithBaseURL:[NSURL URLWithString:kAPIBaseUrl]];
	if (self) {
		self.requestSerializer = [AFJSONRequestSerializer serializer];
		self.responseSerializer = [AFJSONResponseSerializer serializer];
		
		NSString *authToken = self.authToken;
		if (authToken.length > 0) {
			[self.requestSerializer setValue:authToken forHTTPHeaderField:kAuthTokenHeader];
		}
	}
	return self;
}

- (void)retrievePatients:(void (^)(NSError *error, NSArray *patients))completion {
    [self GET:@"doctor/xsadaeqe2131adsdasddsad" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *patients = [Patient arrayOfModelFromJSONArray:responseObject];
        if (completion) {
            completion(nil, patients);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error: %@", [error localizedDescription]);
        completion(error, nil);
    }];
}


@end
