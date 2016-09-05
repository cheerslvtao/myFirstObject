//
//  MeetListViewController.m
//  ShiMingRenZheng
//
//  Created by 吕涛 on 16/8/4.
//  Copyright © 2016年 吕涛. All rights reserved.
//

#import "MeetListViewController.h"
#import "ShowMeetInfoViewController.h"
#import "MeetCell.h"
#import "SubmitMeetContentViewController.h"
#import "MJRefresh.h"
#import "SubmitedMeetList.h"
#define MEET_CHECK_LIST [NSString stringWithFormat:@"%@/userMeeting/applyMeeting?pages=%@&access_token=%@",BASE_URL,[NSString stringWithFormat:@"%d",self.pages],ACCESS_TOKEN] //星星之火 ———— 会议 审核列表
@interface MeetListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView * SparkTableView;

@property(nonatomic,strong) NSMutableArray * CheckMeetListArr;

@property (nonatomic) int pages;
@property (nonatomic)BOOL isRefresh;
@property (nonatomic) int totalPage;
@end

@implementation MeetListViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //设置返回按钮
    NvigationItemSingle * single = BACK_NAVIGATION;
    [single setNavigationBackItem:self];
    
    self.isRefresh = YES;
    [self getCheckList];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets =NO;
    self.view.backgroundColor = BGCOLOR;
    self.title = @"星星之火";
    self.CheckMeetListArr  = [[NSMutableArray alloc]init];
    [self.view addSubview:self.SparkTableView];

    
    [self refreshNewData];
    [self loadMoreData];
    
}

#pragma mark == 刷新 加载 数据
-(void)refreshNewData{
    __weak typeof(self) weakSelf = self;
    MJRefreshNormalHeader * header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.isRefresh = YES;
        [weakSelf getCheckList];
    }];
    self.SparkTableView.mj_header = header;
}

-(void)loadMoreData{
    __weak typeof(self) weakSelf = self;
    MJRefreshAutoNormalFooter * footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.isRefresh = NO;
        if (self.pages+1<self.totalPage) {
            self.pages++;
            [self getCheckList];
        }else{
            [self.SparkTableView.mj_footer endRefreshingWithNoMoreData];
        }
        
    }];
    self.SparkTableView.mj_footer = footer;
}


#pragma mark == 获取会议审核列表
-(void)getCheckList{
   
    __weak typeof(self)weakself = self;
    
    
    [HTTPURL postRequest:MEET_CHECK_LIST parameters:nil  success:^(NSURLSessionDataTask *task, id responseObject) {
        //获取到 会议列表 放入到数组中 dataArr;
        
        if (self.isRefresh) {
            [self.CheckMeetListArr removeAllObjects];
        }

        NSLog(@"会议审核列表 --- %@",responseObject);
        NSDictionary * dataDic = responseObject[@"data"];
        NSDictionary * pagedataDiv = dataDic[@"pagedata"];
        
        NSArray * contentArr = pagedataDiv[@"content"];
        self.totalPage = [pagedataDiv[@"totalPages"] intValue];
        
        for (int i=0; i<contentArr.count; i++) {
            SubmitedMeetList * model = [[SubmitedMeetList alloc]init];
            NSDictionary * subdic = contentArr[i];
            [model setValuesForKeysWithDictionary:subdic];
            [weakself.CheckMeetListArr addObject:model];
        }
        
        [weakself.SparkTableView reloadData];
        [weakself.SparkTableView.mj_header endRefreshing];
        [weakself.SparkTableView.mj_footer endRefreshing];
    } filure:^(NSURLSessionDataTask *task, id error) {
        NSLog(@"会议审核列表列表 异常  error == %@",error);
        [weakself.SparkTableView.mj_header endRefreshing];
        [weakself.SparkTableView.mj_footer endRefreshing];
        
    } showHUD:NO sucessMsg:@"" failureMsg:@""];
}

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
    
    NSString * level = [USER_D objectForKey:[NSString stringWithFormat:@"%@speak_level_name",VE_CODE]];
    if (!level) {
        level = @" ";
    }
    NSString * text = [NSString stringWithFormat:@"%@ [%@]",VE_CODE,level];

    //添加副文本
    NSRange range = [text rangeOfString:@" "];
    NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc]initWithString:text];
    [attStr addAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor],NSFontAttributeName:[UIFont systemFontOfSize:15]} range:NSMakeRange(range.location+1,[text length]-range.location-1 )];
    
    lvLabel.attributedText = attStr;
    [view addSubview:lvLabel];
    
    UILabel * titlelabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 60, SCREEN_width/3+5, 59)];
    
    titlelabel.text = @" 会议审核列表";
    titlelabel.font = [UIFont systemFontOfSize:15];
    titlelabel.textColor = COLOR(107,177, 234, 1);
    [view addSubview:titlelabel];
    
    
    UIView * lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 119, SCREEN_width, 1)];
    lineView.backgroundColor =COLOR(107,177, 234, 1);
    [view addSubview:lineView];
    
    return view;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.CheckMeetListArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MeetCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MeetCell" forIndexPath:indexPath];
    cell.isSubmetedList = NO;
    if (self.CheckMeetListArr.count>0) {
        cell.model = self.CheckMeetListArr[indexPath.row];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    ShowMeetInfoViewController * vc = [ShowMeetInfoViewController new];
    vc.titleString = @"会议审核";
    vc.isCheck = NO;
    vc.model = self.CheckMeetListArr[indexPath.row];
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
