
//
//  ListGoodsVC.m
//  LeeLogin
//
//  Created by 李雪虎 on 16/8/4.
//  Copyright © 2016年 Leexiaohu. All rights reserved.
//

#import "ListGoodsVC.h"
#import "ListGoodsTableViewCell.h"//
@interface ListGoodsVC ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation ListGoodsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商店列表";
    [self smallView];
    [self createUItabelView];
    // Do any additional setup after loading the view.
}
//信息头视图
-(void)smallView
{
    UIView *whiteView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_width, 80)];
    whiteView.backgroundColor = BGCOLOR;
    [self.view addSubview:whiteView];
    UILabel * mallLabel  = [LeeAllView allLabelWith:CGRectMake(10, 20, SCREEN_width/3, 20) withTextColor:[UIColor blackColor]];
    mallLabel.text = self.mallString;
    [whiteView addSubview:mallLabel];
    UILabel *storeLabel = [LeeAllView allLabelWith:CGRectMake(10, 50, SCREEN_width/3, 20) withTextColor:COLOR(146, 147, 148, 1)];
    storeLabel.font = [UIFont systemFontOfSize:18];
    storeLabel.text = self.storeString;
    [whiteView addSubview:storeLabel];
    UILabel *phoneLabel = [LeeAllView allLabelWith:CGRectMake(SCREEN_width-170, 30, 160, 20) withTextColor:COLOR(101, 162, 218, 1)];
    phoneLabel.text = self.phoneString;
    [whiteView addSubview:phoneLabel];
    UIImageView *phomeImg = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_width-200, 25, 30, 30)];
    phomeImg.backgroundColor = [UIColor redColor];
    [whiteView addSubview:phomeImg];
    
}
#pragma mark--表格以及表格的代理方法
//创建表
-(void)createUItabelView
{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 144, SCREEN_width, SCREEN_height) style:UITableViewStyleGrouped ];
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.delegate =self;
    tableView.dataSource = self;
    tableView.bounces = YES;
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:tableView];
    
    [tableView registerClass:[ListGoodsTableViewCell class] forCellReuseIdentifier:@"cell"];
}
//返回区头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_width, 30)];
    UILabel *hotGoodsLable = [[UILabel alloc]initWithFrame:CGRectMake(10, 15, 100, 20)];
    hotGoodsLable.text = @"热销产品";
    [view addSubview:hotGoodsLable];
    //标记图片
    UIImageView *redImg = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_width-47, 0, 47, 50)];
    redImg.image = [UIImage imageNamed:@"hto"];
    [view addSubview:redImg];
    return view;
}
//返回行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return 2;
}
//返回内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ListGoodsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.nameLabel.text = @"手表";
    cell.priceLabel.text = @"¥10000";
    cell.selectionStyle=UITableViewCellSelectionStyleNone;//取消点击状态
    
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
