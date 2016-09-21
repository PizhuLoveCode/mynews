//
//  ServerRequestHandler.h
//  MyNews
//
//  Created by hushunfeng_CMCC on 16/9/13.
//  Copyright © 2016年 hushunfengPerson. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^GetDataBlock)(NSArray*);

@interface ServerRequestHandler : NSObject

+(instancetype)shareInstance;
-(void)requestDataWithParams:(NSDictionary*)params handelData:(GetDataBlock)getDataBlock;
@end
