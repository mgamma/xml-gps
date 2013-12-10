//
//  MyAnnotation.h
//  xml and GPS
//
//  Created by Mark Harper on 12/4/13.
//  Copyright (c) 2013 XBrand Development. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MyAnnotation : NSObject<MKAnnotation>
@property(nonatomic,readonly)CLLocationCoordinate2D coordinate;
-(id)initWithCoordinate:(CLLocationCoordinate2D)coord;
@end
