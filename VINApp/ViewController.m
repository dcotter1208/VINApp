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

    NSString *edmundsAPIKey = @"5xgdf7jpeu9wkgnq6f5rave4";
    NSString *VINNumber = self.VINTextField.text;
    NSString *urlString = [NSString stringWithFormat:@"https://api.edmunds.com/api/vehicle/v2/vins/%@?fmt=json&api_key=%@", VINNumber, edmundsAPIKey];
    NSLog(@"FINAL URL: %@", urlString);
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (!error) {
            NSHTTPURLResponse *urlResponse = (NSHTTPURLResponse*) response;
            
            if (urlResponse.statusCode == 200) {
                
                NSError *jsonError;
                
                NSDictionary *vehicleJSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
                
                NSMutableArray *vehicleInfo = [[NSMutableArray alloc]init];
                
                if (!jsonError) {
                    NSLog(@"%@", vehicleJSON);
                }
                
            };
        }
    }];
    
    [dataTask resume];
    
}


//    @"https://api.edmunds.com/api/vehicle/v2/vins/1C3CCCBB8FN710820?fmt=json&api_key=5xgdf7jpeu9wkgnq6f5rave4";


@end
