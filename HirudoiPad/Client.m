//
//  Client.m
//  HagglePit
//
//  Created by Nikhil Sharma on 15/5/15.
//  Copyright (c) 2015 Jay Ang. All rights reserved.
//

#import "Client.h"
#import "Cache.h"

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

- (void)retrievePatientList:(void (^)(NSError *error, NSArray *patients))completion {
    NSDictionary *params = @{
                             @"sid" : @([Cache sharedInstance].userID)
                             };
    [self GET:@"doctor" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *patients = [Patient arrayOfModelFromJSONArray:responseObject[@"patients"]];
        [Cache sharedInstance].doctorName = responseObject[@"doc.sname"];
        if (completion) {
            completion(nil, patients);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error: %@", [error localizedDescription]);
        completion(error, nil);
    }];
}

- (void)retrievePatientWithPatient:(int)patientID withCompletionHandler:(void (^)(NSError *error, NSArray *patients))completion {
    NSDictionary *params = @{
                             @"uid" : @(patientID)
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

- (void)retrievePatientsWithDate:(NSDate *)date withPatientID:(int)patientID withCompletionHander:(void (^)(NSError *error, NSArray *patients))completion {
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString = [dateFormat stringFromDate:date];
    
    NSDictionary *params = @{
                             @"last" : dateString,
                             @"uid" : @(patientID)
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

- (void)registerDoctorWithUser:(NSString *)suser withPassword:(NSString *)spw withName:(NSString *)sname withRole:(NSString *)role withGender:(NSString *)sgender withTeamID:(int)teamuuid withCompletionHander:(void (^)(NSError *error))completion {
    NSDictionary *params = @{
                             @"suser" : suser,
                             @"spw" : spw,
                             @"sname" : sname,
                             @"srole" : role,
                             @"sgender" : sgender,
                             @"tid" : @(teamuuid),
                             };
    [self POST:@"doctor/register" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *userID = responseObject[@"sid"];
        [Cache sharedInstance].userID = [userID intValue];
        if (completion) {
            completion(nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error: %@", [error localizedDescription]);
        completion(error);
    }];
}

- (void)loginDoctorWithUser:(NSString *)suser withPassword:(NSString *)spw withCompletionHander:(void (^)(NSError *error, NSString *userID))completion {
    NSDictionary *params = @{
                             @"suser" : suser,
                             @"spw" : spw
                             };
    [self GET:@"doctor/login" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *userID = responseObject[@"sid"];
        if (completion) {
            completion(nil, userID);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error: %@", [error localizedDescription]);
        completion(error, nil);
    }];
}

@end
