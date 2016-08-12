//
//  ViewController.m
//  UITabView-- 练习
//
//  Created by qingyun on 16/7/2.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "ViewController.h"
#import "CustomCell.h"

@interface ViewController () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,copy) NSArray *arrDatas;

@end

@implementation ViewController

//- (NSArray *)arrDatas{
//    NSArray *arrSelect1 = @[@"卡卡西",@"鸣人",@"小樱",@"佐助"];
//    NSArray *arrSelect2 = @[@"迈特*凯",@"洛克李",@"宁次",@"天天"];
//    NSArray *arrSeltct3 = @[@"袁飞*阿斯玛",@"秋道丁次",@"鹿丸",@"山中井野"];
//    NSArray *arrSeltct4 = @[@"夕日红",@"油汝志乃",@"犬冢牙",@"日向雏田"];
//    
//    _arrDatas = @[arrSelect1,arrSelect2,arrSeltct3,arrSeltct4];
//    return _arrDatas;
//}

- (NSArray *)arrDatas{
    if (!_arrDatas) {
        NSString *kpath = [[NSBundle mainBundle] pathForResource:@"Data" ofType:@"plist"];
        _arrDatas = [NSArray arrayWithContentsOfFile:kpath];
    }
    return _arrDatas;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDefaultSetting];
}

#pragma mark 加载默认设置
- (void)loadDefaultSetting{
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
//    UITableView *tableView = [UITableView new];
//    tableView.frame = self.view.bounds;
    [self.view addSubview:tableView];
    
    tableView.rowHeight = 60; // 行高
    tableView.sectionHeaderHeight = 70; //  设置每组方法的组头及组尾高度
    tableView.sectionFooterHeight = 100;
    
    tableView.separatorColor = [UIColor purpleColor]; // 设置每行之间的分割线
    
    UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"lanTian3"]];
    image.frame = self.view.bounds;
    tableView.backgroundView = image; // 设置tableView 的背景图片 --- 后边要把cell的背景颜色清除
    
    UILabel *viewHeader = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 80)];
    viewHeader.backgroundColor = [UIColor orangeColor];
    viewHeader.text = @"火影忍者";
    viewHeader.textAlignment = NSTextAlignmentCenter ;
    tableView.tableHeaderView = viewHeader;  //  设置tableView 的表头
    
    UILabel *viewFooter = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 80)];
    viewFooter.backgroundColor = [UIColor orangeColor];
    viewFooter.text = @"🔥🔥🔥🔥🔥🔥🔥";
    viewFooter.textAlignment = NSTextAlignmentCenter ;
    tableView.tableFooterView = viewFooter; // 设置tableView 的表尾
    
    
    
    tableView.dataSource = self; // 设置资源
    tableView.delegate = self; // 设置代理
}

#pragma mark 设置section的数量
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.arrDatas.count;
}

#pragma mark 设置每个section 内的行数 -- dataSource 协议内的方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.arrDatas[section] count];
}

#pragma mark 设置每行的cell -- dataSource 协议内的方法
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CustomCell *cell = [CustomCell cellWithTableView:tableView];
    cell.textLabel.text = self.arrDatas[indexPath.section][indexPath.row];  // 每个cell的text设置
    cell.backgroundColor = [UIColor clearColor]; // 清除内个cell的背景色 否则tableView 的背景图像显示出来
    [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
//    UILabel *lab = [UILabel new];
//    lab.textColor = [UIColor redColor];
    
    cell.detailTextLabel.text = @"我是副标题";
    return cell;
}

#pragma mark  设置每组方法的组头标题 --- 由于view的优先级高 所以没显示
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSString *str = @"火影忍者";
    return str;
}

#pragma mark 设置每组方法的组头图片
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel *lable = [UILabel new];
    
    lable.textAlignment = NSTextAlignmentCenter;
    lable.backgroundColor = [UIColor yellowColor];
    lable.text = [NSString stringWithFormat:@">>>>%lu的组头<<<<<<",section];
    return lable;
}

#pragma mark  设置每组方法的组尾标题  -- 由于view的优先级高 所以没显示
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    return [NSString stringWithFormat:@"%lu",section];
}

#pragma mark 设置每组组尾的view
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UILabel *lable = [UILabel new];
    lable.textAlignment = NSTextAlignmentCenter;
    lable.backgroundColor = [UIColor greenColor];
    lable.text = [NSString stringWithFormat:@"%lu的组尾",section];
    return lable;
}

///** Section中header的高度 */
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    return 30;
//}
///** Section中footer的高度 */
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
//    return 30;
//}


#pragma mark 隐藏手机标题栏
- (BOOL)prefersStatusBarHidden{
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
