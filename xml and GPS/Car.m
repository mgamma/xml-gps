//
//  Car.m
//  xml and GPS
//
//  Created by Mark Harper on 11/28/13.
//  Copyright (c) 2013 XBrand Development. All rights reserved.
//

#import "Car.h"

@implementation Car
-(void)printTheCar{
    NSLog(@"\n Name = %@\n Holds %@ people\n Gets %@ mpg\n Located at an x value of %@\n\n", self.name,self.people,self.mileage,self.center);
}

@end
