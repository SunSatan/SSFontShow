//
//  ViewController.m
//  SSFontShow
//
//  Created by 孙铭健 on 19/8/11.
//  Copyright © 2019年 SunSatan. All rights reserved.
//

#import "ViewController.h"
#import "SSFontShowViewController.h"

static NSString * const cellIdentifierString = @"cell";

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *fontFamilyArr;
@property (nonatomic, strong) NSMutableArray *fontArr;
@property (nonatomic, strong) UITableView *fontTableView;

@end

@implementation ViewController

#pragma mark - life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationItem.title = @"展示系统提供的所有字体";
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    [self loadData];
}

#pragma mark - 数据加载

- (void)loadData
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        for (NSString* fontFamilyNameString in self.fontFamilyArr) {
            NSLog(@"%@",fontFamilyNameString);
            NSArray *fontArray = [UIFont fontNamesForFamilyName:fontFamilyNameString];
            [self.fontArr addObject:fontArray];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"%@",self.fontArr);
            [self.fontTableView reloadData];
        });
    });
}

#pragma mark - UITableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.fontArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray* fontArr = [self.fontArr objectAtIndex:section];
    return fontArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64;
}

#pragma mark - UITableView Delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifierString];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifierString];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger sectionInteger = indexPath.section;
    NSInteger rowInteger = indexPath.row;
    
    NSString* fontNameString = [[self.fontArr objectAtIndex:sectionInteger] objectAtIndex:rowInteger];
    
    cell.textLabel.text = @"中文字体 ABCDabcd 1234567890";
    cell.textLabel.font = [UIFont fontWithName:fontNameString size:15];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self.fontFamilyArr objectAtIndex:section];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger sectionInteger = indexPath.section;
    NSInteger rowInteger = indexPath.row;
    
    NSString* fontNameString = [[self.fontArr objectAtIndex:sectionInteger] objectAtIndex:rowInteger];
    SSFontShowViewController *FontShowVC = [[SSFontShowViewController alloc]init];
    FontShowVC.fontNameString = fontNameString;
    [self.navigationController pushViewController:FontShowVC animated:YES];
}

#pragma mark - lazy getter

- (UITableView *)fontTableView
{
    if (!_fontTableView) {
        _fontTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _fontTableView.delegate   = self;
        _fontTableView.dataSource = self;
        [self.view addSubview:_fontTableView];
    }
    return _fontTableView;
}

- (NSMutableArray *)fontArr
{
    if (!_fontArr) {
        _fontArr = [NSMutableArray array];
    }
    return _fontArr;
}

- (NSArray *)fontFamilyArr
{
    if(!_fontFamilyArr) {
        _fontFamilyArr = [NSMutableArray arrayWithArray:[UIFont familyNames]];
    }
    return _fontFamilyArr;
}

@end
