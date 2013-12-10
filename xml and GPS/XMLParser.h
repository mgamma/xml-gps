//
//  XMLParser.h
//  xml and GPS
//
//  Created by Mark Harper on 11/28/13.
//  Copyright (c) 2013 XBrand Development. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Car.h"

@interface XMLParser : NSObject <NSXMLParserDelegate>
@property(nonatomic,strong)NSMutableString * currentItemString;
@property(nonatomic,strong)Car * currentCarInstance;
@property(nonatomic,strong)NSMutableArray * allCars;
-(id)initXMLParser;

@end
