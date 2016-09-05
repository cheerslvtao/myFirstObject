

//
//  IndividualAccountVC.m
//  LeeLogin
//
//  Created by 李雪虎 on 16/8/1.
//  Copyright © 2016年 Leexiaohu. All rights reserved.
//

#import "IndividualAccountVC.h"
#import "IndividualAccountCell.h"
#import "PersonalInformationVC.h"//个人账户
#import "MJRefresh.h"
#import "WebViewController.h"
#import "RealNameAuthenticationViewController.h" //实名认证
#define GetUserAccountByVecode @"/userAccount/getUserAccountByVecode"//个人账户总览网址
#define ReceiveInstallationAward @"/taskUserDownloadDetail/receiveInstallationAward"//领取下载任务奖励
@interface IndividualAccountVC ()<UITableViewDelegate,UITableViewDataSource>
{
    UIView *BigView;
    NSArray *_titelArray;
    NSArray *_twoTitelArray;
    NSArray *_twoImgArry;
    UITableView *tabelView;
    
}
@property (nonatomic,strong)NSArray *titerImgArry;//图片数组
@property (nonatomic,copy)NSString *pointsStr;//积分
@property (nonatomic,copy)NSString *cashStr;//现金
@property (nonatomic,copy)NSString *coinStr;//翼币
@property (nonatomic) int level_id; //会员等级
@property (nonatomic,strong) NSString * hasSetPayPwd; //是否设置了支付密码

@property (nonatomic,strong) NSArray * urlArr;
@end

@implementation IndividualAccountVC

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self starRequest];//获取信息
    self.navigationController.navigationBarHidden = YES;
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //个人账户
    _titelArray = @[@"翼币",@"现金",@"积分",@"银行卡",];
    _titerImgArry = @[@"user_yb",@"user_xj",@"user_jf",@"user_yhk"];
    _twoTitelArray = @[@"支付密码",@"领取奖励"];
    _twoImgArry = @[@"user_mm",@"user_jiangli"];
    [self addView];
    
    
}


-(void)addView{
    BigView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_width, 270+20)];
    BigView.backgroundColor = BGCOLOR;
    tabelView = [[UITableView alloc]initWithFrame:CGRectMake(0, -20, SCREEN_width, SCREEN_height+20) style:UITableViewStyleGrouped];
    tabelView.tableHeaderView = BigView;
    tabelView.showsVerticalScrollIndicator = NO;//隐藏滑动条
    // tabelView.separatorStyle = UITableViewCellFocusStyleCustom;
    // tabelView.separatorInset = UIEdgeInsetsZero;
    tabelView.delegate = self;
    tabelView.dataSource = self;
    [tabelView setLayoutMargins:UIEdgeInsetsZero];
    [self.view addSubview:tabelView];
    [tabelView registerClass:[IndividualAccountCell class] forCellReuseIdentifier:@"cell"];
    __weak typeof(self) weakSelf = self;
    MJRefreshNormalHeader * header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf starRequest];
    }];
    tabelView.mj_header = header;
    [self tabelViewHearView];
    [self manyView];
    
}

//个人资料视图
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
    UIButton * hearButton = [UIButton buttonWithType:UIButtonTypeCustom];
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
    UILabel * nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 160, SCREEN_width, 20)];
    nameLabel.textColor = COLOR(218, 227, 236, 1);
    nameLabel.text = [USER_D objectForKey:@"昵称"];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.font = [UIFont systemFontOfSize:17];
    [view addSubview:nameLabel];
    UILabel * levelLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 183, SCREEN_width, 20)];
    levelLabel.textColor = COLOR(218, 227, 236, 1);
    levelLabel.text = [USER_D objectForKey:@"会员等级"];
    levelLabel.textAlignment = NSTextAlignmentCenter;
    levelLabel.font = [UIFont systemFontOfSize:15];
    [view addSubview:levelLabel];
    //返回按钮
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(15, 15, 20, 40) ;
    [backButton setImage:[UIImage imageNamed:@"head_arrow"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:backButton];
    
}
///显示余额视图
- (void)manyView
{
    NSArray *colorArray = @[COLOR(46, 128, 204, 1),COLOR(151, 38, 186, 1),COLOR(218, 25, 36, 1)];
    NSArray *titleArray = @[@"翼币",@"现金",@"积分"];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 220, SCREEN_width, 70)];
    view.backgroundColor = [UIColor whiteColor];
    [BigView addSubview:view];
    for (int i=0; i<3; i++){
        UILabel *titleLabel = [[UILabel alloc]init];
        UILabel *colorlabel = [[UILabel alloc]init];
        UILabel *manyLabel  = [[UILabel alloc]init];
        manyLabel.frame = CGRectMake(SCREEN_width/3*i, 37, SCREEN_width/3, 25);
        titleLabel.frame = CGRectMake(SCREEN_width/3*i, 10, SCREEN_width/3, 25);
        if (i==0){
            colorlabel.frame = CGRectMake(0, 0, SCREEN_width/3, 5);
        }else if (i==1){
            colorlabel.frame = CGRectMake(SCREEN_width/3+1, 0, SCREEN_width/3-2, 5);
        }else{
            colorlabel.frame = CGRectMake(SCREEN_width/3*2, 0, SCREEN_width/3, 5);
        }
        
        manyLabel.font = [UIFont systemFontOfSize:20];
        manyLabel.textAlignment = NSTextAlignmentCenter;
        manyLabel.tag = i+50;
        manyLabel.text = @"---";
        manyLabel.adjustsFontSizeToFitWidth =YES;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.textColor = COLOR(170, 170, 170, 1);
        titleLabel.text = titleArray[i];
        colorlabel.backgroundColor = colorArray[i];
        [view addSubview:colorlabel];
        [view addSubview:titleLabel];
        [view addSubview:manyLabel];
    }
    for (int a=0; a<2; a++){
        UIView *lineview = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_width/3*(a+1), 10, 1, 55)];
        lineview.backgroundColor = COLOR(234, 234, 234, 1);
        [view addSubview:lineview];
    }
    
}
#pragma mark -- 表代理方法
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 15;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 4;
    }else{
        return 2;
    }
}
//用于设定编中区的个数,默认情况是1个区
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    IndividualAccountCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    [cell setSeparatorInset:UIEdgeInsetsZero];
    if (indexPath.section == 0){
        cell.titleLabel.text = _titelArray[indexPath.row];
        cell.titelImg.image = [UIImage imageNamed:_titerImgArry[indexPath.row]];
        cell.tag = indexPath.row +10;
    }else{
        cell.titleLabel.text = _twoTitelArray[indexPath.row];
        cell.tag = indexPath.row+20;
        cell.titelImg.image = [UIImage imageNamed:_twoImgArry[indexPath.row]];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;//取消点击状态
    return cell;
}
//点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        
        if (indexPath.row==3) {
            if (_level_id >=1) {
                WebViewController *vc = [WebViewController new];
                vc.urlString =self.urlArr[indexPath.row];
                vc.hasRightItem = YES;
                [self.navigationController pushViewController:vc animated:YES];

            }else{
                UIAlertController * alert = [UICommonView showTwoAlertWithTitle:@"提示" message:@"您尚未实名认证" preferredStyle:UIAlertControllerStyleAlert sureTitle:@"去认证" cancelTitle:@"取消" sureBlock:^{
                    RealNameAuthenticationViewController * vc = [[RealNameAuthenticationViewController alloc]init];
                    [self.navigationController pushViewController:vc animated:YES];
                } cancelBlock:^{
                    
                }];
                [self presentViewController:alert animated:YES completion:nil];
            }

        }else{
            WebViewController *vc = [WebViewController new];
            vc.urlString =self.urlArr[indexPath.row];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }else{
        if (indexPath.row==0) {
            if (_level_id >=1) {
                WebViewController *vc = [WebViewController new];
                if ([self.hasSetPayPwd isEqualToString:@"0"]) {
                    vc.urlString = LINK_URL(@"/account/setPayPassword");
                }else{
                    vc.urlString = LINK_URL(@"/account/changePayPassword");
                }
                
                [self.navigationController pushViewController:vc animated:YES];
            }else{
                UIAlertController * alert = [UICommonView showTwoAlertWithTitle:@"提示" message:@"您尚未实名认证" preferredStyle:UIAlertControllerStyleAlert sureTitle:@"去认证" cancelTitle:@"取消" sureBlock:^{
                    RealNameAuthenticationViewController * vc = [[RealNameAuthenticationViewController alloc]init];
                    [self.navigationController pushViewController:vc animated:YES];
                } cancelBlock:^{
                }];
                [self presentViewController:alert animated:YES completion:nil];
            }
        }else{
            //提示
            [self receiveInstallationAward];//领取请求
            //领取奖励翼币
        }
    }
}
#pragma mark -- buttonClicke
- (void)backButtonClick{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)buttonClick{
    NSLog(@"按钮被点击");
}
- (void)hearButtonClicke{
    [self.navigationController pushViewController:[PersonalInformationVC new] animated:YES];
    NSLog(@"个人信息");
}
#pragma mark --获取个人信息
-(void)starRequest{
    //发送请求
    __weak  typeof(self) individualAccountVC = self;
    [HTTPURL postRequest:LINK_BASE_URL(GetUserAccountByVecode) parameters:@{@"access_token":ACCESS_TOKEN} success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@",responseObject);
        _cashStr = [responseObject[@"data"][@"cash"] stringValue];//现金
        _coinStr = [responseObject[@"data"][@"coin"] stringValue];//翼币
        _pointsStr = [responseObject[@"data"][@"points"] stringValue];//积分
        _level_id = [responseObject[@"data"][@"level_id"] intValue];
        self.hasSetPayPwd = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"hasSetPayPwd"]] ;//绑定银行卡的个数
        [individualAccountVC AccordingConten];//更新数据
        [tabelView.mj_header endRefreshing];
    } filure:^(NSURLSessionDataTask *task, id error) {
        [tabelView.mj_header endRefreshing];
    } showHUD:NO sucessMsg:@"加载成功" failureMsg:@"网络连接失败"];
}
#pragma mark --领取下载任务请求
-(void)receiveInstallationAward
{
    NSString *uuid = [USER_D objectForKey:@"idfv"];
    __weak IndividualAccountVC *individualAccountVC = self;
    [HTTPURL postRequest:LINK_BASE_URL(ReceiveInstallationAward) parameters:@{@"access_token":ACCESS_TOKEN,@"appNumber":@"1",@"deviceId":uuid} success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@",responseObject);
        NSString *str = responseObject[@"msg"];
        [individualAccountVC promptViewmessage:str sureBlock:^{
            
        }];
    } filure:^(NSURLSessionDataTask *task, id error) {
    } showHUD:NO sucessMsg:@"" failureMsg:@""];
}
//提示框
-(void)promptViewmessage:(NSString *)message sureBlock:(void(^)())sureBlock{
    UIAlertController * alert= [UICommonView showOneAlertWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert sureTitle:@"确实" sureBlock:^{
        sureBlock();
    }];
    [self presentViewController:alert animated:YES completion:nil];
}
//更新数据
-(void)AccordingConten{
    UILabel *yBLabel = [self.view viewWithTag:50];
    yBLabel.text = _coinStr;//翼币
    UILabel *cashLabel = [self.view viewWithTag:51];
    cashLabel.text = _cashStr;//现金
    UILabel *integralLabel = [self.view viewWithTag:52];
    integralLabel.text = _pointsStr;//积分
}
-(NSArray * )urlArr{
    if (!_urlArr) {
        NSString * urlstring = [NSString string];
        if ([[USER_D objectForKey:[NSString stringWithFormat:@"%@hasBindBankCard",VE_CODE]] isEqualToString:@"1"]) {
            urlstring = LINK_URL(@"/account/boundBankCard");
        }else{
            urlstring = LINK_URL(@"/account/unboundBankCard");
        }
        _urlArr = [[NSArray alloc]initWithObjects:LINK_URL(@"/account/yiMoney"),LINK_URL(@"/account/cash"),LINK_URL(@"/account/score"),urlstring, nil];
    }
    return _urlArr;
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
