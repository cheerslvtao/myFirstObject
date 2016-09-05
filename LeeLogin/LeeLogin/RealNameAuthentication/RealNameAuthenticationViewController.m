//
//  RealNameAuthenticationViewController.m
//  ShiMingRenZheng
//
//  Created by 吕涛 on 16/8/1.
//  Copyright © 2016年 吕涛. All rights reserved.
//

#import "RealNameAuthenticationViewController.h"
#import "FillInformationViewController.h"
#import "AuthenticationCell.h"
#import "MyAuthenticatioinCell.h"
#import "CheckViewController.h"
#import "MineInfomation.h"
#import "RealNameCheckModel.h"
#import "MJRefresh.h"
static NSString * const LTAuthenticationNone = @"AuthenticationNone";         //未审核
static NSString * const LTAuthenticationing = @"Authenticationing";           //审核中
static NSString * const LTAuthenticationPassed = @"AuthenticationPassed";     //审核通过
static NSString * const LTAuthenticationUnpassed = @"AuthenticationUnpassed"; //审核被驳回

#define AUTHENTICATION_STATUS LINK_BASE_URL(@"/userAccount/getUserAuth") //读取用户实名认证状态

#define AUTHENTICATION_LIST_NONEAURH LINK_BASE_URL(@"/userAccount/authUserIdCard") //读取自己需要审核的实名认证列表

@interface RealNameAuthenticationViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSString * status;                //认证状态
    NSString * statusString ;
    
    NSArray * _titleArr;              //标题
    NSArray * _passedContentArr;      //已认证  测试数据
    NSArray * _unPassedContentArr;    //未通过  测试数据
    NSArray * _submited;              //已提交  测试数据

    UIColor * _statusColor;           //认证状态颜色
    UIButton * _authenticationButton; //认证按钮
    NSInteger  _sectionNumber;        //返回多少区
    CGFloat _heightTable;             //tableview 的高
    
    
    
}
@property (nonatomic,strong) UITableView * authenticationTableView;

@property (nonatomic,strong) NSMutableArray * noneAuthenticationArr;

@property (nonatomic,strong) MineInfomation * mine; //个人信息model

@property (nonatomic) int pages;

@property (nonatomic) int totalPage;

@property (nonatomic) BOOL isRefresh;

@end

@implementation RealNameAuthenticationViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //设置返回按钮
    NvigationItemSingle * single = BACK_NAVIGATION;
    [single setNavigationBackItem:self];
    
    //认证审核返回后刷新列表
    if (status == LTAuthenticationPassed) {
        self.isRefresh = YES;
        self.pages = 0;
        [self getAuthenticationInfo];
    }

    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

-(void)dealloc{
    //移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets =NO;
    self.view.backgroundColor = BGCOLOR;
    self.title = @"实名认证";

    _sectionNumber = 1;
    //实名认证状态获取请求
    [self getStatus];   
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(statusChanged:) name:@"statusChanged" object:nil];

}

#pragma mark == 刷新 加载 数据
-(void)refreshNewData{
    __weak typeof(self) weakSelf = self;
    MJRefreshNormalHeader * header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.isRefresh = YES;
        weakSelf.pages = 0;
        [weakSelf getAuthenticationInfo];
    }];
    self.authenticationTableView.mj_header = header;
}

-(void)loadMoreData{
    __weak typeof(self) weakSelf = self;
    MJRefreshAutoNormalFooter * footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.isRefresh = NO;
        if (weakSelf.pages+1<self.totalPage) {
            weakSelf.pages++;
            [weakSelf getAuthenticationInfo];
        }else{
            [weakSelf.authenticationTableView.mj_footer endRefreshingWithNoMoreData];
        }
        
    }];
    self.authenticationTableView.mj_footer = footer;
}


#pragma mark == 收到认证状态 改变通知
-(void)statusChanged:(NSNotification *)noti{
    
    [self getStatus];
    
}


#pragma mark == 实名认证状态
-(void)getStatus{ //获取状态
    
    [HTTPURL postRequest:AUTHENTICATION_STATUS parameters:@{@"access_token":ACCESS_TOKEN} success:^(NSURLSessionDataTask *task, id responseObject) {
        //获取到认证状态
        NSLog(@"认证状态---%@",responseObject);
        NSDictionary * mineDic = responseObject[@"data"][@"idcard"];
        if (mineDic) {
            self.mine = [[MineInfomation alloc]init];
            [self.mine setValuesForKeysWithDictionary:mineDic];
        }
        
        int statusNum = [responseObject[@"data"][@"userdata"][@"authStatus"] intValue];
        NSLog(@"%d",statusNum);
        [self decideAuth:statusNum];
        
    } filure:^(NSURLSessionDataTask *task, id error) {
        NSLog(@"error -->  %@",error);
    } showHUD:YES sucessMsg:@"获取成功" failureMsg:@"获取失败"];
    
}

-(void)decideAuth:(int ) statusNum{
    switch (statusNum) {
        case 0:
        {
            status = LTAuthenticationNone;
            [self AuthenticationNone];
            
        }
            break;
        case 1:
        {
            status = LTAuthenticationing;
             statusString = @"已提交";
            [self createTableView];
           
        }
            break;
        case 2:
        {
             status = LTAuthenticationPassed;
            statusString = @"已认证";
            [self createTableView];
            self.noneAuthenticationArr = [[NSMutableArray alloc]init];
            [self getAuthenticationInfo];
            [self refreshNewData];
            [self loadMoreData];

        }
            break;
        case 3:
        {
            status = LTAuthenticationUnpassed;
            statusString = @"认证未通过";
            [self createTableView];
            
        }
            break;
        default:
            break;
    }

}



-(void)createTableView{

    _titleArr = [[NSArray alloc]initWithObjects:@"当前状态",@"姓名",@"身份证号",@"拒绝理由", nil];
    
    if ([status isEqualToString:LTAuthenticationUnpassed]) { //认证未通过

        _statusColor = [UIColor redColor];

    }else if([status isEqualToString:LTAuthenticationPassed]){ //已认证

        _statusColor = [UIColor greenColor];
        
        if (_heightTable>=SCREEN_height-64) {
            _heightTable = SCREEN_height-64;
        }
        
    }else if ([status isEqualToString:LTAuthenticationing]){ //已提交
        _statusColor = COLOR(62, 94, 149, 1);

    }
    
    if (!_authenticationTableView) {
        [self.view addSubview:self.authenticationTableView];
    }else{
        [self.authenticationTableView reloadData];
    }
    
}

// 获取  审核列表
-(void)getAuthenticationInfo{
    
    __weak typeof(self) weakself = self;
    [HTTPURL postRequest:LINK_BASE_URL(@"/userAccount/getAuthList") parameters:@{@"pages":[NSString stringWithFormat:@"%d",self.pages],@"access_token":ACCESS_TOKEN} success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if (self.isRefresh) {
            [self.noneAuthenticationArr removeAllObjects];
        }

        NSLog(@"实名认证审核列表-----%@",responseObject);
        NSDictionary * dic = responseObject[@"data"];
        
        self.totalPage = [dic[@"totalPages"] intValue];
        NSArray * array = dic[@"datas"];
        
        if (array.count > 0) {
            _sectionNumber = 2;
            for (NSDictionary * dic  in array) {
                RealNameCheckModel * model = [[RealNameCheckModel alloc]init];
                [model setValuesForKeysWithDictionary:dic];
                [self.noneAuthenticationArr addObject:model];
            }
            _heightTable += 80*self.noneAuthenticationArr.count+44;
        }
        
        [weakself.authenticationTableView.mj_header endRefreshing];
        [weakself.authenticationTableView.mj_footer endRefreshing];
        [weakself.authenticationTableView reloadData];
    } filure:^(NSURLSessionDataTask *task, id error) {
        
        NSLog(@"实名认证审核列表异常----%@",error);
        [weakself.authenticationTableView.mj_header endRefreshing];
        [weakself.authenticationTableView.mj_footer endRefreshing];
        
    } showHUD:NO sucessMsg:@"" failureMsg:@""];
}

#pragma mark = =  未审核界面
-(void)AuthenticationNone{
    UIImageView * flagImgV = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_width/2-104*0.4, 85, 104*0.8, 90*0.8)];
    flagImgV.image = [UIImage imageNamed:@"icon_ts"];
    [self.view addSubview:flagImgV];
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 175, SCREEN_width, 30)];
    label.text = @"您尚未实名认证";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:20];
    label.textColor = [UIColor grayColor];
    [self.view addSubview:label];
    
    UIButton * btn = [LeeAllView BigButton:CGRectMake(10, 260, SCREEN_width-20, 40) withTitel:@"立即认证"];
    [btn addTarget:self action:@selector(goAuthentication) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

-(void)goAuthentication{
    FillInformationViewController * vc = [FillInformationViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark == 已提交/未通过tableView
-(UITableView *)authenticationTableView{
    if (!_authenticationTableView) {
        _authenticationTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_width, SCREEN_height-64) style:UITableViewStylePlain];
        _authenticationTableView.delegate = self;
        _authenticationTableView.dataSource = self;
        _authenticationTableView.showsVerticalScrollIndicator = NO;
        _authenticationTableView.estimatedRowHeight = 50;
        _authenticationTableView.rowHeight = UITableViewAutomaticDimension;
        _authenticationTableView.separatorInset = UIEdgeInsetsZero;
        _authenticationTableView.backgroundColor = BGCOLOR;
        [_authenticationTableView registerNib:[UINib nibWithNibName:@"AuthenticationCell" bundle:nil] forCellReuseIdentifier:@"AuthenticationCell"];
        [_authenticationTableView registerNib:[UINib nibWithNibName:@"MyAuthenticatioinCell" bundle:nil] forCellReuseIdentifier:@"MyAuthenticatioinCell"];
    }
    return _authenticationTableView;
}

//区数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _sectionNumber;
}
//行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
//        self.authenticationTableView.frame = CGRectMake(0, 64, SCREEN_width, _heightTable); //重置tableView的frame
        if (status == LTAuthenticationUnpassed) {
            return _titleArr.count;
        }else{
            return _titleArr.count-1;
            
        }
    }

    return self.noneAuthenticationArr.count;
}
//行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return UITableViewAutomaticDimension;
    }
    return 80;
}
//区头
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if ([status isEqualToString:LTAuthenticationPassed]) {
        return 20;
    }
    return 44;
}
//区头
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel * label = nil;
    if ([status isEqualToString:LTAuthenticationUnpassed]||[status isEqualToString:LTAuthenticationing]) {
        label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_width, 44)];
        label.text = @"认证信息";
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont boldSystemFontOfSize:15];
    }
    if (section == 0) {
        return label;
    }
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if ([status isEqualToString:LTAuthenticationUnpassed]) {
         return 60;
    }
    return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if ([status isEqualToString:LTAuthenticationUnpassed]) {
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_width, 60)];
        _authenticationButton = [LeeAllView BigButton:CGRectMake(10, 10, SCREEN_width-20, 40) withTitel:@"重新认证"];
        [_authenticationButton addTarget:self action:@selector(goAuthentication) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_authenticationButton];
        [view addSubview:_authenticationButton];
        return view;
    }
    return nil;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        AuthenticationCell * cell = [tableView dequeueReusableCellWithIdentifier:@"AuthenticationCell" forIndexPath:indexPath];
        cell.titleLabel.text = _titleArr[indexPath.row];
        if (indexPath.row == 0) {
            cell.contentLabel.textColor = _statusColor;
            cell.contentLabel.text = statusString;
            
        }else if(indexPath.row==1){
            cell.contentLabel.text = self.mine.real_name;
        }else if (indexPath.row==2){
            cell.contentLabel.text = [NSString stringWithFormat:@"%@",self.mine.idCard];
        }else{
            cell.contentLabel.text = self.mine.auth_reason;
        }
        return cell;
    }
    MyAuthenticatioinCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MyAuthenticatioinCell" forIndexPath:indexPath];
    if (self.noneAuthenticationArr.count>0) {
        cell.model = self.noneAuthenticationArr[indexPath.row];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.section == 1) {
        CheckViewController * vc = [CheckViewController new];
        if (self.noneAuthenticationArr.count > 0) {
            vc.model = self.noneAuthenticationArr[indexPath.row];
        }
        [self.navigationController pushViewController:vc animated:YES];
    }
}



@end
