//
//  PatientTableViewCell.h
//  HirudoiPad
//
//  Created by Nikhil Sharma on 20/6/16.
//  Copyright © 2016 Nikhil Sharma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PatientTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *patientNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *patientDetailsLabel;

@end
