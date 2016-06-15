//
//  ViewController.m
//  HirudoiPad
//
//  Created by Nikhil Sharma on 13/6/16.
//  Copyright © 2016 Nikhil Sharma. All rights reserved.
//

#import "ViewController.h"
#import "Client.h"
#import "ARLineGraph.h"

@interface ViewController () <ARLineGraphDataSource>

@property (weak, nonatomic) IBOutlet ARLineGraph *graph1;
@property (weak, nonatomic) IBOutlet ARLineGraph *graph2;
@property (weak, nonatomic) IBOutlet ARLineGraph *graph3;

@property (strong, nonnull) NSMutableArray *patients;
@property (nonatomic,strong) NSMutableArray *graphDataPoints1;
@property (nonatomic,strong) NSMutableArray *graphDataPoints2;
@property (nonatomic,strong) NSMutableArray *graphDataPoints3;

@property (nonatomic, assign) int counter;


@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	self.patients = [NSMutableArray new];
	[[Client sharedInstance] retrievePatients:^(NSError *error, NSArray *patients) {
	         self.patients = [patients copy];
	 }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.graphDataPoints1 = [NSMutableArray array];
    self.graphDataPoints2 = [NSMutableArray array];
    self.graphDataPoints3 = [NSMutableArray array];

    
    self.graph1.showMeanLine = YES;
    self.graph1.showMinMaxLines = YES;
    self.graph1.showDots = YES;
    self.graph1.showXLegend = YES;
    self.graph1.showYLegend = YES;
    self.graph1.tintColor = [UIColor colorWithRed:0.3922 green:0.2089 blue:0.7482 alpha:1.0];
    self.graph1.shouldSmooth = YES;
    self.graph1.showXLegendValues = YES;
    self.graph1.layer.cornerRadius = 8.0;
    self.graph1.clipsToBounds = YES;
    self.graph1.dataSource = self;
    self.graph1.animationDuration = 2.0f;
    [self.graph1 beginAnimationIn];
    
    [self.graph1 reloadData];
    
    self.graph2.showMeanLine = YES;
    self.graph2.showMinMaxLines = YES;
    self.graph2.showDots = NO;
    self.graph2.showXLegend = YES;
    self.graph2.showYLegend = YES;
    self.graph2.tintColor = [UIColor colorWithRed:0.1888 green:0.5065 blue:0.6895 alpha:1.0];
    self.graph2.shouldSmooth = NO;
    self.graph2.showXLegendValues = YES;
    self.graph2.layer.cornerRadius = 8.0;
    self.graph2.clipsToBounds = YES;
    self.graph2.dataSource = self;
    [self.graph2 beginAnimationIn];
    
    [self.graph2 reloadData];
    
    self.graph3.showMeanLine = NO;
    self.graph3.showMinMaxLines = NO;
    self.graph3.showDots = YES;
    self.graph3.showXLegend = YES;
    self.graph3.showYLegend = YES;
    self.graph3.tintColor = [UIColor colorWithRed:1.0 green:0.2649 blue:0.155 alpha:1.0];
    self.graph3.shouldSmooth = NO;
    self.graph3.showXLegendValues = NO;
    self.graph3.layer.cornerRadius = 12.0;
    self.graph3.clipsToBounds = NO;
    self.graph3.dataSource = self;
    [self.graph3 beginAnimationIn];
    
    [self.graph3 reloadData];

    [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(addDataPoints) userInfo:nil repeats:YES];
    self.counter = 5;
}

- (void)addDataPoints {
    self.counter--;
    [self.graph1 appendDataPoint:[[ARGraphDataPoint alloc] initWithX:100-self.counter y:100 + arc4random()%100]];
    [self.graph2 appendDataPoint:[[ARGraphDataPoint alloc] initWithX:100-self.counter y:100 + arc4random()%100]];
    [self.graph3 appendDataPoint:[[ARGraphDataPoint alloc] initWithX:100-self.counter y:100 + arc4random()%100]];
}

- (NSArray*)ARGraphDataPoints:(ARLineGraph *)graph {
    if (graph == self.graph1) {
        return self.graphDataPoints1;
    }
    else if (graph == self.graph2) {
        return self.graphDataPoints2;
    }
    else {
        return self.graphDataPoints3;
    }
}

- (NSString*)titleForGraph:(ARLineGraph*)graph {
    if (graph == self.graph1) {
        return @"Heart Rate";
    }
    else if (graph == self.graph2) {
        return @"Temperature";
    }
    else {
        return @"Blood Flow Rate";
    }
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
