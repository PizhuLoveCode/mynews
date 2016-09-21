//
//  MNWebVC.m
//  MyNews
//
//  Created by hushunfeng_CMCC on 16/9/21.
//  Copyright © 2016年 hushunfengPerson. All rights reserved.
//

#import "MNWebVC.h"

@implementation MNWebVC 

-(void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIWebView *view = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, Screen_Width, Screen_Height - 64)];
    [self.view addSubview:view];
    view.delegate = self;
    [view loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_url]]];
}

@end
