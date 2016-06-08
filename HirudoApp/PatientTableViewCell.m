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
        // self.timer = [NSTimer timerWithTimeInterval:2.0 target:self selector:@selector(createDataPoint) userInfo:nil repeats:YES];
    //  [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];

// Initialization code
}

- (void)setPatient:(Patient *)patient {
    _patient = patient;
    self.graphDataPoints = [NSMutableArray array];
    
    [self.graphDataPoints addObject:[[ARGraphDataPoint alloc] initWithX:0 y:self.patient.heartRate]];
    [self.lineGraph appendDataPoint:[self.graphDataPoints lastObject]];
    self.lineGraph.showMeanLine = YES;
    self.lineGraph.showMinMaxLines = YES;
    self.lineGraph.showDots = YES;
    self.lineGraph.showXLegend = YES;
    self.lineGraph.showYLegend = YES;
    self.lineGraph.tintColor = [UIColor blackColor];
    self.lineGraph.shouldSmooth = YES;
    self.lineGraph.layer.cornerRadius = 8.0;
    self.lineGraph.clipsToBounds = YES;
    self.lineGraph.dataSource = self;
    [self.lineGraph beginAnimationIn];
    
    [self.lineGraph reloadData];
    NSLog(@"patient first");
}

- (void)setupGraph {
    [self.lineGraph setDataSource:self];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)createDataPoint {
    [self.graphDataPoints addObject:[[ARGraphDataPoint alloc] initWithX:arc4random()%10 y:100 +arc4random()%80]];
    [self.lineGraph appendDataPoint:[self.graphDataPoints lastObject]];
}

- (NSString *)titleForGraph:(ARLineGraph *)graph {
    return self.title;
}

- (NSArray *)ARGraphDataPoints:(ARLineGraph *)graph {
    return self.graphDataPoints;
}

@end
