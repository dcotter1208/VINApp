//
//  PreviousVINTVC.h
//  VINApp
//
//  Created by Donovan Cotter on 2/22/16.
//  Copyright © 2016 DonovanCotter. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol VINDelegate <NSObject>

-(void)sendVINToVC:(NSString*)VIN;

@end

@interface PreviousVINTVC : UIViewController

@property(nonatomic, weak) id<VINDelegate>delegate;

@property(nonatomic, strong) NSMutableArray *previousVINsArray;
@property(nonatomic, strong) NSString *VIN;

@end
