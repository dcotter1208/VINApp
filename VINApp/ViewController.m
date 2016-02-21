//
//  ViewController.m
//  VINApp
//
//  Created by Donovan Cotter on 2/21/16.
//  Copyright © 2016 DonovanCotter. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *VINSubmitButton;
@property (weak, nonatomic) IBOutlet UITextField *VINTextField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillLayoutSubviews {
    self.VINSubmitButton.layer.cornerRadius = 10;

}

- (IBAction)submitVINButton:(id)sender {
    
    
    
}





@end
