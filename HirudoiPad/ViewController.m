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
@property (nonatomic,strong) NSMutableArray *graphDataPoints;


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
    self.graphDataPoints = [NSMutableArray array];
    
    self.graph1.showMeanLine = YES;
    self.graph1.showMinMaxLines = YES;
    self.graph1.showDots = YES;
    self.graph1.showXLegend = YES;
    self.graph1.showYLegend = YES;
    self.graph1.tintColor = [UIColor redColor];
    self.graph1.shouldSmooth = YES;
    self.graph1.showXLegendValues = YES;
    self.graph1.layer.cornerRadius = 8.0;
    self.graph1.clipsToBounds = YES;
    self.graph1.dataSource = self;
    [self.graph1 beginAnimationIn];
    NSInteger perPopData = 100;
    while (perPopData--) {
        [self.graphDataPoints addObject:[[ARGraphDataPoint alloc] initWithX:100 - perPopData y:100 + arc4random()%100]];
    }
    
    [self.graph1 reloadData];
}

- (NSArray*)ARGraphDataPoints:(ARLineGraph *)graph
{
    return self.graphDataPoints;
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
