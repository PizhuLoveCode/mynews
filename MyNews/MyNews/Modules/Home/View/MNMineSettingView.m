//
//  MNMineSettingView.m
//  MyNews
//
//  Created by hushunfeng_CMCC on 16/8/23.
//  Copyright © 2016年 hushunfengPerson. All rights reserved.
//

#import "MNMineSettingView.h"

@interface MNMineSettingView ()<UITableViewDelegate,UITableViewDataSource>
{
    NSString *_nickName;
    UIImage *_headImage;
    
}
@property (nonatomic, strong)UITableView *tableView;

@end

@implementation MNMineSettingView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame =  CGRectMake(Screen_Width, 64,Screen_Width * 2/3, Screen_Height - 64);
        
        [self configPersonInfo];
        
        [self addSubview:self.tableView];
        
    }
    return self;
}

#pragma mark - data
- (void)configPersonInfo {
    _nickName = @"痞子胡";
    _headImage = [UIImage imageNamed:@"main_me_active"];
}

#pragma mark - tableview datasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (0 == section) {
        UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _tableView.bounds.size.width, 55)];
        headView.backgroundColor = MNColor1;
        
        UIImageView *headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 0, 20, 20)];
        headImageView.contentMode = UIViewContentModeScaleAspectFill;
        headImageView.image = _headImage;
        headImageView.center = CGPointMake(15+10, headView.bounds.size.height / 2);
        
        UILabel *nickNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(headImageView.frame) + 10, 0, headView.bounds.size.width - 15 - 20 - 10, headView.bounds.size.height)];
        nickNameLabel.text = _nickName;
        [nickNameLabel setFont:MNFont(12)];
        
        [headView addSubview:headImageView];
        [headView addSubview:nickNameLabel];
        
        return headView;
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (0 == section) {
        return 55.f;
    }
    return 0.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    if (0 == indexPath.row) {
        
        CGSize itemSize = CGSizeMake(25, 20);
        UIGraphicsBeginImageContextWithOptions(itemSize, NO, 0.0);
        CGRect imageRect = CGRectMake(0, 0, itemSize.width, itemSize.height);
        
        cell.textLabel.font = MNFont(12);
        
        cell.textLabel.text = @"消息";
        [[UIImage imageNamed:@"msg_single_pic"] drawInRect:imageRect];
        cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    
    if (1 == indexPath.row) {
        CGSize itemSize = CGSizeMake(25, 20);
        UIGraphicsBeginImageContextWithOptions(itemSize, NO, 0.0);
        CGRect imageRect = CGRectMake(0, 0, itemSize.width, itemSize.height);
        
        cell.textLabel.font = MNFont(12);
        
        cell.textLabel.text = @"收藏";
        [[UIImage imageNamed:@"me_save"] drawInRect:imageRect];
        cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    
    if (2 == indexPath.row) {
        cell.textLabel.text = @"无图模式";
        cell.textLabel.font = MNFont(12);
        cell.accessoryView = [[UISwitch alloc] init];
    }
    
    if (3 == indexPath.row) {
        cell.textLabel.text = @"夜间模式";
        cell.textLabel.font = MNFont(12);
        cell.accessoryView = [[UISwitch alloc] init];
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.f;
}

#pragma mark - lazy load
- (UITableView *)tableView {
    if (nil == _tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

@end
