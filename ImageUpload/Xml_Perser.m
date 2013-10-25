//
//  Xml_Perser.m
//  test999
//
//  Created by wangdan on 11-8-31.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "Xml_Perser.h"

@implementation Xml_Perser

- (void)dealloc
{
    [super dealloc];
}

#pragma mark - View lifecycle


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (BOOL)Xml_Perserdata:(NSMutableData *)webData Result_Mark:(NSString *)result_mark Result_Data:(NSMutableString *)result_data;
{
    mark = result_mark;
    result = result_data;    
    
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:webData]; //设置XML数据
    [parser setShouldProcessNamespaces:NO];
    [parser setShouldReportNamespacePrefixes:NO];
    [parser setShouldResolveExternalEntities:NO];
    [parser setDelegate: self];
    [parser parse];
    [parser release];
    
    return YES;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
   if ( [elementName isEqualToString:mark] )
   {
       recordResults = YES;
   }
    
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if ( recordResults )
    {
        [result appendString:string];
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if ( [elementName isEqualToString:mark] )
    {
        recordResults = FALSE;
        NSLog(@"xml_result=%@",result);
        
    }
}

@end
