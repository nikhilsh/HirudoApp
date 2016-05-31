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

@end
