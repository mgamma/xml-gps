//
//  Car.h
//  xml and GPS
//
//  Created by Mark Harper on 11/28/13.
//  Copyright (c) 2013 XBrand Development. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Car : NSObject
@property(nonatomic,strong)NSString * name;
@property(nonatomic,strong)NSString * mileage;
@property(nonatomic,strong)NSString * people;
@property(nonatomic,strong)NSString * center;
-(void)printTheCar;

@end
