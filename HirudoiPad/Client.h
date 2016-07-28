//
//  Client.h
//  HagglePit
//
//  Created by Nikhil Sharma on 15/5/15.
//  Copyright (c) 2015 Jay Ang. All rights reserved.
//

#import "AFHTTPSessionManager.h"
#import "Patient.h"

extern NSString *const ClientDidUpdateUserAccountNotification;

@interface Client : AFHTTPSessionManager

@property (nonatomic, copy, readonly) NSString *authToken;
@property (nonatomic, assign, readonly) BOOL signedIn;

+ (instancetype)sharedInstance;

- (void)retrievePatientList:(void (^)(NSError *error, NSArray *patients))completion;

- (void)retrievePatientWithPatient:(int)patientID withCompletionHandler:(void (^)(NSError *error, NSArray *patients))completion;
- (void)retrievePatientsWithDate:(NSDate *)date withPatientID:(int)patientID withCompletionHander:(void (^)(NSError *error, NSArray *patients))completion;

//register doctor
- (void)registerDoctorWithUser:(NSString *)suser withPassword:(NSString *)spw withName:(NSString *)sname withRole:(NSString *)role withGender:(NSString *)sgender withTeamID:(int)teamuuid withWorkID:(int)workuuid withCompletionHander:(void (^)(NSError *error))completion;

//login doctor
- (void)loginDoctorWithUser:(NSString *)suser withPassword:(NSString *)spw withCompletionHander:(void (^)(NSError *error, NSString *userID))completion;

@end
