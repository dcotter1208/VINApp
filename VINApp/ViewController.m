//
//  ViewController.m
//  VINApp
//
//  Created by Donovan Cotter on 2/21/16.
//  Copyright © 2016 DonovanCotter. All rights reserved.
//

#import "ViewController.h"
#import "Vehicle.h"
#import "Alert.h"
#import "PreviousVINTVC.h"


@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *VINSubmitButton;
@property (weak, nonatomic) IBOutlet UITextField *VINTextField;
@property (weak, nonatomic) IBOutlet UILabel *makeLabel;
@property (weak, nonatomic) IBOutlet UILabel *modelLabel;
@property (weak, nonatomic) IBOutlet UILabel *yearLabel;
@property (weak, nonatomic) IBOutlet UILabel *baseMSRPLabel;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *attributeOutlets;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *returnedAttributeOutlets;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


- (IBAction)submitVINButton:(id)sender {
    [self clearLabels];
    
    if ([self.VINTextField.text isEqual: @""]) {
        [Alert initWithAlert:@"Please input a VIN" actionTitle:@"Ok" viewController:self];
        [self.VINTextField endEditing:TRUE];
    } else {
        
        NSString *edmundsAPIKey = @"5xgdf7jpeu9wkgnq6f5rave4";
        NSString *VINNumber = [self.VINTextField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
        NSString *urlString = [NSString stringWithFormat:@"https://api.edmunds.com/api/vehicle/v2/vins/%@?fmt=json&api_key=%@", VINNumber, edmundsAPIKey];
        
        NSURL *url = [NSURL URLWithString:urlString];
        
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
        
        NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            
            if (!error) {
                NSHTTPURLResponse *urlResponse = (NSHTTPURLResponse*) response;
                
                if (urlResponse.statusCode == 200) {
                    
                    NSError *jsonError;
                    
                    NSDictionary *vehicleJSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
                    
                    if (!jsonError) {
                        
                        Vehicle *vehicle = [Vehicle initWithMake:[vehicleJSON valueForKeyPath:@"make.name"]];
                        vehicle.model = [vehicleJSON valueForKeyPath:@"model.name"];
                        vehicle.baseMSRP = [[vehicleJSON valueForKeyPath:@"price.baseMSRP"]stringValue];
                        NSArray *yearsDict = [vehicleJSON valueForKeyPath:@"years"];
                        vehicle.year = [yearsDict[0][@"year"]stringValue];
                        vehicle.VIN = [VINNumber uppercaseString];
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            
                            self.makeLabel.text = [NSString stringWithFormat:@"  %@", vehicle.make];
                            self.modelLabel.text = [NSString stringWithFormat:@"  %@", vehicle.model];
                            self.yearLabel.text = [NSString stringWithFormat:@"  %@", vehicle.year];
                            self.baseMSRPLabel.text = [NSString stringWithFormat:@"  $%@", vehicle.baseMSRP];
                            
                            if ([vehicle.make isEqualToString:@"Ford"]) {
                                [Alert initWithAlert:@"Think Ford First!" actionTitle:@"Ok" viewController:self];
                                [self.VINTextField endEditing:TRUE];
                            } else {
                                [Alert initWithAlert:@"Not a Ford" actionTitle:@"Ok" viewController:self];
                                [self.VINTextField endEditing:TRUE];
                            }
                            [self writeToRealm:vehicle];
                        });
                        
                    } else {
                        [Alert initWithAlert:@"Could not return vehicle info. Please try again." actionTitle:@"Ok" viewController:self];
                        [self.VINTextField endEditing:TRUE];
                    }
                } else if (urlResponse.statusCode == 400) {
                    [Alert initWithAlert:@"Invalid VIN. Please try again." actionTitle:@"Ok" viewController:self];
                };
            }
        }];
        [dataTask resume];
    }
}

-(void)clearLabels {
    self.makeLabel.text = @"";
    self.modelLabel.text = @"";
    self.yearLabel.text = @"";
    self.baseMSRPLabel.text = @"";
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:true];
    [super touchesBegan:touches withEvent:event];
}


-(void)viewWillLayoutSubviews {
    self.VINSubmitButton.layer.cornerRadius = 10;
    
    for (UILabel *label in self.attributeOutlets) {
        label.layer.borderWidth = 2.0;
        label.layer.borderColor = [UIColor blackColor].CGColor;
    }
    
    for (UILabel *label in self.returnedAttributeOutlets) {
        label.layer.borderWidth = 2.0;
        label.layer.borderColor = [UIColor blackColor].CGColor;
    }
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    PreviousVINTVC *destinationViewController = (PreviousVINTVC*)segue.destinationViewController;
    
    if ([segue.identifier isEqualToString:@"showPreviousVINs"]) {
        
        [destinationViewController setDelegate:self];
        
    }
    
}

-(void)sendVINToVC:(NSString *)VIN {
    
    [self.VINTextField setText:VIN];
    
}

-(void)writeToRealm:(Vehicle*)vehicle{
    RLMRealm *realm = [RLMRealm defaultRealm];
    NSLog(@"%@", realm.path);
    [realm beginWriteTransaction];
    [realm addOrUpdateObject:vehicle];
    [realm commitWriteTransaction];
    
}

@end
