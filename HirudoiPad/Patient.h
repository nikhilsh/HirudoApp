//
//  Patient.h
//  HirudoApp
//
//  Created by Nikhil Sharma on 31/5/16.
//  Copyright © 2016 Nikhil Sharma. All rights reserved.
//

#import <MCModel.h>

@interface Patient : MCModel

@property (copy, nonatomic) NSString *patientID;
@property (assign, nonatomic) int heartRate;
@property (assign, nonatomic) float temperature;
@property (assign, nonatomic) float bloodFlowRate;
@property (strong, nonatomic) NSDate *date;
@property (assign, nonatomic) int wardID;
@property (copy, nonatomic) NSString *gender;
@property (copy, nonatomic) NSString *admittedDate;
@property (copy, nonatomic) NSString *name;

@end
