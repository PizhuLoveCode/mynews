//
//  MNHomeCell.m
//  MyNews
//
//  Created by hushunfeng_CMCC on 16/9/13.
//  Copyright © 2016年 hushunfengPerson. All rights reserved.
//

#import "MNHomeCell.h"

@interface MNHomeCell ()
@property (nonatomic, strong)UIImageView *infoImageView;
@property (nonatomic, strong)UILabel *timeLabel;
@property (nonatomic, strong)UILabel *sourceLabel;
@property (nonatomic, strong)UILabel *titleLabel;

@end

@implementation MNHomeCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.infoImageView];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.sourceLabel];
        [self.contentView addSubview:self.timeLabel];
        
        //layout
        [_infoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).with.offset(10);
            make.right.mas_equalTo(self.mas_right).with.offset(-10);
            make.top.mas_equalTo(self.mas_top).with.offset(10);
            make.height.mas_equalTo(Screen_Width/3);
        }];
        
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_infoImageView.mas_bottom).with.offset(10);
            make.left.mas_equalTo(_infoImageView.mas_left).with.offset(0);
            make.right.mas_equalTo(_infoImageView.mas_right).with.offset(0);
        }];
        
        [_sourceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_titleLabel.mas_bottom).with.offset(10);
            make.left.mas_equalTo(_titleLabel.mas_left).with.offset(0);
        }];
        
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_sourceLabel.mas_right).with.offset(10);
            make.top.mas_equalTo(_sourceLabel.mas_top).with.offset(0);
        }];
    }
    return self;
}

- (void)configCellWithImage:(NSString *)URL title:(NSString *)title source:(NSString *)source time:(NSString *)time {
    [_infoImageView sd_setImageWithURL:[NSURL URLWithString:URL]];
    _titleLabel.text = title;
    _sourceLabel.text = source;
    _timeLabel.text = time;
    
    [_timeLabel sizeToFit];
    _timeLabel.numberOfLines = 0;
}

#pragma mark - lazy load
- (UIImageView *)infoImageView {
    if (nil == _infoImageView) {
        _infoImageView = [[UIImageView alloc] init];
        _infoImageView.contentMode = UIViewContentModeScaleAspectFill;
        _infoImageView.clipsToBounds = YES;
    }
    return _infoImageView;
}

- (UILabel *)timeLabel {
    if (nil == _timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        [_timeLabel setFont:MNFont(10)];
    }
    return _timeLabel;
}

- (UILabel *)sourceLabel {
    if (nil == _sourceLabel) {
        _sourceLabel = [[UILabel alloc] init];
        [_sourceLabel setFont:MNFont(10)];
    }
    return _sourceLabel;
}

- (UILabel *)titleLabel {
    if (nil == _titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        [_titleLabel setFont:MNFont(15)];
    }
    return _titleLabel;
}

@end
