//
//  PreviousVINTVC.h
//  VINApp
//
//  Created by Donovan Cotter on 2/22/16.
//  Copyright © 2016 DonovanCotter. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Vehicle.h"

@protocol VINDelegate <NSObject>

-(void)sendVINToVC:(NSString*)VIN;

@end

@interface PreviousVINTVC : UIViewController {
    RLMResults *VINArray;
    Vehicle *selectedVin;
}

@property(nonatomic, weak) id<VINDelegate>delegate;

@end
