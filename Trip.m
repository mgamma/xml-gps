//
//  Trip.m
//  xml and GPS
//
//  Created by Mark Harper on 12/4/13.
//  Copyright (c) 2013 XBrand Development. All rights reserved.
//

#import "Trip.h"

@implementation Trip

-(id)init{
    self = [super init];
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        self.locationStrings = [[NSMutableArray alloc]init];
        self.locationPoints = [[NSMutableDictionary alloc] init];
    });
    
    
    return self;
}
-(NSString *) howManyPassengers{
    return [self.chosenCar people];
}

-(void)addLocationString:(NSString *)ourLocation withLocation:(CLLocation *)ourPlacemark{

        [self.locationStrings addObject:ourLocation];
        [self.locationPoints setObject:ourPlacemark forKey:ourLocation];
}
    
    -(NSString *) getCostOfTrip{
        //Temporary Variables
        CLLocationDistance totalDistance = 0;
        CLLocation * location1;
        CLLocation * location2;
        
        //Iterate through the Visited Locations
        for(int i = 1; i<=[self.locationStrings count]; i++)
        {
            //Are we at the end of the array?
            if(i < [self.locationStrings count]){
                location1 = [self.locationPoints objectForKey:[self.locationStrings objectAtIndex:i-1]];
                location2 = [self.locationPoints objectForKey:[self.locationStrings objectAtIndex:i]];
            }else
            {
                //Get distance back home and add it too
                location1 = [self.locationPoints objectForKey:[self.locationStrings objectAtIndex:i-1]];
                location2 = [self.locationPoints objectForKey:[self.locationStrings objectAtIndex:0]];
            }
            
            //Calculate the distance between the two points
            CLLocationDistance distance=[location1 distanceFromLocation:location2];
            //Convert that into miles
            distance = distance/1609.344;
            //Add to the existing distance of the trip
            totalDistance += distance;
        }
        
        //Get Fuel Mileage from current car
        double fuelMileage = [[self.chosenCar mileage] doubleValue];
        //Calculate the Gallons of Fuel Used
        double gallonsOfFuel = totalDistance/fuelMileage; 
        //Multiply that by the cost -- This might be a setting
        double cost = gallonsOfFuel * 4.00;
        //return our cost in a string format
        return [NSString stringWithFormat:@"$%.2f",cost];
    
    }

    


@end
