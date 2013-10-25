//
//  Xml_Perser.h
//  test999
//
//  Created by wangdan on 11-8-31.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface Xml_Perser : NSObject<NSXMLParserDelegate>{
    
    NSString *str_elementName;
    NSMutableString *result;
    NSString *mark;
    BOOL recordResults;
}
- (BOOL)Xml_Perserdata:(NSMutableData *)webData Result_Mark:(NSString *)result_mark Result_Data:(NSMutableString *)result_data;
@end
