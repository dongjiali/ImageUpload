//
//  Base64_Encode_Decode.m
//  AVIVA_COFCO
//
//  Created by wang_d on 11-9-13.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "Base64_Encode_Decode.h"
#import "base64.h"


@implementation Base64_Encode_Decode

//解码
+ (NSString *)Base64Decode:(NSString *)stringValue
{
    //stringValue是从网络得到，编码格式是UTF-8
    Byte inputData[[stringValue lengthOfBytesUsingEncoding:NSUTF8StringEncoding]];
    [[stringValue dataUsingEncoding:NSUTF8StringEncoding] getBytes:inputData];
    size_t inputDataSize = (size_t)[stringValue length];
    size_t outputDataSize = EstimateBas64DecodedDataSize(inputDataSize);
    Byte outputData[outputDataSize];
    
    //调用base64解码核心模块
    Base64DecodeData(inputData, inputDataSize, outputData, &outputDataSize);
    
    //GBK是GB_18030_2000的一个子集
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    
    
    //将解码后的NSData数据还原为原始编码格式GB_18030_2000
    NSString *resultXML = [[[NSString alloc] initWithBytes:outputData length:outputDataSize encoding:enc ]autorelease];
    
    return resultXML;
}

//编码
+ (NSString*)Base64Encode:(NSString*)input   
{   
    //GBK是GB_18030_2000的一个子集
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);

    //将原始数据进行编码前处理
    size_t inputDataSize =[input lengthOfBytesUsingEncoding:enc]; 
    Byte inputData[inputDataSize];  
    [[input dataUsingEncoding:enc] getBytes:inputData];  
    size_t outputDataSize = EstimateBas64EncodedDataSize(inputDataSize);  
    char outputData[outputDataSize]; 
    
    //调用base64编码核心模块
    Base64EncodeData(inputData, inputDataSize, outputData, &outputDataSize,YES); 
    
    //将编码后的NSData转化为NSString，该数据是用于网络传输，因为编码后的数据没有汉字，因此转化为UTF-8
    NSString *result = [[[NSString alloc] initWithBytes:outputData length:outputDataSize encoding:NSUTF8StringEncoding ]autorelease]; 
    
    return result;    
}

@end
