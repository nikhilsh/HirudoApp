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
    NSDictionary *params = @{
                             @"uid" : @(1)
                             };
    [self GET:@"doctor/data" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *patients = [Patient arrayOfModelFromJSONArray:responseObject[@"data"]];
        if (completion) {
            completion(nil, patients);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error: %@", [error localizedDescription]);
        completion(error, nil);
    }];
}

- (void)retrievePatientsWithDate:(NSDate *) date withCompletionHander:(void (^)(NSError *error, NSArray *patients))completion {
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString = [dateFormat stringFromDate:date];
    
    NSDictionary *params = @{
                             @"last" : dateString,
                             @"uid" : @(1)
                             };
    [self GET:@"doctor/datatime" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *patients = [Patient arrayOfModelFromJSONArray:responseObject[@"data"]];
        if (completion) {
            completion(nil, patients);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error: %@", [error localizedDescription]);
        completion(error, nil);
    }];
}

@end
