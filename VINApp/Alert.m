//
//  Alert.m
//  VINApp
//
//  Created by Donovan Cotter on 2/22/16.
//  Copyright © 2016 DonovanCotter. All rights reserved.
//

#import "Alert.h"

@implementation Alert

-(id)initWithAlert:(NSString *)alertMessage actionTitle:(NSString *)actionTitle viewController:(UIViewController*)viewController {
    self = [super init];
    
    if (self) {

        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                       message:alertMessage
                                                                preferredStyle:UIAlertControllerStyleAlert];
        alertController.view.backgroundColor = [UIColor whiteColor];
        alertController.view.layer.cornerRadius = 10.0;
        
        UIAlertAction* action = [UIAlertAction actionWithTitle:actionTitle style:UIAlertActionStyleCancel handler:nil];
        
        [alertController addAction:action];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [viewController presentViewController:alertController animated:false completion:nil];

        });
    }
    return self;
}


+(id)initWithAlert:(NSString *)alertMessage actionTitle:(NSString *)actionTitle viewController:(UIViewController*)viewController {
    return [[self alloc]initWithAlert:alertMessage actionTitle:actionTitle viewController:viewController];
}

@end
