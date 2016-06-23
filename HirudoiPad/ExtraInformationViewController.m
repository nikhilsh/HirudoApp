//
//  ExtraInformationViewController.m
//  HirudoiPad
//
//  Created by Nikhil Sharma on 24/6/16.
//  Copyright © 2016 Nikhil Sharma. All rights reserved.
//

#import "ExtraInformationViewController.h"

@interface ExtraInformationViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;
@property (weak, nonatomic) IBOutlet UILabel *extraDetailLabel;

@end

@implementation ExtraInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.isCoagulant) {
        self.typeLabel.text = @"Anti Coagulant Left";
        self.extraDetailLabel.text = @"Please pause the device and replace the anticoagulant syringe";
        self.amountLabel.text = @"30ml";
        self.imageView.image = [UIImage imageNamed:@"picture_syringe"];
    }
    else {
        self.typeLabel.text = @"Blood pumped out";
        self.extraDetailLabel.text = @"Total amount of blood pumped out";
        self.amountLabel.text = @"80ml";
        self.imageView.image = [UIImage imageNamed:@"picture_bloodbag"];
    }
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
