//
//  Trip.h
//  xml and GPS
//
//  Created by Mark Harper on 12/4/13.
//  Copyright (c) 2013 XBrand Development. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Car.h"
#import <CoreLocation/CoreLocation.h>

@interface Trip : NSObject
@property(nonatomic,strong)Car * chosenCar;
@property(nonatomic,strong)NSMutableArray * locationStrings;
@property(nonatomic,strong)NSMutableDictionary * locationPoints;
-(NSString *) howManyPassengers;
-(void)addLocationString:(NSString *)ourLocation withLocation:(CLLocation *)ourPlacemark;

-(NSString *) getCostOfTrip;


@end
