//
//  MNHomeVC.m
//  MyNews
//
//  Created by hushunfeng_CMCC on 16/8/23.
//  Copyright © 2016年 hushunfengPerson. All rights reserved.
//

#import "MNHomeVC.h"
#import "MNMineSettingView.h"
#import "AVOSCloudSNS.h"
#import "MNNetWorkingManager.h"
#import "MNHomeCell.h"
#import "MNWebVC.h"

#define ItemBaseTag  10101

@interface MNHomeVC ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
{
    BOOL _isHomeBtnSelected;
    BOOL _isMineBtnSelected;
    
    NSArray *_itemsDictValue;
    
    NSArray *_netDatas;
}
@property (nonatomic, strong)UIScrollView *topScrollView;
@property (nonatomic, strong)UIScrollView *pageScrollView;
@property (nonatomic, strong)MNMineSettingView *mineSettingView;
@property (nonatomic, strong)UIVisualEffectView *effectView;//毛玻璃效果图层
@property (nonatomic, strong)NSMutableArray<UITableView*> *tableViewArray;
@property (nonatomic, strong)NSMutableArray<UIButton *> *btnArray;

@property (nonatomic, strong)UIView *line;

@end

@implementation MNHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"我的新闻";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"main_home_nor"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(clickHome:)];
    _isHomeBtnSelected = NO;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"main_me_nor"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(clickMine:)];
    _isMineBtnSelected = NO;
    
    //读取plist
    NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"newsType" ofType:@"plist"];
    NSDictionary *itemsDict = [[NSDictionary alloc]initWithContentsOfFile:plistPath];
    NSArray *items = [itemsDict allKeys];
    _itemsDictValue = [itemsDict allValues];
    
    [self.view addSubview:self.topScrollView];
    _topScrollView.contentSize = CGSizeMake(Screen_Width * items.count/5, 35);
    
    [self.view addSubview:self.pageScrollView];
    _pageScrollView.contentSize =  CGSizeMake(Screen_Width * items.count, Screen_Height-64-35);
    
    _tableViewArray = [NSMutableArray array];
    _btnArray = [NSMutableArray array];
    for (int i = 0; i < items.count; i++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(Screen_Width * i/5, 0, Screen_Width / 5, 35)];
        [btn setTitle:items[i] forState:UIControlStateNormal];
        btn.titleLabel.font = MNFont(12);
        [btn setTitleColor:MNColor2 forState:UIControlStateNormal];
        btn.tag = ItemBaseTag + i;
        [btn addTarget:self action:@selector(itemBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_topScrollView addSubview:btn];
        [_btnArray safeAddObject:btn];
        
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(Screen_Width * i, 0, Screen_Width, Screen_Height-64-35) style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        
        [_tableViewArray safeAddObject:tableView];
        [_pageScrollView addSubview:tableView];
        
    }
    
    [_topScrollView addSubview:self.line];
    
    [self netRequest:@{@"type":_itemsDictValue[0],@"key":AppKey} tableView:_tableViewArray[0]];

}

#pragma mark - btn delegate
- (void)netRequest:(NSDictionary *)params tableView:(UITableView*)tableView{
    _netDatas = [NSArray array];
    [[ServerRequestHandler shareInstance] requestDataWithParams:params handelData:^(NSArray *data) {
        _netDatas = [data copy];
        dispatch_async(dispatch_get_main_queue(), ^{
            [tableView reloadData];
        });
    }];
}

-(void)itemBtnClick:(UIButton *)btn {
    [_pageScrollView setContentOffset:CGPointMake((btn.tag - ItemBaseTag)*Screen_Width, 0) animated:YES];
    _line.x = btn.frame.origin.x;
    NSString *value = _itemsDictValue[btn.tag - ItemBaseTag];
    [self netRequest:@{@"type":value,@"key":AppKey} tableView:[_tableViewArray safeObjectAtIndex:(btn.tag - ItemBaseTag)]];
}

- (void)clickHome:(UIBarButtonItem *)barButtonItem {
    NSLog(@"clickHome");
}

- (void)clickMine:(UIBarButtonItem *)barButtonItem {
    NSLog(@"clickMine");
    _isMineBtnSelected = !_isMineBtnSelected;

    if (_isMineBtnSelected) {
        [self.view addSubview:self.effectView];
        barButtonItem.image = [[UIImage imageNamed:@"main_me_active"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
         _mineSettingView = [[MNMineSettingView alloc] init];
        [self.view addSubview:_mineSettingView];
        
        [UIView animateWithDuration:0.2f animations:^{
            _mineSettingView.frame = CGRectMake(Screen_Width/3, 64,Screen_Width * 2/3, Screen_Height - 64);
        } completion:^(BOOL finished) {
            
        }];
    }
    else {
        barButtonItem.image = [[UIImage imageNamed:@"main_me_nor"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [UIView animateWithDuration:0.2f animations:^{
            _mineSettingView.frame = CGRectMake(Screen_Width, 64,Screen_Width * 2/3, Screen_Height - 64);
        }completion:^(BOOL finished) {
            [_mineSettingView removeFromSuperview];
            _mineSettingView = nil;
            [self.effectView removeFromSuperview];
        }];
    }
}

#pragma mark -tableview delegate && datasource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *homeCellIdentifier = @"homeCellidentifier";
    MNHomeCell *homeCell = [tableView dequeueReusableCellWithIdentifier:homeCellIdentifier];
    if (!homeCell) {
        homeCell = [[MNHomeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:homeCellIdentifier];
    }
    [ServerDataHandler shareInstance].configCell(homeCell,[_netDatas safeObjectAtIndex:indexPath.row]);
    return homeCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dict = [_netDatas safeObjectAtIndex:indexPath.row];
    NSString *url = [dict valueForKey:@"url"];

    MNWebVC *vc = [[MNWebVC alloc] init];
    vc.url = url;
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _netDatas.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return Screen_Width /3 + 70;
}

#pragma mark - scrollview delegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (![scrollView isKindOfClass:[UITableView class]]) {
        int i = scrollView.contentOffset.x / Screen_Width;
        NSString *value = _itemsDictValue[i];
        _line.x = ((UIButton *)[_btnArray safeObjectAtIndex:i]).frame.origin.x;
        [self netRequest:@{@"type":value,@"key":AppKey} tableView:[_tableViewArray safeObjectAtIndex:i]];
        
        if ([scrollView.panGestureRecognizer translationInView:scrollView.superview].x < 0 ) {
            NSLog(@"向左滑动");
            [_topScrollView setContentOffset:CGPointMake(_topScrollView.contentOffset.x + Screen_Width / 5, 0) animated:YES];
        }
        else if([scrollView.panGestureRecognizer translationInView:scrollView.superview].x > 0 ) {
            [_topScrollView setContentOffset:CGPointMake(_topScrollView.contentOffset.x - Screen_Width / 5, 0) animated:YES];
        }
        else {
            return;
        }
    }
}


#pragma mark - lazy load
- (void)tapEffectView {
    if (_isMineBtnSelected) {
        [self clickMine:self.navigationItem.rightBarButtonItem];
    }
    if (_isHomeBtnSelected) {
        [self clickMine:self.navigationItem.leftBarButtonItem];
    }
}
- (UIVisualEffectView *)effectView {
    if (nil == _effectView) {
        _effectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
        _effectView.frame = CGRectMake(0, 64,Screen_Width, Screen_Height-64);
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapEffectView)];
        [_effectView addGestureRecognizer:tap];
    }
    return _effectView;
}
- (UIScrollView *)topScrollView {
    if (nil == _topScrollView) {
        _topScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, Screen_Width, 35)];
        _topScrollView.backgroundColor = MNColor1;
        _topScrollView.showsHorizontalScrollIndicator = NO;
        _topScrollView.showsVerticalScrollIndicator = NO;
        _topScrollView.directionalLockEnabled = YES;
    }
    return _topScrollView;
}


- (UIScrollView *)pageScrollView {
    if (nil == _pageScrollView) {
        _pageScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64+35, Screen_Width, Screen_Height-64-35)];
        _pageScrollView.showsHorizontalScrollIndicator = NO;
        _pageScrollView.showsVerticalScrollIndicator = NO;
        _pageScrollView.directionalLockEnabled = YES;
        _pageScrollView.pagingEnabled = YES;
        _pageScrollView.delegate = self;
    }
    return _pageScrollView;
}

- (UIView *)line {
    if (nil == _line) {
        _line = [[UIView alloc] initWithFrame:CGRectMake(0, _topScrollView.bounds.size.height-2, Screen_Width / 5 , 2)];
        _line.backgroundColor = [UIColor redColor];
    }
    return _line;
}

@end
