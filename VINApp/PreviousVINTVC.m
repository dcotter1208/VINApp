//
//  PreviousVINTVC.m
//  VINApp
//
//  Created by Donovan Cotter on 2/22/16.
//  Copyright © 2016 DonovanCotter. All rights reserved.
//

#import "PreviousVINTVC.h"

@interface PreviousVINTVC ()

@end

@implementation PreviousVINTVC

- (void)viewDidLoad {
    [super viewDidLoad];

    _previousVINsArray = [NSMutableArray array];

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
- (IBAction)dismissView:(id)sender {
    
    [self dismissViewControllerAnimated:true completion:nil];
    
}

@end
