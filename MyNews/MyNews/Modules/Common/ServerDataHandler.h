//
//  ServerDataHandler.h
//  MyNews
//
//  Created by hushunfeng_CMCC on 16/9/13.
//  Copyright © 2016年 hushunfengPerson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^ConfigCell)(UITableViewCell*,id);


@interface ServerDataHandler : NSObject

+(instancetype)shareInstance;

@property (nonatomic, copy)ConfigCell configCell;

@end
