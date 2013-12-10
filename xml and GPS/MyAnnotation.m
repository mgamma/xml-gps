//
//  MyAnnotation.m
//  xml and GPS
//
//  Created by Mark Harper on 12/4/13.
//  Copyright (c) 2013 XBrand Development. All rights reserved.
//

#import "MyAnnotation.h"


@implementation MyAnnotation
-(id)initWithCoordinate:(CLLocationCoordinate2D)coord{
    _coordinate = coord;
    return self;

}
@end
