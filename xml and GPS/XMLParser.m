//
//  XMLParser.m
//  xml and GPS
//
//  Created by Mark Harper on 11/28/13.
//  Copyright (c) 2013 XBrand Development. All rights reserved.
//

#import "XMLParser.h"

@implementation XMLParser
-(id)initXMLParser{
    self.allCars = [[NSMutableArray alloc]init];
    return self;
}

//didStartElement
-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
    if ([elementName isEqualToString:@"car"]) {
        self.currentCarInstance = [[Car alloc]init];
    }
}


//foundCharacters
-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    if (self.currentItemString) {
        [self.currentItemString appendString:string];
    }else{
        self.currentItemString = [[NSMutableString alloc]initWithString:string];
    }
}

//didEndElement
-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    if ([elementName isEqualToString:@"garage"]) {
        return;
    }
    if ([elementName isEqualToString:@"car"]) {
        [self.allCars addObject:self.currentCarInstance];self.currentCarInstance = nil;
        
    }else{
        
        NSString * temp = [self.currentItemString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        [self.currentCarInstance setValue:temp forKey:elementName];
    }
    self.currentItemString = nil;
}















@end
