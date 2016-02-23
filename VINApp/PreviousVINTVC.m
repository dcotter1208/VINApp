//
//  PreviousVINTVC.m
//  VINApp
//
//  Created by Donovan Cotter on 2/22/16.
//  Copyright © 2016 DonovanCotter. All rights reserved.
//

#import "PreviousVINTVC.h"
#import "Vehicle.h"

@interface PreviousVINTVC () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation PreviousVINTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self.delegate self];
    
    NSLog(@"VIN STRING: %@", _VIN);
    NSLog(@"Previous Vins Array Count: %lu", _previousVINsArray.count);

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewWillAppear:(BOOL)animated {
    NSLog(@"Previous Vins Array Count: %lu", _previousVINsArray.count);

}

- (IBAction)dismissView:(id)sender {
    
    [self dismissViewControllerAnimated:true completion:nil];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _previousVINsArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    Vehicle *vehicle = [_previousVINsArray objectAtIndex:indexPath.row];
    
    cell.textLabel.text = vehicle.VIN;
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    NSString *selectedVIN = [tableView cellForRowAtIndexPath:indexPath].textLabel.text;
    
    NSLog(@"SELECTED VIN: %@", selectedVIN);
    
    [self.delegate sendVINToVC:selectedVIN];
    
    [self dismissViewControllerAnimated:true completion:nil];
    
}


@end
