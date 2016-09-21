//
//  MNNetWorkingManager.m
//  MyNews
//
//  Created by hushunfeng_CMCC on 16/9/12.
//  Copyright © 2016年 hushunfengPerson. All rights reserved.
//

#import "MNNetWorkingManager.h"
#import "AFNetworking.h"

@implementation MNNetWorkingManager

SINGLETON_GENERATOR(MNNetWorkingManager, sharedManager)

-(void)getDataWithUrl:(NSString *)Url Params:(NSDictionary *)params success:(successHandle)success fail:(failHandle)fail{
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    //将字典参数解析
    NSMutableArray *keys = [NSMutableArray array];
    keys = [[params allKeys] mutableCopy];
    NSMutableArray *values = [NSMutableArray array];
    values = [[params allValues] mutableCopy];
    
    //url
    NSString *paramsStr = @"";
    for (int i = 0; i < keys.count; i++) {
        paramsStr = [paramsStr stringByAppendingString:[NSString stringWithFormat:@"%@=%@",keys[i],values[i]]];
        if (i == keys.count-1) {
            break;
        }
        else {
            paramsStr = [paramsStr stringByAppendingString:@"&"];
        }
    }
    NSLog(@"paramsStr:%@",paramsStr);
    
    NSString *urlStr = [NSString stringWithFormat:@"%@?%@",Url,paramsStr];
    NSLog(@"URL:%@",urlStr);
    
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSURLSessionTask *task = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            NSLog(@"get net data error:%@",error);
            fail(error);
        }
        else {
//            NSLog(@"data:%@",data);
//            NSLog(@"response:%@",response);
            
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
            NSLog(@"dict:%@",dict);
            
            success(dict);
        }
        
    }];
    // 开启任务
    [task resume];
}


@end
