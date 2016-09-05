//
//  ASingleSparkViewController.m
//  ShiMingRenZheng
//
//  Created by 吕涛 on 16/8/4.
//  Copyright © 2016年 吕涛. All rights reserved.
//

#import "ASingleSparkViewController.h"
#import "MeetCell.h"
#import "SubmitMeetContentViewController.h"
#import "MeetListViewController.h"
#import "ShowMeetInfoViewController.h"
#import "MJRefresh.h"
#import "SubmitedMeetList.h"

#define MEET_SUBMITED_LIST [NSString stringWithFormat:@"%@/userMeeting/userMeeting?pages=%@&access_token=%@",BASE_URL,[NSString stringWithFormat:@"%d",self.pages],ACCESS_TOKEN] //星星之火 ———— 已提交会议列表

#define MEET_LIST LINK_BASE_URL(@"/userMeeting/userMeeting") //星星之火 ———— 已提交会议列表
#define LECTURER_LEVEL LINK_BASE_URL(@"/userTeach/findTeachLevel") //获取讲师级别

@interface ASingleSparkViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView * SparkTableView;

@property(nonatomic,strong) NSMutableArray * SubmitedMeetListArr; //数据

@property (nonatomic) int pages; //当前页数

@property (nonatomic) int totalPage; //总页数

@property (nonatomic)BOOL isRefresh;

@end

@implementation ASingleSparkViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //设置返回按钮
    NvigationItemSingle * single = BACK_NAVIGATION;
    [single setNavigationBackItem:self];
    
    self.isRefresh = YES;
    [self getMeetList];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets =NO;
    self.view.backgroundColor = BGCOLOR;
    self.title = @"星星之火";
    self.SubmitedMeetListArr = [[NSMutableArray alloc]init];
    [self.view addSubview:self.SparkTableView];
    
    [self getMeetList];

    [self refreshNewData];
    [self loadMoreData];
    
}

#pragma mark == 刷新数据
-(void)refreshNewData{
    __weak typeof(self) weakSelf = self;
    MJRefreshNormalHeader * header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.isRefresh = YES;
        [weakSelf getMeetList];
    }];
    self.SparkTableView.mj_header = header;
}

#pragma mark = = 加载 数据
-(void)loadMoreData{
    __weak typeof(self) weakSelf = self;
    MJRefreshAutoNormalFooter * footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.isRefresh = NO;
        if (self.pages+1<self.totalPage) {
            self.pages++;
            [self getMeetList];
        }else{
            [self.SparkTableView.mj_footer endRefreshingWithNoMoreData];
        }
        
    }];
    self.SparkTableView.mj_footer = footer;
}

#pragma mark == 获取已提交会议列表
-(void)getMeetList{
    
    __weak typeof(self)weakself = self;
    
    
    [HTTPURL postRequest:MEET_SUBMITED_LIST parameters:nil  success:^(NSURLSessionDataTask *task, id responseObject) {
        //获取到 会议列表 放入到数组中 dataArr;
        if (self.isRefresh) {
            [self.SubmitedMeetListArr removeAllObjects];
        }

        NSLog(@"已提交会议列表 --- %@",responseObject);
        NSDictionary * dataDic = responseObject[@"data"];
        NSDictionary * pagedataDiv = dataDic[@"pagedata"];
        
        NSArray * contentArr = pagedataDiv[@"content"];
        self.totalPage = [pagedataDiv[@"totalPages"] intValue];
        
        for (int i=0; i<contentArr.count; i++) {
            SubmitedMeetList * model = [[SubmitedMeetList alloc]init];
            NSDictionary * subdic = contentArr[i];
            [model setValuesForKeysWithDictionary:subdic];
            [weakself.SubmitedMeetListArr addObject:model];
        }
        
        [weakself.SparkTableView reloadData];
        [weakself.SparkTableView.mj_header endRefreshing];
        [weakself.SparkTableView.mj_footer endRefreshing];
    } filure:^(NSURLSessionDataTask *task, id error) {
        NSLog(@"已提交会议列表 异常  error == %@",error);
        [weakself.SparkTableView.mj_header endRefreshing];
        [weakself.SparkTableView.mj_footer endRefreshing];

    } showHUD:NO sucessMsg:@"" failureMsg:@""];
}

#pragma mark == 初始化tableView
-(UITableView *)SparkTableView{
    if (!_SparkTableView) {
        _SparkTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_width, SCREEN_height-64) style:UITableViewStylePlain];
        _SparkTableView.delegate =self;
        _SparkTableView.dataSource = self;
        _SparkTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _SparkTableView.separatorInset = UIEdgeInsetsMake(0,0,0,0);
        _SparkTableView.backgroundColor = [UIColor clearColor];
        _SparkTableView.tableHeaderView = [self customHeaderView]; // 表头
        [_SparkTableView registerNib:[UINib nibWithNibName:@"MeetCell" bundle:nil] forCellReuseIdentifier:@"MeetCell"];
    }
    return _SparkTableView;
}
//自定义表头
-(UIView *)customHeaderView
{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_width, 120 )];
    view.backgroundColor = [UIColor whiteColor];
    
    UILabel * lvLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_width, 60)];
    lvLabel.font = [UIFont boldSystemFontOfSize:15];
    lvLabel.textAlignment = NSTextAlignmentCenter;
    lvLabel.backgroundColor = BGCOLOR;

    [self getTeachLevel:lvLabel];
    [view addSubview:lvLabel];
    
    UILabel * titlelabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 60, SCREEN_width/3+5, 59)];

    titlelabel.text = @" 已提交会议列表";
    titlelabel.font = [UIFont systemFontOfSize:15];
    titlelabel.textColor = COLOR(107,177, 234, 1);
    [view addSubview:titlelabel];

    
    NSArray * arr = @[@"会议审核",@"会议提交"];
    for (int i = 0 ; i<2; i++) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(SCREEN_width - (SCREEN_width/3-25+10)*(i+1), 75, SCREEN_width/3-25, 30);
        btn.layer.borderWidth = 1;
        btn.layer.cornerRadius = 15;
        btn.layer.borderColor =COLOR(107,177, 234, 1).CGColor;
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        [btn setTitleColor:COLOR(107,177, 234, 1) forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 6742+i;
        [view addSubview:btn];
    }
    
    UIView * lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 119, SCREEN_width, 1)];
    lineView.backgroundColor =COLOR(107,177, 234, 1);
    [view addSubview:lineView];
    
    return view;
}

#pragma mark == 获取讲师等级
-(void)getTeachLevel:(UILabel *)lvLabel{
    
    [HTTPURL postRequest:LECTURER_LEVEL parameters:@{@"access_token":ACCESS_TOKEN} success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"讲师等级===%@",responseObject);
        [USER_D setObject:responseObject[@"code"] forKey:[NSString stringWithFormat:@"%@isLecturer",VE_CODE]];
        
        if ([responseObject[@"code"] intValue]== 002) {
            
            [USER_D setObject:responseObject[@"msg"] forKey:[NSString stringWithFormat:@"%@speak_level_name",VE_CODE]];

        }else{
            NSString * level = responseObject[@"data"][@"speak_level_name"];
            [USER_D setObject:level forKey:[NSString stringWithFormat:@"%@speak_level_name",VE_CODE]];
        }
        
        [self setTextForTeacherLevel:lvLabel];
    } filure:^(NSURLSessionDataTask *task, id error) {
        NSLog(@"error -- %@",error);
        
        [self setTextForTeacherLevel:lvLabel];
    }showHUD:NO sucessMsg:@"" failureMsg:@""];
}

#pragma mark == 给讲师等级赋值
-(void)setTextForTeacherLevel:(UILabel *)lvLabel{
    NSString * level = [USER_D objectForKey:[NSString stringWithFormat:@"%@speak_level_name",VE_CODE]];
    if (!level){
        level = @" ";
    }
    NSString * text = [NSString stringWithFormat:@"%@ [%@]",VE_CODE,level];
    
    //添加副文本
    NSRange range = [text rangeOfString:@" "];
    NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc]initWithString:text];
    [attStr addAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor],NSFontAttributeName:[UIFont systemFontOfSize:15]} range:NSMakeRange(range.location+1,[text length]-range.location-1 )];
    
    lvLabel.attributedText = attStr;

}

#pragma mark == btn 点击事件   &&  页面跳转
-(void)clickButton:(UIButton *)btn{
    id isLecturer = [USER_D objectForKey:[NSString stringWithFormat:@"%@isLecturer",VE_CODE]];
    NSString * Lecturer = [NSString stringWithFormat:@"%@",isLecturer];
    //        [USER_D setObject:responseObject[@"code"] forKey:[NSString stringWithFormat:@"%@isLecturer",VE_CODE]];

    if (btn.tag == 6742) {
        //会议审核
        MeetListViewController * vc = [MeetListViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        //会议提交
        if ([Lecturer isEqualToString:@"001"]) {
            SubmitMeetContentViewController * vc = [SubmitMeetContentViewController new];
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            UIAlertController * alert = [UICommonView showOneAlertWithTitle:@"提示" message:@"您还不是讲师，不能提交会议" preferredStyle:UIAlertControllerStyleAlert sureTitle:@"确定" sureBlock:^{
                
            }];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }

    
}


#pragma mark == tableView dalegate & datasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.SubmitedMeetListArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MeetCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MeetCell" forIndexPath:indexPath];
    cell.isSubmetedList = YES;
    cell.publishTime.adjustsFontSizeToFitWidth = YES;
    if (self.SubmitedMeetListArr.count > 0) {
        cell.model = self.SubmitedMeetListArr[indexPath.row];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    ShowMeetInfoViewController * vc = [ShowMeetInfoViewController new];
    vc.titleString = @"已提交会议信息";
    vc.isCheck = YES; //vc 中不会出现 审核 button
    vc.model = self.SubmitedMeetListArr[indexPath.row];
    
    [self.navigationController pushViewController:vc animated:YES];
    
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
