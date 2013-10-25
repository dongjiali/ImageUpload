//
//  TrainNetWork.m
//  ImageUpload
//
//  Created by Curry on 13-10-11.
//  Copyright (c) 2013年 curry. All rights reserved.
//

#import "TrainNetWork.h"
#import <Foundation/NSJSONSerialization.h>
#import "TFHpple.h"
@implementation TrainNetWork
@synthesize asiFormDataRequest = _asiFormDataRequest;
@synthesize delegate = _delegate;
@synthesize longinDic = _longinDic;

- (void)getlogininit
{
    NSURL *url = [NSURL URLWithString:@"https://dynamic.12306.cn/otsweb/loginAction.do?method=init"];
    
    self.asiFormDataRequest  = [ASIFormDataRequest requestWithURL:url];
    [self.asiFormDataRequest setValidatesSecureCertificate:NO];
    self.asiFormDataRequest.useCookiePersistence = YES;
    [self.asiFormDataRequest setRequestMethod:@"GET"];
    [self.asiFormDataRequest buildPostBody];
    
    [self.asiFormDataRequest setCompletionBlock:^{
        NSString *responseString = [ self.asiFormDataRequest responseString ];
        //        NSLog(@"responseString -----------------%@",responseString);
        [self getloginrand];
    }];
    
    
    [self.asiFormDataRequest setFailedBlock:^{
        NSError*error =[self.asiFormDataRequest error];
        if (error) {
            NSLog(@"error = %@",error);
        }
        [self networkError:@"初始化失败"];
    }];
    [ self.asiFormDataRequest startSynchronous ];
}

//获取登陆信息
- (void)getlogin:(NSMutableDictionary *)loginDic
{
    self.longinDic = loginDic;
    NSURL *url = [NSURL URLWithString:@"https://dynamic.12306.cn/otsweb/loginAction.do?method=loginAysnSuggest"];
    
    self.asiFormDataRequest  = [ASIFormDataRequest requestWithURL:url];
    [self.asiFormDataRequest setValidatesSecureCertificate:NO];
    self.asiFormDataRequest.useCookiePersistence = YES;
    [self.asiFormDataRequest setRequestMethod:@"POST"];
    [self.asiFormDataRequest buildPostBody];
    [self.asiFormDataRequest setCompletionBlock:^{
        NSString *responseString = [ self.asiFormDataRequest responseString ];
        NSLog(@"responseString -----------------%@",responseString);
        NSError* error;
        NSDictionary* json = [[NSDictionary alloc]init];
        json = [NSJSONSerialization JSONObjectWithData:[self.asiFormDataRequest responseData] options:kNilOptions error:&error];
        NSLog(@"loginRand:%@",[json objectForKey:@"loginRand"]);
        NSLog(@"randError:%@",[json objectForKey:@"randError"]);
        if ([[json objectForKey:@"randError"] isEqualToString:@"Y"]) {
            [self.longinDic setObject:[json objectForKey:@"loginRand"] forKey:@"loginRand"];
            [self postloginInfo];
        }
    }];
    
    
    [self.asiFormDataRequest setFailedBlock:^{
        NSError*error =[self.asiFormDataRequest error];
        if (error) {
            NSLog(@"error = %@",error);
        }
        [self networkError:@"获取登陆信息失败"];
    }];
    [ self.asiFormDataRequest startSynchronous ];
}

//登陆
-(void)postloginInfo
{
    NSURL *url = [NSURL URLWithString:@"https://dynamic.12306.cn/otsweb/loginAction.do?method=login"];

    self.asiFormDataRequest  = [ASIFormDataRequest requestWithURL:url];
    [self.asiFormDataRequest setValidatesSecureCertificate:NO];
    self.asiFormDataRequest.useCookiePersistence = YES;
    
    [self.asiFormDataRequest setPostValue:[self.longinDic objectForKey:@"loginRand"] forKey:@"loginRand"];
    [self.asiFormDataRequest setPostValue:@"N" forKey:@"refundLogin"];
    [self.asiFormDataRequest setPostValue:@"Y" forKey:@"refundFlag"];
    [self.asiFormDataRequest setPostValue:@"" forKey:@"isClick"];
    [self.asiFormDataRequest setPostValue:@"null" forKey:@"form_tk"];
    [self.asiFormDataRequest setPostValue:@"djl330767040" forKey:@"loginUser.user_name"];
    [self.asiFormDataRequest setPostValue:@"" forKey:@"nameErrorFocus"];
    [self.asiFormDataRequest setPostValue:@"Djl330767040" forKey:@"user.password"];
    [self.asiFormDataRequest setPostValue:@"" forKey:@"passwordErrorFocus"];
    [self.asiFormDataRequest setPostValue:[self.longinDic objectForKey:@"randCode"] forKey:@"randCode"];
    [self.asiFormDataRequest setPostValue:@"" forKey:@"randErrorFocus"];
    [self.asiFormDataRequest setPostValue:@"undefined" forKey:@"myversion"];
//    [self.asiFormDataRequest setPostValue:@"NGVlYjYwNjEzYWU2NGJkMA==" forKey:@"NDExNTc2MQ=="];
    
    [self.asiFormDataRequest setRequestMethod:@"POST"];
    [self.asiFormDataRequest buildPostBody];
    [self.asiFormDataRequest setCompletionBlock:^{
        NSString *responseString = [ self.asiFormDataRequest responseString ];
        NSLog(@"responseString === ===== = ==%@",responseString);
        
        [self gettrainstationinfo];
    }];
    
    [self.asiFormDataRequest setFailedBlock:^{
        NSError*error =[self.asiFormDataRequest error];
        if (error) {
            NSLog(@"error = %@",error);
        }
        [self networkError:@"登陆失败"];
    }];
    [ self.asiFormDataRequest startSynchronous ];
}

//获取登陆的验证码
- (void)getloginrand
{
    NSURL *url = [NSURL URLWithString:@"https://dynamic.12306.cn/otsweb/passCodeNewAction.do?module=login&rand=sjrand"];
    self.asiFormDataRequest  = [ASIFormDataRequest requestWithURL:url];
    [self.asiFormDataRequest setValidatesSecureCertificate:NO];
    self.asiFormDataRequest.useCookiePersistence = YES;
    [self.asiFormDataRequest setRequestMethod:@"GET"];
    [self.asiFormDataRequest buildPostBody];
    
    [self.asiFormDataRequest setCompletionBlock:^{
        NSString *responseString = [ self.asiFormDataRequest responseString ];
        NSLog(@"responseString+++++++++++%@",[Base64_Encode_Decode Base64Decode:responseString]);
        
        NSString *result = [[NSString alloc] initWithData:[self.asiFormDataRequest responseData]  encoding:NSUTF8StringEncoding];
        NSLog(@"string$*(^&*++++++++++%@",result);
        NSData *data = [[NSData alloc]initWithData:[self.asiFormDataRequest responseData]];
        [_delegate resultDataToUI:data];
    }];
    
    
    [self.asiFormDataRequest setFailedBlock:^{
        NSError*error =[self.asiFormDataRequest error];
        if (error) {
            NSLog(@"error = %@",error);
        }
        [self networkError:@"获取登陆的验证码失败"];
    }];
    [ self.asiFormDataRequest startSynchronous ];
    
}

- (void)selecttrain:(NSMutableDictionary *)traininfo
{
    NSURL *url = [NSURL URLWithString:@"https://dynamic.12306.cn/otsweb/order/querySingleAction.do?method=qt"];
    self.asiFormDataRequest  = [ASIFormDataRequest requestWithURL:url];
    [self.asiFormDataRequest setValidatesSecureCertificate:NO];
    self.asiFormDataRequest.useCookiePersistence = YES;
    [self.asiFormDataRequest setRequestMethod:@"GET"];
    [self.asiFormDataRequest buildPostBody];
    [self.asiFormDataRequest setPostValue:@"qt" forKey:@"method"];
    [self.asiFormDataRequest setPostValue:@"2013-10-12" forKey:@"orderRequest.train_date"];
    [self.asiFormDataRequest setPostValue:@"BJP" forKey:@"orderRequest.from_station_telecode"];
    [self.asiFormDataRequest setPostValue:@"HBB" forKey:@"orderRequest.to_station_telecode"];
    [self.asiFormDataRequest setPostValue:@"2400000T170F" forKey:@"orderRequest.train_no"];
    [self.asiFormDataRequest setPostValue:@"QB" forKey:@"trainPassType"];
    [self.asiFormDataRequest setPostValue:@"QB#D#Z#T#K#QT#" forKey:@"trainClass"];
    [self.asiFormDataRequest setPostValue:@"00" forKey:@"includeStudent"];
    [self.asiFormDataRequest setPostValue:@"" forKey:@"seatTypeAndNum"];
    [self.asiFormDataRequest setPostValue:@"00:00--24:00" forKey:@"orderRequest.start_time_str"];
    
    [self.asiFormDataRequest setCompletionBlock:^{
        NSString *responseString = [ self.asiFormDataRequest responseString ];
        //        NSLog(@"huochexinxi$$$$$$$$$$$$$$%@",responseString);
        NSError* error;
        NSDictionary* json = [[NSDictionary alloc]init];
        json = [NSJSONSerialization JSONObjectWithData:[self.asiFormDataRequest responseData] options:kNilOptions error:&error];
        //        NSLog(@"sbjson$$$$$$$$$$%@",json);
        //        NSLog(@"loginRand:%@",[json objectForKey:@"loginRand"]);
        //        NSLog(@"randError:%@",[json objectForKey:@"randError"]);
        //        if ([[json objectForKey:@"randError"] isEqualToString:@"Y"]) {
        //            [self.longinDic setObject:[json objectForKey:@"loginRand"] forKey:@"loginRand"];
        //            [self postloginInfo];
        //        }
    }];
    
    [self.asiFormDataRequest setFailedBlock:^{
        NSError*error =[self.asiFormDataRequest error];
        if (error) {
            NSLog(@"error = %@",error);
        }
        [self networkError:@"初始化查询火车列表信息失败"];
    }];
    [ self.asiFormDataRequest startSynchronous ];
}

//初始化查询火车列表信息
- (void)gettrainstationinfo
{
    NSURL *url = [NSURL URLWithString:@"https://dynamic.12306.cn/otsweb/order/querySingleAction.do?method=init"];
    self.asiFormDataRequest  = [ASIFormDataRequest requestWithURL:url];
    [self.asiFormDataRequest setValidatesSecureCertificate:NO];
    self.asiFormDataRequest.useCookiePersistence = YES;
    [self.asiFormDataRequest setRequestMethod:@"POST"];
    [self.asiFormDataRequest buildPostBody];
    [self.asiFormDataRequest setPostValue:@"init" forKey:@"method"];
    [self.asiFormDataRequest setCompletionBlock:^{
        NSString *responseString = [ self.asiFormDataRequest responseString ];
        NSLog(@"huochexinxi$$$$$$$$$$$$$$%@",responseString);
        [_delegate resultFailed];
    }];
    
    [self.asiFormDataRequest setFailedBlock:^{
        NSError*error =[self.asiFormDataRequest error];
        if (error) {
            NSLog(@"error = %@",error);
        }
        [self networkError:@"初始化查询火车列表信息失败"];
    }];
    [ self.asiFormDataRequest startSynchronous ];
}

- (void)gettraininfos:(NSDictionary *)dic
{
    NSString *train_date = [self stringencoding:[dic objectForKey:@"orderRequest.train_date"]];
    NSString *rom_station_telecode = [self stringencoding:[dic objectForKey:@"orderRequest.from_station_telecode"]];
    NSString *to_station_telecode = [self stringencoding:[dic objectForKey:@"orderRequest.to_station_telecode"]];
    NSString *train_no = [self stringencoding:@""];
    NSString *trainPassType = [self stringencoding:@"QB"];
    NSString *trainClass = [self stringencoding:[dic objectForKey:@"trainClass"]];
    NSString *includeStudent = [self stringencoding:@"00"];
    NSString *seatTypeAndNum = [self stringencoding:@""];
    NSString *start_time_str = [self stringencoding:@"00:00--24:00"];
    NSString *TrinaNo = [self stringencoding:[dic objectForKey:@"orderRequest.train_no"]];
    NSURL *url= [NSURL URLWithString:[NSString stringWithFormat:@"https://dynamic.12306.cn/otsweb/order/querySingleAction.do?method=queryLeftTicket&orderRequest.train_date=%@&orderRequest.from_station_telecode=%@&orderRequest.to_station_telecode=%@&orderRequest.train_no=%@&trainPassType=%@&trainClass=%@&includeStudent=%@&seatTypeAndNum=%@&orderRequest.start_time_str=%@",train_date,rom_station_telecode,to_station_telecode,train_no,trainPassType,trainClass,includeStudent,seatTypeAndNum,start_time_str]];
    self.asiFormDataRequest  = [ASIFormDataRequest requestWithURL:url];
    [self.asiFormDataRequest setValidatesSecureCertificate:NO];
    self.asiFormDataRequest.useCookiePersistence = YES;
    [self.asiFormDataRequest setRequestMethod:@"GET"];
    [self.asiFormDataRequest buildPostBody];
    
    [self.asiFormDataRequest setCompletionBlock:^{
        NSString *responseString = [ self.asiFormDataRequest responseString ];
        if (responseString.length >0) {
            NSArray *array = [responseString componentsSeparatedByString:@"</a>"];
            for (NSString *string in array) {
                NSRange range = [string rangeOfString:TrinaNo];
                if (range.location != NSNotFound)
                {
                NSArray *array = [string componentsSeparatedByString:@"javascript:getSelected('"];
                    if (array.count > 1) {
                        NSArray *array2 = [[array objectAtIndex:1] componentsSeparatedByString:@"')"];
                        responseString =[array2 objectAtIndex:0];
                   [_delegate resultDataOrdeinfo:responseString];
                        return ;
                    }
                }
            }
        }
    }];
    [self.asiFormDataRequest setFailedBlock:^{
        NSError*error =[self.asiFormDataRequest error];
        if (error) {
            NSLog(@"error = %@",error);
        }
        [self networkError:@"车次预定失败"];
    }];
    [ self.asiFormDataRequest startSynchronous ];
}

//订票请求
- (void)orderrequestpost:(NSMutableDictionary *)orderDic
{
    NSString *station_train_code = [self stringencoding:[orderDic objectForKey:@"station_train_code"]];
    NSString *train_date = [self stringencoding:[orderDic objectForKey:@"train_date"]];
    NSString *seattype_num = [self stringencoding:@""];
    NSString *from_station_telecode = [self stringencoding:[orderDic objectForKey:@"from_station_telecode"]];
    NSString *to_station_telecode = [self stringencoding:[orderDic objectForKey:@"to_station_telecode"]];
    NSString *include_student = [self stringencoding:@"00"];
    NSString *from_station_telecode_name = [self stringencoding:[orderDic objectForKey:@"from_station_name"]];
    NSString *to_station_telecode_name = [self stringencoding:[orderDic objectForKey:@"to_station_name"]];
    NSString *round_train_date = [self stringencoding:[orderDic objectForKey:@"train_date"]];
    NSString *round_start_time_str = [self stringencoding:@"00:00--24:00"];
    NSString *single_round_type = [self stringencoding:@"1"];
    NSString *train_pass_type = [self stringencoding:@"QB"];
    NSString *train_class_arr = [self stringencoding:[orderDic objectForKey:@"train_class_arr"]];
    NSString *start_time_str = [self stringencoding:@"00:00--24:00"];
    NSString *lishi = [self stringencoding:[orderDic objectForKey:@"lishi"]];
    NSString *train_start_time = [self stringencoding:[orderDic objectForKey:@"train_start_time"]];
    NSString *trainno4 = [self stringencoding:[orderDic objectForKey:@"trainno4"]];
    NSString *arrive_time = [self stringencoding:[orderDic objectForKey:@"arrive_time"]];
    NSString *from_station_name = [self stringencoding:[orderDic objectForKey:@"from_station_name"]];
    NSString *to_station_name = [self stringencoding:[orderDic objectForKey:@"to_station_name"]];
    NSString *from_station_no = [self stringencoding:[orderDic objectForKey:@"from_station_no"]];
    NSString *to_station_no = [self stringencoding:[orderDic objectForKey:@"to_station_no"]];
    NSString *ypInfoDetail = [self stringencoding:[orderDic objectForKey:@"ypInfoDetail"]];
    NSString *mmStr = [self stringencoding:[orderDic objectForKey:@"mmStr"]];
    NSString *locationCode = [self stringencoding:[orderDic objectForKey:@"locationCode"]];
    NSString *myversion = [self stringencoding:@"undefined"];
    
//    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://dynamic.12306.cn/otsweb/order/querySingleAction.do?method=submutOrderRequest&station_train_code=%@&train_date=%@&seattype_num=%@&from_station_telecode=%@&to_station_telecode=%@&include_student=%@&from_station_telecode_name=%@&to_station_telecode_name=%@&round_train_date=%@&round_start_time_str=%@&single_round_type=%@&train_pass_type=%@&train_class_arr=%@&start_time_str=%@&lishi=%@&train_start_time=%@&trainno4=%@&arrive_time=%@&from_station_name=%@&to_station_name=%@&from_station_no=%@&to_station_no=%@&ypInfoDetail=%@&mmStr=%@&locationCode=%@&myversion=%@&",station_train_code,train_date,seattype_num,from_station_telecode,to_station_telecode,include_student,from_station_telecode_name,to_station_telecode_name,round_train_date,round_start_time_str,single_round_type,train_pass_type,train_class_arr,start_time_str,lishi,train_start_time,trainno4,arrive_time,from_station_name,to_station_name,from_station_no,to_station_no,ypInfoDetail,mmStr,locationCode,myversion]];
    NSURL *url = [NSURL URLWithString:@"https://dynamic.12306.cn/otsweb/order/querySingleAction.do?method=submutOrderRequest"];
    self.asiFormDataRequest  = [ASIFormDataRequest requestWithURL:url];
    [self.asiFormDataRequest addRequestHeader:@"Referer" value:@"https://dynamic.12306.cn/otsweb/order/querySingleAction.do?method=init"];
    [self.asiFormDataRequest setValidatesSecureCertificate:NO];
    self.asiFormDataRequest.useCookiePersistence = YES;
    [self.asiFormDataRequest setRequestMethod:@"POST"];
//    [self.asiFormDataRequest setValue:station_train_code forKey:@"station_train_code"];
//    [self.asiFormDataRequest setValue:train_date forKey:@"train_date"];
//    [self.asiFormDataRequest setValue:seattype_num forKey:@"seattype_num"];
//    [self.asiFormDataRequest setValue:from_station_telecode forKey:@"from_station_telecode"];
//    [self.asiFormDataRequest setValue:to_station_telecode forKey:@"to_station_telecode"];
//    [self.asiFormDataRequest setValue:include_student forKey:@"include_student"];
//    [self.asiFormDataRequest setValue:from_station_telecode_name forKey:@"from_station_telecode_name"];
//    [self.asiFormDataRequest setValue:to_station_telecode_name forKey:@"to_station_telecode_name"];
//    [self.asiFormDataRequest setValue:round_train_date forKey:@"round_train_date"];
//    [self.asiFormDataRequest setValue:round_start_time_str forKey:@"round_start_time_str"];
//    [self.asiFormDataRequest setValue:single_round_type forKey:@"single_round_type"];
//    [self.asiFormDataRequest setValue:train_class_arr forKey:@"train_class_arr"];
//    [self.asiFormDataRequest setValue:start_time_str forKey:@"start_time_str"];
//    [self.asiFormDataRequest setValue:lishi forKey:@"lishi"];
//    [self.asiFormDataRequest setValue:train_pass_type forKey:@"train_pass_type"];
//    [self.asiFormDataRequest setValue:train_start_time forKey:@"train_start_time"];
//    [self.asiFormDataRequest setValue:trainno4 forKey:@"trainno4"];
//    [self.asiFormDataRequest setValue:arrive_time forKey:@"arrive_time"];
//    [self.asiFormDataRequest setValue:from_station_name forKey:@"from_station_name"];
//    [self.asiFormDataRequest setValue:to_station_name forKey:@"to_station_name"];
//    [self.asiFormDataRequest setValue:from_station_no forKey:@"from_station_no"];
//    [self.asiFormDataRequest setValue:to_station_no forKey:@"to_station_no"];
//    [self.asiFormDataRequest setValue:ypInfoDetail forKey:@"ypInfoDetail"];
//    [self.asiFormDataRequest setValue:mmStr forKey:@"mmStr"];
//    [self.asiFormDataRequest setValue:locationCode forKey:@"locationCode"];
//    [self.asiFormDataRequest setValue:myversion forKey:@"myversion"];
    [self.asiFormDataRequest buildPostBody];
    [self.asiFormDataRequest setCompletionBlock:^{
        NSString *responseString = [ self.asiFormDataRequest responseString ];
        NSLog(@"huochexinxi$$$$$$$$$$$$$$%@",responseString);
    }];
    
    [self.asiFormDataRequest setFailedBlock:^{
        NSError*error =[self.asiFormDataRequest error];
        if (error) {
            NSLog(@"error = %@",error);
        }

        [self networkError:@"查询车次失败"];
    }];
    [ self.asiFormDataRequest startSynchronous ];
}


//订票请求
- (void)dingpiaoPost
{
    NSURL *url = [NSURL URLWithString:@"https://dynamic.12306.cn/otsweb/order/confirmPassengerAction.do?method=checkOrderInfo&rand=77ux"];
        self.asiFormDataRequest  = [ASIFormDataRequest requestWithURL:url];
        [self.asiFormDataRequest setValidatesSecureCertificate:NO];
        self.asiFormDataRequest.useCookiePersistence = YES;
        [self.asiFormDataRequest setRequestMethod:@"POST"];
        [self.asiFormDataRequest buildPostBody];
        [self.asiFormDataRequest setPostValue:@"中文或拼音首字母" forKey:@"textfield"];
        [self.asiFormDataRequest setPostValue:@"0" forKey:@"checkbox0"];
        [self.asiFormDataRequest setPostValue:@"2013-10-14" forKey:@"orderRequest.train_date"];
        [self.asiFormDataRequest setPostValue:@"2400000K390X" forKey:@"orderRequest.train_no"];
        [self.asiFormDataRequest setPostValue:@"K39" forKey:@"orderRequest.station_train_code"];
        [self.asiFormDataRequest setPostValue:@"BJP" forKey:@"orderRequest.from_station_telecode"];
        [self.asiFormDataRequest setPostValue:@"HBB" forKey:@"orderRequest.to_station_telecode"];
        [self.asiFormDataRequest setPostValue:@"" forKey:@"orderRequest.seat_type_code"];
        [self.asiFormDataRequest setPostValue:@"" forKey:@"orderRequest.ticket_type_order_num"];
        [self.asiFormDataRequest setPostValue:@"000000000000000000000000000000" forKey:@"orderRequest.bed_level_order_num"];
            [self.asiFormDataRequest setPostValue:@"23:00" forKey:@"orderRequest.start_time"];
            [self.asiFormDataRequest setPostValue:@"14:49" forKey:@"orderRequest.end_time"];
            [self.asiFormDataRequest setPostValue:@"北京" forKey:@"orderRequest.from_station_name"];
            [self.asiFormDataRequest setPostValue:@"哈尔滨" forKey:@"orderRequest.to_station_name"];
    [self.asiFormDataRequest setPostValue:@"1" forKey:@"orderRequest.cancel_flag"];
    [self.asiFormDataRequest setPostValue:@"Y" forKey:@"orderRequest.id_mode"];
    [self.asiFormDataRequest setPostValue:@"1,0,1,董家力,1,230102198806245312,15801044297,Y" forKey:@"passengerTickets"];
    [self.asiFormDataRequest setPostValue:@"董家力,1,230102198806245312" forKey:@"oldPassengers"];
    [self.asiFormDataRequest setPostValue:@"1" forKey:@"passenger_1_seat"];
    [self.asiFormDataRequest setPostValue:@"1" forKey:@"passenger_1_ticket"];
    [self.asiFormDataRequest setPostValue:@"董家力" forKey:@"passenger_1_name"];
    [self.asiFormDataRequest setPostValue:@"1" forKey:@"passenger_1_cardtype"];
    [self.asiFormDataRequest setPostValue:@"230102198806245312" forKey:@"passenger_1_cardno"];
    [self.asiFormDataRequest setPostValue:@"15801044297" forKey:@"passenger_1_mobileno"];
    [self.asiFormDataRequest setPostValue:@"Y" forKey:@"checkbox9"];
    [self.asiFormDataRequest setPostValue:@"" forKey:@"oldPassengers"];
    [self.asiFormDataRequest setPostValue:@"Y" forKey:@"checkbox9"];
    [self.asiFormDataRequest setPostValue:@"" forKey:@"oldPassengers"];
    [self.asiFormDataRequest setPostValue:@"Y" forKey:@"checkbox9"];
    [self.asiFormDataRequest setPostValue:@"" forKey:@"oldPassengers"];
    [self.asiFormDataRequest setPostValue:@"Y" forKey:@"checkbox9"];
    [self.asiFormDataRequest setPostValue:@"" forKey:@"oldPassengers"];
    [self.asiFormDataRequest setPostValue:@"Y" forKey:@"checkbox9"];
    [self.asiFormDataRequest setPostValue:@"77ux" forKey:@"randCode"];
    [self.asiFormDataRequest setPostValue:@"A" forKey:@"orderRequest.reserve_flag"];
    [self.asiFormDataRequest setPostValue:@"dc" forKey:@"tFlag"];
    [self.asiFormDataRequest setCompletionBlock:^{
        NSString *responseString = [ self.asiFormDataRequest responseString ];
        NSLog(@"huochexinxi$$$$$$$$$$$$$$%@",responseString);
    }];
    
    [self.asiFormDataRequest setFailedBlock:^{
        NSError*error =[self.asiFormDataRequest error];
        if (error) {
            NSLog(@"error = %@",error);
        }
        [self networkError:@"查询失败"];
    }];
    [ self.asiFormDataRequest startSynchronous ];
}

- (void)networkError:(NSString *)error
{
    [[[[UIAlertView alloc] initWithTitle:@"提示信息:"
                                 message:@"error"
                                delegate:nil
                       cancelButtonTitle:@"确定"
                       otherButtonTitles:nil] autorelease] show];
}

- (NSString *)stringencoding:(NSString *)string
{
    return [string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

- (void)dealloc
{
    [_longinDic release];
    [_asiFormDataRequest release];
    [super dealloc];
}

@end
