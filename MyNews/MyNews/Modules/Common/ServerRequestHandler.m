//
//  ServerRequestHandler.m
//  MyNews
//
//  Created by hushunfeng_CMCC on 16/9/13.
//  Copyright © 2016年 hushunfengPerson. All rights reserved.
//

#import "ServerRequestHandler.h"
#import "MNNetWorkingManager.h"

@implementation ServerRequestHandler
SINGLETON_GENERATOR(ServerRequestHandler, shareInstance)

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(void)requestDataWithParams:(NSDictionary*)params handelData:(GetDataBlock)getDataBlock {
    __block NSArray *datas = [NSArray array];
    [[MNNetWorkingManager sharedManager] getDataWithUrl:@"http://v.juhe.cn/toutiao/index" Params:params success:^(NSDictionary *result) {
        NSDictionary *res = [result valueForKey:@"result"];
        datas = [res valueForKey:@"data"];
        getDataBlock(datas);
       } fail:^(NSError *error) {
           getDataBlock(datas);
    }];
}

@end
