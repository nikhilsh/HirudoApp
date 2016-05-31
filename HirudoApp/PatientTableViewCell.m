//
//  PatientTableViewCell.m
//  HirudoApp
//
//  Created by Nikhil Sharma on 31/5/16.
//  Copyright © 2016 Nikhil Sharma. All rights reserved.
//

#import "PatientTableViewCell.h"
#import <ARGraphDataPoint.h>

@implementation PatientTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setPatient:(Patient *)patient {
    _patient = patient;
    self.graphDataPoints = [NSMutableArray array];

    [self.graphDataPoints addObject:[[ARGraphDataPoint alloc] initWithX:0 y:100]];
    
    [self.lineGraph reloadData];
}

- (void)setupGraph {
    [self.lineGraph setDataSource:self];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)createDataPoint
{
    [self.graphDataPoints addObject:[[ARGraphDataPoint alloc] initWithX:arc4random()%10 y:100 +arc4random()%80]];
    [self.lineGraph appendDataPoint:[self.graphDataPoints lastObject]];
}

- (NSString *)titleForGraph:(ARLineGraph *)graph {
    return self.title;
}

- (NSArray*)ARGraphDataPoints:(ARLineGraph *)graph
{
    return self.graphDataPoints;
}

@end
