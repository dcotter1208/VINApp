//
//  ViewController.m
//  VINApp
//
//  Created by Donovan Cotter on 2/21/16.
//  Copyright © 2016 DonovanCotter. All rights reserved.
//

#import "ViewController.h"
#import "Vehicle.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *VINSubmitButton;
@property (weak, nonatomic) IBOutlet UITextField *VINTextField;
@property (weak, nonatomic) IBOutlet UILabel *makeLabel;
@property (weak, nonatomic) IBOutlet UILabel *modelLabel;
@property (weak, nonatomic) IBOutlet UILabel *yearLabel;
@property (weak, nonatomic) IBOutlet UILabel *baseMSRPLabel;


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
    [self clearLabels];
    NSString *edmundsAPIKey = @"5xgdf7jpeu9wkgnq6f5rave4";
    NSString *VINNumber = self.VINTextField.text;
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
                    NSArray *yearsDict = [vehicleJSON valueForKeyPath:@"years"];
                    vehicle.year = yearsDict[0][@"year"];
                    vehicle.baseMSRP = [vehicleJSON valueForKeyPath:@"price.baseMSRP"];
                    
                    NSLog(@"Year: %@, Make: %@, Model: %@, Base MSRP: %@", vehicle.year, vehicle.make, vehicle.model, vehicle.baseMSRP);
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        self.makeLabel.text = [NSString stringWithFormat:@"%@", vehicle.make];
                        self.modelLabel.text = [NSString stringWithFormat:@"%@", vehicle.model];
                        self.yearLabel.text = [NSString stringWithFormat:@"%@", vehicle.year];
                        self.baseMSRPLabel.text = [NSString stringWithFormat:@"%@", vehicle.baseMSRP];
                    });
                } else {
                    NSLog(@"%@", jsonError);
                }
            };
        } else {
            NSLog(@"%@", error);
        }
    }];
    
    [dataTask resume];
    
}

-(void)clearLabels {
    self.makeLabel.text = @"";
    self.modelLabel.text = @"";
    self.yearLabel.text = @"";
    self.baseMSRPLabel.text = @"";
    
}


//    @"https://api.edmunds.com/api/vehicle/v2/vins/1C3CCCBB8FN710820?fmt=json&api_key=5xgdf7jpeu9wkgnq6f5rave4";


//1C3CCCBB8FN710820

@end
