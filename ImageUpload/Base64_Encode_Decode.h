//
//  Base64_Encode_Decode.h
//  AVIVA_COFCO
//
//  Created by wang_d on 11-9-13.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Base64_Encode_Decode : NSObject {
    
}

+ (NSString *)Base64Decode:(NSString *)stringValue;
+ (NSString *)Base64Encode:(NSString*)input;

@end
