//
//  Patient.m
//  HirudoApp
//
//  Created by Nikhil Sharma on 31/5/16.
//  Copyright © 2016 Nikhil Sharma. All rights reserved.
//

#import "Patient.h"

@implementation Patient


+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
        @"temperature" : @"Temp",
        @"heartRate" : @"HR",
        @"bloodFlowRate" : @"flowrate",
        @"patientID" : @"uid"
    };
}
@end
