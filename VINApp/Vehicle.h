//
//  VehicleInfo.h
//  VINApp
//
//  Created by Donovan Cotter on 2/21/16.
//  Copyright © 2016 DonovanCotter. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Vehicle : NSObject

@property(nonatomic, strong) NSString *make;
@property(nonatomic, strong) NSString *model;
@property(nonatomic, strong) NSString *year;
@property(nonatomic, strong) NSString *baseMSRP;


-(id)initWithMake:(NSString *)make;
+(id)initWithMake:(NSString *)make;



@end
