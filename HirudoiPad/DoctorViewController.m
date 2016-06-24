//
//  DoctorViewController.m
//  HirudoiPad
//
//  Created by Nikhil Sharma on 21/6/16.
//  Copyright © 2016 Nikhil Sharma. All rights reserved.
//

#import "DoctorViewController.h"
#import "Client.h"
#import "ExtraInformationViewController.h"
#import "ARLineGraph.h"
#import <MCAppRouter.h>
#import <MCAlertView.h>
#import <MZTimerLabel.h>

#define ARC4RANDOM_MAX      0x100000000

@interface DoctorViewController () <ARLineGraphDataSource, MZTimerLabelDelegate>

@property (weak, nonatomic) IBOutlet ARLineGraph *graph1;
@property (weak, nonatomic) IBOutlet ARLineGraph *graph2;
@property (weak, nonatomic) IBOutlet ARLineGraph *graph3;

@property (strong, nonnull) NSMutableArray *patients;
@property (nonatomic,strong) NSMutableArray *graphDataPoints1;
@property (nonatomic,strong) NSMutableArray *graphDataPoints2;
@property (nonatomic,strong) NSMutableArray *graphDataPoints3;

@property (nonatomic, assign) float oldValue1;
@property (nonatomic, assign) float oldValue2;
@property (nonatomic, assign) float oldValue3;

@property (nonatomic, assign) int counter;

@property (weak, nonatomic) IBOutlet UILabel *currentHeartRateLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentTemperatureLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentBloodFlowRate;

@property (strong, nonatomic) NSDate *lastFetchedDate;
@property (strong, nonatomic) NSTimer *timer;

@property (assign, nonatomic) int pointTracker;
@property (weak, nonatomic) IBOutlet MZTimerLabel *countdownTimer;
@property (weak, nonatomic) IBOutlet MZTimerLabel *treatmentTimer;

@property (weak, nonatomic) IBOutlet UIView *bloodBagView;

@end

@implementation DoctorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"Francisco Furtado";
    [self.navigationController.navigationBar setTitleTextAttributes:@{
                                                                      NSFontAttributeName:[UIFont fontWithName:@"AvenirNext-Medium" size:21]}];
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];


    self.patients = [NSMutableArray new];
    [self setupGraphs];

    if (!self.lastFetchedDate) {
        [[Client sharedInstance] retrievePatients:^(NSError *error, NSArray *patients) {
            self.patients = [patients mutableCopy];
            Patient *patient = patients.lastObject;
            self.lastFetchedDate = patient.date;
            [self useRealData];
            self.pointTracker = (int)self.patients.count;
        }];
    }
    else {
        [[Client sharedInstance] retrievePatientsWithDate:self.lastFetchedDate withCompletionHander:^(NSError *error, NSArray *patients) {
            [self.patients addObjectsFromArray:patients];
            [self useRealData];
        }];
    }
    
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushNewViewController)];
    [self.bloodBagView addGestureRecognizer:gestureRecognizer];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self setupLabels];
    });
//    [self createMockData];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.countdownTimer reset];
    [self.countdownTimer pause];

    [self.treatmentTimer reset];
    [self.treatmentTimer pause];
}

- (void)useRealData {
    Patient *patient = [[Patient alloc] init];
    
    [self.graph1 beginAnimationIn];
    [self.graph2 beginAnimationIn];
    [self.graph3 beginAnimationIn];
    
    for (int i = 0; i<self.patients.count; i++) {
        patient = self.patients[i];
        NSLog(@"counter: %i", i);
        self.oldValue1 = patient.heartRate;
        [self.graphDataPoints1 addObject:[[ARGraphDataPoint alloc] initWithX:i y:self.oldValue1]];
        self.oldValue2 = patient.temperature;
        [self.graphDataPoints2 addObject:[[ARGraphDataPoint alloc] initWithX:i y:self.oldValue2]];
        self.oldValue3 = patient.bloodFlowRate;
        [self.graphDataPoints3 addObject:[[ARGraphDataPoint alloc] initWithX:i y:self.oldValue3]];
        
        //set labels
        self.currentHeartRateLabel.text = [NSString stringWithFormat:@"%i bpm", (int)patient.heartRate];
        self.currentTemperatureLabel.text = [NSString stringWithFormat:@"%0.2f°C", patient.temperature];
        self.currentBloodFlowRate.text = [NSString stringWithFormat:@"%i ml/min", (int)patient.bloodFlowRate];
    }
    [self.graph1 reloadData];
    [self.graph2 reloadData];
    [self.graph3 reloadData];

    self.timer = [NSTimer scheduledTimerWithTimeInterval:4 target:self selector:@selector(fetchRealDataPoints) userInfo:nil repeats:YES];
}

- (void)setupGraphs {
    self.graphDataPoints1 = [NSMutableArray array];
    self.graphDataPoints2 = [NSMutableArray array];
    self.graphDataPoints3 = [NSMutableArray array];
    
    //graph 1 setup
    self.graph1.showMeanLine = YES;
    self.graph1.showMinMaxLines = YES;
    self.graph1.showDots = YES;
    self.graph1.showXLegend = YES;
    self.graph1.showYLegend = YES;
    self.graph1.useBackgroundGradient = YES;
    self.graph1.tintColor = [UIColor colorWithRed:0.3922 green:0.2089 blue:0.7482 alpha:1.0];
    self.graph1.shouldSmooth = NO;
    self.graph1.showXLegendValues = YES;
    self.graph1.layer.cornerRadius = 8.0;
    self.graph1.clipsToBounds = YES;
    self.graph1.dataSource = self;
    self.graph1.animationDuration = 2.0f;
    
    //graph 2 setup
    self.graph2.showMeanLine = YES;
    self.graph2.showMinMaxLines = YES;
    self.graph2.showDots = YES;
    self.graph2.showXLegend = YES;
    self.graph2.showYLegend = YES;
    self.graph2.normalizeXValues = YES;
    self.graph2.useBackgroundGradient = YES;
    self.graph2.tintColor = [UIColor colorWithRed:0.1888 green:0.5065 blue:0.6895 alpha:1.0];
    self.graph2.shouldSmooth = NO;
    self.graph2.showXLegendValues = YES;
    self.graph2.layer.cornerRadius = 8.0;
    self.graph2.clipsToBounds = YES;
    self.graph2.dataSource = self;
    self.graph2.animationDuration = 2.0f;

    
    //graph 3 setup
    self.graph3.showMeanLine = YES;
    self.graph3.showMinMaxLines = YES;
    self.graph3.showDots = YES;
    self.graph3.showXLegend = YES;
    self.graph3.showYLegend = YES;
    self.graph3.useBackgroundGradient = YES;
    self.graph3.tintColor = [UIColor colorWithRed:1.0 green:0.2649 blue:0.155 alpha:1.0];
    self.graph3.shouldSmooth = NO;
    self.graph3.showXLegendValues = YES;
    self.graph3.layer.cornerRadius = 8.0;
    self.graph3.clipsToBounds = YES;
    self.graph3.dataSource = self;
    self.graph3.animationDuration = 2.0f;

}

- (void)setupLabels {
    [self.countdownTimer setCountDownTime:20];
    self.countdownTimer.delegate = self;
    self.countdownTimer.timerType = MZTimerLabelTypeTimer;
    [self.countdownTimer start];
    
    [self.treatmentTimer start];
}

- (void)createMockData {
    [self.graph1 beginAnimationIn];
    self.oldValue1 = [self randomNumberBetween:40 maxNumber:130];
    [self.graphDataPoints1 addObject:[[ARGraphDataPoint alloc] initWithX:0 y:self.oldValue1]];
    
    [self.graph1 reloadData];
   
    [self.graph2 beginAnimationIn];
    self.oldValue2 = [self randomNumberBetween:35 maxNumber:39];
    [self.graphDataPoints2 addObject:[[ARGraphDataPoint alloc] initWithX:0 y:self.oldValue2]];
    
    [self.graph2 reloadData];
    
    [self.graph3 beginAnimationIn];
    self.oldValue3 = [self randomNumberBetween:8 maxNumber:20];
    [self.graphDataPoints3 addObject:[[ARGraphDataPoint alloc] initWithX:0 y:self.oldValue3]];
    
    [self.graph3 reloadData];
    
    self.counter = 99;
}

- (void)fetchRealDataPoints {
    __block Patient *patient = [[Patient alloc] init];
    [[Client sharedInstance] retrievePatientsWithDate:self.lastFetchedDate withCompletionHander:^(NSError *error, NSArray *patients) {
        [self.patients addObjectsFromArray:patients];
        for (int i = 0; i<patients.count; i++) {
            patient = patients[i];
            [self.graph1 appendDataPoint:[[ARGraphDataPoint alloc] initWithX:self.pointTracker y:patient.heartRate]];
            [self.graph2 appendDataPoint:[[ARGraphDataPoint alloc] initWithX:self.pointTracker y:patient.temperature]];
            [self.graph3 appendDataPoint:[[ARGraphDataPoint alloc] initWithX:self.pointTracker y:patient.bloodFlowRate]];
            
            //set labels
            self.currentHeartRateLabel.text = [NSString stringWithFormat:@"%i bpm", (int)patient.heartRate];
            self.currentTemperatureLabel.text = [NSString stringWithFormat:@"%0.2f°C", patient.temperature];
            self.currentBloodFlowRate.text = [NSString stringWithFormat:@"%i ml/min", (int)patient.bloodFlowRate];
            self.pointTracker +=1;
        }
    }];
}

- (void)addDataPoints {
    self.counter--;
    self.oldValue1 =[self randomNumberFromPreviousValue:self.oldValue1 AndScale:8];
    [self.graph1 appendDataPoint:[[ARGraphDataPoint alloc] initWithX:100-self.counter y:self.oldValue1]];
    self.oldValue2 = [self randomFloatWithMinFloat:-0.5 andMaxFloat:0.5];
    if (self.oldValue2 < 35.5) {
        self.oldValue2 += ((double)arc4random() / ARC4RANDOM_MAX);
    }
    else if (self.oldValue2 >40.0){
        self.oldValue2 -= ((double)arc4random() / ARC4RANDOM_MAX);
    }
    [self.graph2 appendDataPoint:[[ARGraphDataPoint alloc] initWithX:100-self.counter y:self.oldValue2]];
    NSLog(@"oldValue: %f", self.oldValue2);
    self.oldValue3 = [self randomNumberFromPreviousValue:self.oldValue3 AndScale:2];
    [self.graph3 appendDataPoint:[[ARGraphDataPoint alloc] initWithX:100-self.counter y:self.oldValue3]];
    
    self.currentHeartRateLabel.text = [NSString stringWithFormat:@"%i bpm", (int)self.oldValue1];
    self.currentTemperatureLabel.text = [NSString stringWithFormat:@"%0.2f°C", self.oldValue2];
    self.currentBloodFlowRate.text = [NSString stringWithFormat:@"%i ml/min", (int)self.oldValue3];
}

- (NSArray *)ARGraphDataPoints:(ARLineGraph *)graph {
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

- (NSString *)titleForGraph:(ARLineGraph*)graph {
    if (graph == self.graph1) {
        return @"Heart Rate";
    }
    else if (graph == self.graph2) {
        return @"Temperature";
    }
    else {
        return @"Blood Flow";
    }
}

- (NSString *)subTitleForGraph:(ARLineGraph*)graph {
    if (graph == self.graph1) {
        return @"beats/min";
    }
    else if (graph == self.graph2) {
        return @"° celsius";
    }
    else {
        return @"ml";
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [self.timer invalidate];
}

- (NSInteger)randomNumberFromPreviousValue:(int) previousValue AndScale:(float)delta {
    return previousValue + arc4random_uniform(delta) - arc4random_uniform(delta);
}

- (NSInteger)randomNumberBetween:(NSInteger)min maxNumber:(NSInteger)max {
    return min + arc4random_uniform(max - min + 1);
}

- (float)randomFloatWithMinFloat:(float)min andMaxFloat:(float)max {
    return self.oldValue2 + max * ((float)rand()/(float)RAND_MAX - 0.5);
}

- (void)pushNewViewController {
    ExtraInformationViewController *controller = [[MCAppRouter sharedInstance] viewControllerMatchingRoute:@"extra"];
    controller.isCoagulant = NO;
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma MARK - MZTimerLabel Delegate
- (void)timerLabel:(MZTimerLabel *)timerLabel finshedCountDownTimerWithTime:(NSTimeInterval)countTime {
    [[MCAlertView alertViewWithTitle:@"Warning!" message:@"Anticoagulant is running low" actionButtonTitle:@"See More" cancelButtonTitle:@"Dismiss" completionHandler:^(BOOL cancelled) {
        if (!cancelled) {
            ExtraInformationViewController *controller = [[MCAppRouter sharedInstance] viewControllerMatchingRoute:@"extra"];
            controller.isCoagulant = YES;
            [self.navigationController pushViewController:controller animated:YES];
        }
    }] show];
}

@end
