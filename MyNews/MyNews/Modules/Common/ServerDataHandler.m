//
//  ServerDataHandler.m
//  MyNews
//
//  Created by hushunfeng_CMCC on 16/9/13.
//  Copyright © 2016年 hushunfengPerson. All rights reserved.
//

#import "ServerDataHandler.h"
#import "MNHomeCell.h"

@implementation ServerDataHandler

SINGLETON_GENERATOR(ServerDataHandler, shareInstance)

- (instancetype)init
{
    self = [super init];
    if (self) {
        _configCell = ^(id cell,id data) {
            NSDictionary *dict = data;
            [(MNHomeCell*)cell configCellWithImage:[dict valueForKey:@"thumbnail_pic_s"]
                                             title:[dict valueForKey:@"title"]
                                             source:[dict valueForKey:@"author_name"]
                                             time:[dict valueForKey:@"date"]];
        };
    }
    return self;
}

@end
