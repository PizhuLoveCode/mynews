//
//  MNNetWorkingManager.h
//  MyNews
//
//  Created by hushunfeng_CMCC on 16/9/12.
//  Copyright © 2016年 hushunfengPerson. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^successHandle)(NSDictionary *result);
typedef void(^failHandle)(NSError *error);

@interface MNNetWorkingManager : NSObject

+(instancetype)sharedManager;

-(void)getDataWithUrl:(NSString *)Url Params:(NSDictionary *)params success:(successHandle)success fail:(failHandle)fail;

@end
