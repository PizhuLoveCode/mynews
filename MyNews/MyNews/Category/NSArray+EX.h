//
//  NSArray+EX.h
//  MyNews
//
//  Created by hushunfeng_CMCC on 16/9/21.
//  Copyright © 2016年 hushunfengPerson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (EX)
- (id)safeObjectAtIndex:(NSUInteger)index;
- (void)safeAddObject:(id)anObject;

@end
