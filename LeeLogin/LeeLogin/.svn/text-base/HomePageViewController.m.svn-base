



//
//  HomePageViewController.m
//  LeeLogin
//
//  Created by 李雪虎 on 16/7/28.
//  Copyright © 2016年 Leexiaohu. All rights reserved.
//

#import "HomePageViewController.h"
#import "HomePageTableViewCell.h"//cell
#import "IndividualAccountVC.h"//个人账户
#import "PersonalInformationVC.h"//个人信息
#import "RealNameAuthenticationViewController.h" // 实名认证
#import "AroundMallVC.h"//商店
#import "MemberTeacherViewController.h"//讲师等级
#import "ASingleSparkViewController.h"//星星之火
#import "WebViewController.h"
#import "MJRefresh.h"
#import "TaskMOD.h"//任务MOD
#define Individual_Account @"/userAccount/getUserAccountByVecode" //个人账户
#define Task @"/appTask/taskList"//任务
#import "WebViewController.h"
#define CheckWorkState @"/work/checkWorkState"//判断开工/收工状态
#define EndWork @"/work/endWork"//收工
#define StartWork @"/work/startWork"//开工
@interface HomePageViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UIView *BigView;
    UITableView *tabelView;
    UILabel *nameLabel;
    UILabel *levelLabel;
    UIButton *hearButton;
    BOOL workYesOrNo;
}
@property (nonatomic,copy)NSString *pointsStr;//积分
@property (nonatomic,copy)NSString *cashStr;//现金
@property (nonatomic,copy)NSString *coinStr;//翼币
@property (nonatomic,copy)NSString *_hasBindBankCard;//
@property (nonatomic,copy)NSString *nickName;//昵称
@property (nonatomic,copy)NSString *levelname;//会员等级
@property (nonatomic,strong)NSString * isBindBankCard;//几张银行卡
@property (nonatomic,strong) NSString * hasSetTeachCode; //是否指定培养人
@property (nonatomic)BOOL isRefresh;
@property (nonatomic,strong)NSMutableArray *taskArray;//任务信息数组
@property (nonatomic,strong)NSMutableArray *idArr;
@property (nonatomic,copy)NSString *workString;
@property (nonatomic,copy) NSString * taskText; //推荐任务任务 标题
@property (nonatomic) int  level_id;
@end

@implementation HomePageViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self httpRquest];//刷新数据
    self.navigationController.navigationBarHidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self httpRquest];//请求信息
    [self taskRequest];//任务列表
    self.taskText = @"今日推荐任务";
    self.view.backgroundColor = BGCOLOR;
    
    _taskArray = [[NSMutableArray alloc]init];
    _idArr = [[NSMutableArray alloc]init];

    //首页
    [self addView];
    [self checkWorkState];//开工状态请求
    // Do any additional setup after loading the view.
    [self refreshNewData];
    [self loadMoreData];
    
}

#pragma mark == 刷新 加载 数据
-(void)refreshNewData{
    __weak typeof(self) weakSelf = self;
    MJRefreshNormalHeader * header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.isRefresh = YES;
        [weakSelf httpRquest];//请求网络
        [weakSelf loadMoreData];
    }];
    tabelView.mj_header = header;
}

#pragma mark --
-(void)loadMoreData{
    __weak typeof(self) weakSelf = self;
    
    MJRefreshAutoNormalFooter * footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.isRefresh = NO;
        [weakSelf taskRequest];
    }];
    tabelView.mj_footer = footer;
}

#pragma mark --添加视图View
-(void)addView
{
    BigView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_width, 300+SCREEN_width/4*3+20)];
    BigView.backgroundColor = BGCOLOR;
    tabelView = [[UITableView alloc]initWithFrame:CGRectMake(0, -20, SCREEN_width, SCREEN_height+20) style:UITableViewStyleGrouped];
    tabelView.backgroundColor = [UIColor clearColor];
    tabelView.tableHeaderView = BigView;
    tabelView.showsVerticalScrollIndicator = NO;//隐藏滑动条
    tabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tabelView.delegate = self;
    tabelView.dataSource = self;
    [self.view addSubview:tabelView];
    [tabelView registerClass:[HomePageTableViewCell class] forCellReuseIdentifier:@"cell"];
    [self tabelViewHearView];
    [self manyView];
    [self classificationView];
}
//个人资料视图
#pragma mark --个人资料View
-(void)tabelViewHearView
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_width, 240)];
    view.backgroundColor = [UIColor clearColor];
    [BigView addSubview:view];
    
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_width, 240)];
    imgView.image = [UIImage imageNamed:@"indexbg"];
    
    UIImageView *gardenImg = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_width/2-60, 30, 120, 120)];
    gardenImg.image = [UIImage imageNamed:@"txbk"];
    [imgView addSubview:gardenImg];
    [view addSubview:imgView];
    
    hearButton = [UIButton buttonWithType:UIButtonTypeCustom];
    hearButton.frame = CGRectMake(SCREEN_width/2-50, 40, 100, 100);
    //按钮编辑
    [hearButton.layer setMasksToBounds:YES];
    //边框宽度
    [hearButton.layer setBorderWidth:1.0];
    //边框圆角半径
    [hearButton.layer setCornerRadius:50];
    //边框颜色
    hearButton.layer.borderColor=COLOR(168, 192, 212, 1).CGColor;
    [hearButton setImageForState:UIControlStateNormal withURL:[NSURL URLWithString:[USER_D objectForKey:@"head_url"]] placeholderImage:[UIImage imageNamed:@"photo"]];
    hearButton.layer.masksToBounds = 45;
    [hearButton addTarget:self action:@selector(hearButtonClicke) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:hearButton];
    
    nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 160, SCREEN_width, 20)];
    nameLabel.textColor = COLOR(218, 227, 236, 1);
    nameLabel.text = [USER_D objectForKey:@"昵称"];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.font = [UIFont systemFontOfSize:17];
    [view addSubview:nameLabel];
    levelLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 183, SCREEN_width, 20)];
    levelLabel.textColor = COLOR(218, 227, 236, 1);
    levelLabel.text = [USER_D objectForKey:@"会员等级"];
    levelLabel.textAlignment = NSTextAlignmentCenter;
    levelLabel.font = [UIFont systemFontOfSize:15];
    [view addSubview:levelLabel];
}
#pragma mark --显示余额View
//显示余额视图
- (void)manyView
{
    NSArray *colorArray = @[COLOR(46, 128, 204, 1),COLOR(151, 38, 186, 1),COLOR(218, 25, 36, 1)];
    NSArray *titleArray = @[@"翼币",@"现金",@"积分"];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 220, SCREEN_width, 70)];
    view.backgroundColor = [UIColor whiteColor];
    [BigView addSubview:view];
    for (int i=0; i<3; i++)
    {
        UILabel *titleLabel = [[UILabel alloc]init];
        UILabel *colorlabel = [[UILabel alloc]init];
        UILabel *manyLabel  = [[UILabel alloc]init];
        manyLabel.frame = CGRectMake(SCREEN_width/3*i, 37, SCREEN_width/3, 25);
        titleLabel.frame = CGRectMake(SCREEN_width/3*i, 10, SCREEN_width/3, 25);
        if (i==0)
        {
            colorlabel.frame = CGRectMake(0, 0, SCREEN_width/3, 5);
        }else if (i==1){
            colorlabel.frame = CGRectMake(SCREEN_width/3+1, 0, SCREEN_width/3-2, 5);
        }else{
            colorlabel.frame = CGRectMake(SCREEN_width/3*2, 0, SCREEN_width/3, 5);
        }
        manyLabel.font = [UIFont systemFontOfSize:20];
        manyLabel.textAlignment = NSTextAlignmentCenter;
        //manyLabel.adjustsFontSizeToFitWidth =YES;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.textColor = COLOR(170, 170, 170, 1);
        titleLabel.text = titleArray[i];
        colorlabel.backgroundColor = colorArray[i];
        manyLabel.tag = i+50;
        manyLabel.text = @"---";
        [view addSubview:colorlabel];
        [view addSubview:titleLabel];
        [view addSubview:manyLabel];
    }
    for (int a=0; a<2; a++)
    {
        UIView *lineview = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_width/3*(a+1), 10, 1, 55)];
        lineview.backgroundColor = COLOR(234, 234, 234, 1);
        [view addSubview:lineview];
    }
    
}
//分类按钮视图
#pragma mark --分类按钮View
-(void)classificationView
{
    UIView  *view = [[UIView alloc]initWithFrame:CGRectMake(0, 305, SCREEN_width, SCREEN_width/4*3)];
    view.backgroundColor = BGCOLOR;
    [BigView addSubview:view];
    NSArray *buttonImgArray = @[@"nav_grzh",@"nav_xld",@"nav_zbsd",@"nav_tjpy",@"nav_hyjs",@"nav_smrz",@"nav_kg",@"nav_xxzh",@"nav_jssh",@"nav_yhkbd",@"nav_tjlb-1",@"nav_pysh"];
    for (int i=0; i<12; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(((SCREEN_width-3)/4+1)*(i%4), ((SCREEN_width-3)/4+1)*(i/4), (SCREEN_width-3)/4, (SCREEN_width-3)/4);
        [button setImage:[UIImage imageNamed:buttonImgArray[i]] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i+10;
        button.backgroundColor = [UIColor whiteColor];
        [view addSubview:button];
    }
    
    
}
#pragma mark --tableView 代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 50;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_width, 50)];
    view.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, SCREEN_width/4*3, 50)];
    label.text = self.taskText;
    label.tag = 635;
    [view addSubview:label];
    //标记图片
    UIImageView *redImg = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_width-47, 0, 47, 50)];
    redImg.image = [UIImage imageNamed:@"hot"];
    [view addSubview:redImg];
    //灰色线条
    UIView *colorView = [[UIView alloc]initWithFrame:CGRectMake(0, 49, SCREEN_width, 1)];
    colorView.backgroundColor = BGCOLOR;
    [view addSubview:colorView];
    return view;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"%lu",(unsigned long)_taskArray.count);
    return _taskArray.count;
    
}
//用于设定编中区的个数,默认情况是1个区
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return SCREEN_width/4+10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomePageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;//取消点击状态
    
    if (_taskArray.count>0) {
        TaskMOD *taskMod = [TaskMOD new];
        taskMod = _taskArray[indexPath.row];
        [cell.smallimgView setImageWithURL:[NSURL URLWithString:taskMod.taskIcon] placeholderImage:[UIImage imageNamed:@"asdf"]];
        cell.detailsLabel.text = taskMod.taskName;
        cell.moneyLabel.text =[NSString stringWithFormat:@"%@翼币",taskMod.taskEbMax];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"asdfasdf");
    if (_idArr.count>0) {
        WebViewController * web = [[WebViewController alloc]init];
        web.urlString = [NSString stringWithFormat:@"%@",LINK_TASK_URL(_idArr[indexPath.row])];
        [self.navigationController pushViewController:web animated:YES];
    }
}
#pragma mark -- buttonClicke(分类按钮的跳转事件)
- (void)buttonClick:(UIButton *)button
{
    
    switch (button.tag)
    {
            
            
        case 10:
        {
            IndividualAccountVC *individualAccountVC = [IndividualAccountVC new];//个人账户
            individualAccountVC.YBString = _cashStr;//翼币
            individualAccountVC.cashString = _cashStr;//现金
            individualAccountVC.totalScore = _cashStr;//积分
            [self.navigationController pushViewController:individualAccountVC animated:YES];
            break;
        }case 11:
        {
            WebViewController *vc =[ WebViewController new];//心劳动
            vc.urlString = LINK_URL(@"/task/taskList");
            NSLog(@"%@",vc.urlString);
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 12:
        {
            UIAlertController * alert = [UICommonView showOneAlertWithTitle:@"提示" message:@"该功能尚未开发" preferredStyle:UIAlertControllerStyleAlert sureTitle:@"确定" sureBlock:^{
                
            }];
            [self presentViewController:alert animated:YES completion:nil];
//            AroundMallVC * vc = [AroundMallVC new];//周边商城
//            [self.navigationController pushViewController:vc animated:YES];
            break;
        }case 13:
        {
            WebViewController * vc = [WebViewController new];//推荐培养
            vc.urlString = LINK_URL(@"/recTrain/pandect");
            vc.titleString = @"推荐培养";
            NSLog(@"%@",vc.urlString);
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
            
        case 14:
        {
            MemberTeacherViewController * vc = [MemberTeacherViewController new];//会员讲师
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
            
        case 15:
        {
            RealNameAuthenticationViewController * vc = [RealNameAuthenticationViewController new];//实名认证
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }case 16:
        {
            if (workYesOrNo==NO) {
               
                [self starWord];//开工
                [self httpRquest];//刷新信息
            }else
            {
                
                [self endWord];//收工
                [self httpRquest];//刷新信息
                
            }
        

            break;
        }
        case 17:
        {
            ASingleSparkViewController * vc = [ASingleSparkViewController new];//星星之火
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }case 18:
        {
            WebViewController * vc = [WebViewController new];//讲师审核
            vc.urlString = LINK_URL(@"/lecturer/lecturerInfo");
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }case 19:
        {
            
            
            if (_level_id >=1) {
                WebViewController * vc = [WebViewController new];//银行卡绑定
                vc.hasRightItem = YES;
                if ([self.isBindBankCard isEqualToString:@"0"]) {
                    vc.urlString = LINK_URL(@"/account/unboundBankCard");//未绑定
                }else if([self.isBindBankCard isEqualToString:@"1"]){
                    vc.urlString = LINK_URL(@"/account/boundBankCard");
                }
                vc.titleString = @"银行卡";
                [self.navigationController pushViewController:vc animated:YES];
                
            }else{
                UIAlertController * alert = [UICommonView showTwoAlertWithTitle:@"提示" message:@"您尚未实名认证" preferredStyle:UIAlertControllerStyleAlert sureTitle:@"去认证" cancelTitle:@"取消" sureBlock:^{
                    RealNameAuthenticationViewController * vc = [[RealNameAuthenticationViewController alloc]init];
                    [self.navigationController pushViewController:vc animated:YES];
                } cancelBlock:^{
                    
                }];
                [self presentViewController:alert animated:YES completion:nil];
            }
            
            

            break;
        }case 20:
        {
            WebViewController * vc = [WebViewController new];//投诉建议
            vc.hasRightItem = YES;
            vc.urlString = LINK_URL(@"/complaints/complaintsPandect");
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }case 21:
        {
            WebViewController * vc = [WebViewController new];//培养审核
            if ([self.hasSetTeachCode isEqualToString:@"1"]) {
                //已指定
                vc.urlString = LINK_URL(@"/recTrain/train");
            }else{
                vc.urlString = LINK_URL(@"/recTrain/unTrai");
            }

            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
            
        default:
            break;
    }

    
}
#pragma mark --头像按钮事件(进入个人信息)
- (void)hearButtonClicke
{
    [self.navigationController pushViewController:[PersonalInformationVC new] animated:YES];
    NSLog(@"个人信息");
}
#pragma mark --收工
-(void)endWord
{
    //收工
    __block HomePageViewController *homePageViewController = self;
    [HTTPURL postRequest:LINK_BASE_URL(EndWork) parameters:@{@"access_token":ACCESS_TOKEN} success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@",responseObject);
        NSString *str = responseObject[@"msg"];
        [homePageViewController checkWorkState];
        [homePageViewController promptViewmessage:str sureBlock:^{
            
        }];
    } filure:^(NSURLSessionDataTask *task, id error) {
        NSLog(@"%@",error);
    } showHUD:NO sucessMsg:@"" failureMsg:@""];
}
#pragma mark --开工
-(void)starWord
{
    //开工

    __weak typeof(self) weakself = self;
    [HTTPURL postRequest:LINK_BASE_URL(StartWork) parameters:@{@"access_token":ACCESS_TOKEN} success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@",responseObject);
        NSString *str = responseObject[@"msg"];
        [weakself checkWorkState];
        [weakself promptViewmessage:str sureBlock:^{
            
        }];
    } filure:^(NSURLSessionDataTask *task, id error) {
        NSLog(@"%@",error);
    } showHUD:NO sucessMsg:@"" failureMsg:@""];
}
//判断开工状态
-(void)checkWorkState
{
    UIButton *button = [self.view viewWithTag:16];
    
    _workString = [[NSString alloc]init];
    
    //开工/收工判断任务
    [HTTPURL postRequest:LINK_BASE_URL(CheckWorkState) parameters:@{@"access_token":ACCESS_TOKEN} success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@",responseObject);
        
        _workString = responseObject[@"data"];
        if ([_workString isEqualToString:@"开工"])
        {
            [button setImage:[UIImage imageNamed:@"nav_kg"] forState:UIControlStateNormal];//开工
            workYesOrNo =NO;
            
        }else{
            [button setImage:[UIImage imageNamed:@"nav_sg"] forState:UIControlStateNormal];//收工
            workYesOrNo =YES;
        }
        [tabelView reloadData];
    } filure:^(NSURLSessionDataTask *task, id error) {
        NSLog(@"%@",error);
    } showHUD:NO sucessMsg:@"" failureMsg:@""];
    
    
}
#pragma mark --网络请求(加载新的数据)
-(void)httpRquest
{

    //信息加载
    __weak HomePageViewController *homePageViewController = self;
    __weak typeof(self) weakself = self;

    [HTTPURL postRequest:LINK_BASE_URL(Individual_Account) parameters:@{@"access_token":ACCESS_TOKEN} success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@",responseObject);
        _cashStr = [responseObject[@"data"][@"cash"] stringValue];//现金
        _coinStr = [responseObject[@"data"][@"coin"] stringValue];//翼币
        _pointsStr = [responseObject[@"data"][@"points"] stringValue];//积分
        _levelname = responseObject[@"data"][@"level_name"];
        _level_id = [responseObject[@"data"][@"level_id"] intValue];
        _nickName = responseObject[@"data"][@"nick_name"];
        weakself.isBindBankCard = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"hasBindBankCard"]];
        weakself.hasSetTeachCode = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"hasSetTeachCode"]];
        
        [USER_D setObject:responseObject[@"data"][@"portrait"] forKey:@"head_url"];//照片
        [USER_D setObject:_nickName forKey:@"昵称"];//昵称
        [USER_D setObject:_levelname forKey:@"会员等级"];//会员等级
        [USER_D setObject:self.isBindBankCard forKey:[NSString stringWithFormat:@"%@hasBindBankCard",VE_CODE]];

        [homePageViewController AccordingConten];//刷新信息
        [tabelView.mj_header endRefreshing];//下拉加载停止
    } filure:^(NSURLSessionDataTask *task, id error) {
        NSLog(@"%@",error);
        [tabelView.mj_header endRefreshing];//下拉加载停止
    }showHUD:NO sucessMsg:@"" failureMsg:@""];
}
#pragma mark--任务请求
-(void)taskRequest
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    __weak typeof(self) weakself = self;
    [manager POST:LINK_BASE_URL(Task) parameters:@{@"access_token":ACCESS_TOKEN} progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         NSLog(@"%@",responseObject);
        
        if (weakself.taskArray.count>0) {
            [weakself.taskArray removeAllObjects];
            [weakself.idArr removeAllObjects];
        }
        
        NSArray * taskArr = [NSArray arrayWithArray:responseObject[@"data"]];
        if (taskArr.count==0) {
            UILabel * label = [self.view viewWithTag:635];
            label.text = @"今日暂无推荐任务";
            weakself.taskText = @"今日暂无推荐任务";
            [tabelView.mj_footer endRefreshingWithNoMoreData];

            return ;
        }
        for (NSDictionary *dic in taskArr)
        {
            TaskMOD *taskMod = [TaskMOD new];
            [taskMod setValuesForKeysWithDictionary:dic];
            [weakself.taskArray addObject:taskMod];
            NSString *str = [NSString stringWithFormat:@"%d",[dic[@"id"] intValue]];
            [weakself.idArr addObject:str];
        }
        [tabelView reloadData];//刷新列表
        
        [tabelView.mj_footer endRefreshingWithNoMoreData];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        [tabelView.mj_footer endRefreshingWithNoMoreData];
    }];

}
#pragma mark --改变翼币,现金,积分
-(void)AccordingConten
{
    nameLabel.text = self.nickName;
    levelLabel.text = self.levelname;
    UILabel *yBLabel = [self.view viewWithTag:50];
    yBLabel.text = _coinStr;//翼币
    UILabel *cashLabel = [self.view viewWithTag:51];
    cashLabel.text = _cashStr;//现金
    UILabel *integralLabel = [self.view viewWithTag:52];
    integralLabel.text = _pointsStr;//积分
    [hearButton setImageForState:UIControlStateNormal withURL:[NSURL URLWithString:[USER_D objectForKey:@"head_url"]] placeholderImage:[UIImage imageNamed:@"photo"]];
}
//提示框
-(void)promptViewmessage:(NSString *)message sureBlock:(void(^)())sureBlock
{
    UIAlertController * alert= [UICommonView showOneAlertWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert sureTitle:@"确实" sureBlock:^{
        sureBlock();
    }];
    [self presentViewController:alert animated:YES completion:nil];
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
