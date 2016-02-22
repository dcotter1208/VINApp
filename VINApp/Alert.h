//
//  Alert.h
//  VINApp
//
//  Created by Donovan Cotter on 2/22/16.
//  Copyright © 2016 DonovanCotter. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Alert : NSObject
//
//@property(nonatomic, strong) UIAlertController *alertMessage;
//@property (nonatomic, strong) UIAlertController *alertTitle;
//@property (nonatomic, strong) UIAlertController *alertController;

-(id)initWithAlert:(NSString *)alertMessage actionTitle:(NSString *)actionTitle viewController:(UIViewController*)viewController;

+(id)initWithAlert:(NSString *)alertMessage actionTitle:(NSString *)actionTitle viewController:(UIViewController*)viewController;


@end
