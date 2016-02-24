//
//  VehicleInfo.h
//  VINApp
//
//  Created by Donovan Cotter on 2/21/16.
//  Copyright © 2016 DonovanCotter. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Realm/Realm.h"

@interface Vehicle : RLMObject

@property(nonatomic, strong) NSString *make;
@property(nonatomic, strong) NSString *model;
@property(nonatomic, strong) NSString *year;
@property(nonatomic, strong) NSString *baseMSRP;
@property(nonatomic, strong) NSString *VIN;

-(id)initWithMake:(NSString *)make;
+(id)initWithMake:(NSString *)make;

@end
