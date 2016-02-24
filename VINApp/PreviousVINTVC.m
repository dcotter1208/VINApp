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

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation PreviousVINTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    VINArray = [Vehicle allObjects];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)dismissView:(id)sender {
    
    [self dismissViewControllerAnimated:true completion:nil];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return VINArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    Vehicle *vehicle = [VINArray objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@ %@", vehicle.year, vehicle.make, vehicle.model];
    cell.detailTextLabel.text = [vehicle.VIN uppercaseString];
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *selectedVIN = [tableView cellForRowAtIndexPath:indexPath].detailTextLabel.text;
    
    [self.delegate sendVINToVC:selectedVIN];
    
    [self dismissViewControllerAnimated:true completion:nil];
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle) editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if(editingStyle==UITableViewCellEditingStyleDelete) {
        [[RLMRealm defaultRealm] beginWriteTransaction];
        [[RLMRealm defaultRealm]deleteObject:[VINArray objectAtIndex:indexPath.row]];
        [[RLMRealm defaultRealm] commitWriteTransaction];
        VINArray=[Vehicle allObjects];
        
        [self.tableView deleteRowsAtIndexPaths:[NSMutableArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self.tableView setEditing:NO animated:YES];
    }
}

@end
