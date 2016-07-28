//
//  Patient.m
//  HirudoApp
//
//  Created by Nikhil Sharma on 31/5/16.
//  Copyright © 2016 Nikhil Sharma. All rights reserved.
//

#import "Patient.h"
#import <MCModelDateValueTransformer.h>

@implementation Patient


+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
        @"temperature" : @"temp",
        @"heartRate" : @"heartrate",
        @"bloodFlowRate" : @"flowrate",
        @"patientID" : @"pid",
        @"date" : @"timestamp",
        @"name" : @"pname",
        @"wardID" : @"wid",
        @"gender" : @"pgender",
    };
}

+ (NSValueTransformer *)dateJSONTransformer {
    return [NSValueTransformer valueTransformerForName:MCModelDateTimeValueTransformerName];
}

+ (NSValueTransformer *)admittedDateJSONTransformer {
    return [NSValueTransformer valueTransformerForName:MCModelDateTimeValueTransformerName];
}

@end
