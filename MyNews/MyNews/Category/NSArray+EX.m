//
//  NSArray+EX.m
//  MyNews
//
//  Created by hushunfeng_CMCC on 16/9/21.
//  Copyright © 2016年 hushunfengPerson. All rights reserved.
//

#import "NSArray+EX.h"

@implementation NSArray (EX)

- (id)safeObjectAtIndex:(NSUInteger)index
{
    if(self && self.count > 0 && index < self.count)
    {
        id obj = [self objectAtIndex:index];
        if ([obj isKindOfClass:[NSNull class]])
        {
            obj = nil;
        }
        return obj;
    }
    return nil;
}

- (void)safeAddObject:(id)anObject
{
    if ([self isKindOfClass:[NSMutableArray class]] && nil != anObject) {
        [(NSMutableArray *)self addObject:anObject];
    }
}

@end
