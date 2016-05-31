//
//  PatientTableViewCell.h
//  HirudoApp
//
//  Created by Nikhil Sharma on 31/5/16.
//  Copyright © 2016 Nikhil Sharma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Patient.h"
#import <ARLineGraph.h>

@interface PatientTableViewCell : UITableViewCell <ARLineGraphDataSource>

@property (strong, nonatomic) Patient *patient;
@property (copy, nonatomic) NSString *title;
@property (weak, nonatomic) IBOutlet ARLineGraph *lineGraph;
@property (nonatomic,strong) NSMutableArray *graphDataPoints;

@end
