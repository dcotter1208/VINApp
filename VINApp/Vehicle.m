//
//  VehicleInfo.m
//  VINApp
//
//  Created by Donovan Cotter on 2/21/16.
//  Copyright © 2016 DonovanCotter. All rights reserved.
//

#import "Vehicle.h"

@implementation Vehicle

-(id)initWithMake:(NSString *)make {
    self = [super init];
    
    if (self) {
        _make = make;
    }
    return self;
}

+(id)initWithMake:(NSString *)make {
    return [[self alloc]initWithMake:make];
}

@end
