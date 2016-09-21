//
//  UIView+EX.m
//  MyNews
//
//  Created by hushunfeng_CMCC on 16/9/21.
//  Copyright © 2016年 hushunfengPerson. All rights reserved.
//

#import "UIView+EX.h"

@implementation UIView (EX)

- (CGFloat) x {
    return  self.frame.origin.x;
}

- (void)setX:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

@end
