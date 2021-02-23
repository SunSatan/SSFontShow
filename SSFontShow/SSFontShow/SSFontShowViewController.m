//
//  SSFontShowViewController.m
//  SSFontShow
//
//  Created by 孙铭健 on 19/8/11.
//  Copyright © 2019年 SunSatan. All rights reserved.
//

#import "SSFontShowViewController.h"

@interface SSFontShowViewController () <UITextFieldDelegate>

@property (nonatomic, strong) UILabel *showFontLabel;

@end

@implementation SSFontShowViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

- (void)setFontNameString:(NSString *)fontNameString
{
    _fontNameString = fontNameString;
    self.navigationItem.title = fontNameString;
//    self.textField.text = fontNameString;
    self.showFontLabel.font = [UIFont fontWithName:fontNameString size:16];
}

-(UILabel *)showFontLabel
{
    if (!_showFontLabel) {
        _showFontLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 40, self.view.bounds.size.width, self.view.bounds.size.height - 40)];
        _showFontLabel.numberOfLines = 0;
        _showFontLabel.textAlignment = NSTextAlignmentCenter;
        _showFontLabel.text = @"1234567890 \n\n ABCDEFGHIJKLM \n NOPQRSTUVWXYZ \n abcdefghijklm \n nopqrstuvwxyz \n\n ~!@#$%^&*()_=-+"" \n {}|:?<>[];'',./\\ \n\n 汉体书写信息技术标准相容 \n 档案下载使用界面简单 \n 支援服务升级资讯专业制作 \n 创意空间快速无线上网 \n\n ～！@#￥%……&*（）——+｛｝| \n ：“”《》？-=【】、；‘’，。、";
        [self.view addSubview:_showFontLabel];
    }
    return _showFontLabel;
}


@end
