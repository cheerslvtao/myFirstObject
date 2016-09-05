//
//  ShowMeetInfoViewController.m
//  ShiMingRenZheng
//
//  Created by 吕涛 on 16/8/4.
//  Copyright © 2016年 吕涛. All rights reserved.
//

#import "ShowMeetInfoViewController.h"
#import "MeetSubmitCell.h"
#import "CDCardCell.h"
#import "MMProgressHUD.h"
#define MEET_CHECK LINK_BASE_URL(@"/userMeeting/autoMeeting") // 星星之火 ———— 会议审核

@interface ShowMeetInfoViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    BOOL _isSelectPhoto;
    NSInteger _selectCellRow;
}
@property (nonatomic,strong) UITableView * submitTableView;

@property (nonatomic,strong) NSArray * titleArr;

@property (nonatomic,strong) NSArray * contentArr;

@end

@implementation ShowMeetInfoViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //设置返回按钮
    NvigationItemSingle * single = BACK_NAVIGATION;
    [single setNavigationBackItem:self];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = BGCOLOR;
    self.title = self.titleString;
    [self.view addSubview:self.submitTableView];
}

#pragma mark == 初始化 tableView
-(UITableView *)submitTableView{
    if (!_submitTableView) {
        _submitTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_width, SCREEN_height-64) style:UITableViewStylePlain];
        _submitTableView.delegate =self;
        _submitTableView.dataSource = self;
        _submitTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _submitTableView.estimatedRowHeight = 50;
        _submitTableView.rowHeight = UITableViewAutomaticDimension;
        [_submitTableView registerNib:[UINib nibWithNibName:@"CDCardCell" bundle:nil] forCellReuseIdentifier:@"CDCardCell"];
        [_submitTableView registerNib:[UINib nibWithNibName:@"MeetSubmitCell" bundle:nil] forCellReuseIdentifier:@"MeetSubmitCell"];
        
        _submitTableView.tableFooterView = [self customFooter];
        _submitTableView.tableHeaderView = [self customHeaderView];
    }
    return _submitTableView;
}
#pragma mark == 表头
-(UIView *)customHeaderView
{
    
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
    
    return lvLabel;
}

#pragma mark == 表尾
-(UIView *)customFooter{
    UIView * view = [[UIView alloc]init];
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, SCREEN_width/3, 30)];
    label.text = [self.titleArr lastObject];
    label.font = [UIFont systemFontOfSize:15];
    [view addSubview:label];
    
    UILabel * textLabel = [[UILabel alloc]init];
    
    textLabel.text = self.model.summary;
    
    textLabel.textColor = [UIColor grayColor];
    textLabel.numberOfLines = 0;//根据最大行数需求来设置
    CGSize MAXSIZE = CGSizeMake(SCREEN_width-20, SCREEN_height);
    CGSize labelSize = [textLabel sizeThatFits:MAXSIZE];
    textLabel.frame = CGRectMake(10, 40, labelSize.width, labelSize.height);

    [view addSubview:textLabel]; //总结 label
    
    float viewHeight = 40+labelSize.height; //view 的高
    if (!self.isCheck) {
        
        UIButton * passButton = [LeeAllView BigButton:CGRectMake(10, 15, SCREEN_width-20, 40) withTitel:@"通过"];
        [passButton addTarget:self action:@selector(checkPassed) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton * refuseButton = [LeeAllView BigButton:CGRectMake(10, 15+15+40, SCREEN_width-20, 40) withTitel:@"拒绝"];
        [refuseButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        refuseButton.backgroundColor = [UIColor grayColor];
        [refuseButton addTarget:self action:@selector(checkRefuse) forControlEvents:UIControlEventTouchUpInside];
        
        UIView * buttonVIew = [[UIView alloc]initWithFrame:CGRectMake(0, 40+labelSize.height, SCREEN_width, 80+45)];
        [buttonVIew addSubview:passButton];
        [buttonVIew addSubview:refuseButton];
        buttonVIew.backgroundColor = BGCOLOR;
        
        [view addSubview:buttonVIew];
        viewHeight = 40+labelSize.height+buttonVIew.frame.size.height;
    }
    view.frame = CGRectMake(0, 0, SCREEN_width, viewHeight);

    return view;
}


#pragma mark = = 审核通过
-(void)checkPassed{

    NSLog(@"会议id -- %@",self.model.SubmitedMeetListid);
    NSDictionary * dic =@{@"access_token":ACCESS_TOKEN,@"type":@"0",@"id":self.model.SubmitedMeetListid} ;
    
    __weak typeof(self) weakself = self;
    NSLog(@"dic -- %@",dic);
    [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleShrink];
    [MMProgressHUD showWithTitle:@"提示" status:@"玩命加载中..."];

    [HTTPURL postRequest:LINK_BASE_URL(@"/userMeeting/autoMeeting")  parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"response -- %@",responseObject);
        if ([responseObject[@"success"] intValue]==0) {
            [MMProgressHUD dismissWithError:responseObject[@"msg"] title:@"提示" afterDelay:1];
        }else{
            [MMProgressHUD dismissWithSuccess:responseObject[@"msg"] title:@"提示" afterDelay:1];
            [weakself.navigationController popViewControllerAnimated:YES];
        }
        
    } filure:^(NSURLSessionDataTask *task, id error) {
        NSLog(@"error -- %@",error);
        [MMProgressHUD dismissWithError:@"网络加载失败" title:@"提示" afterDelay:1];
    }showHUD:NO sucessMsg:@"" failureMsg:@""];
}

#pragma mark = = 审核拒绝
-(void)checkRefuse{
    __weak typeof(self) weakself = self;
    
    [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleShrink];
    [MMProgressHUD showWithTitle:@"提示" status:@"玩命加载中..."];

    [HTTPURL postRequest:MEET_CHECK parameters:@{@"access_token":ACCESS_TOKEN,@"type":@"1",@"id":self.model.SubmitedMeetListid} success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"response -- %@",responseObject);
        if ([responseObject[@"success"] intValue]==0) {
            [MMProgressHUD dismissWithError:responseObject[@"msg"] title:@"提示" afterDelay:1];
        }else{
            [MMProgressHUD dismissWithSuccess:responseObject[@"msg"] title:@"提示" afterDelay:1];
            [weakself.navigationController popViewControllerAnimated:YES];
        }
    } filure:^(NSURLSessionDataTask *task, id error) {
        NSLog(@"error -- %@",error);
        [MMProgressHUD dismissWithError:@"网络加载失败" title:@"提示" afterDelay:1];

    }showHUD:NO sucessMsg:@"" failureMsg:@""];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titleArr.count-1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row<7) {
        MeetSubmitCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MeetSubmitCell" forIndexPath:indexPath];
        cell.titleLabel.text = self.titleArr[indexPath.row];
        cell.textFiledCell.enabled =NO;
        if (self.contentArr.count>0) {
            cell.textFiledCell.text = self.contentArr[indexPath.row];
        }
        cell.rightLogo.hidden = YES;
        return cell;
    }
    CDCardCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CDCardCell" forIndexPath:indexPath];
    cell.UploadPhoto.hidden = YES;
    cell.titleLabel.text = self.titleArr[indexPath.row];
    if (self.contentArr.count>0) {
        [cell.photoImg setImageWithURL:[NSURL URLWithString:self.contentArr[indexPath.row]] placeholderImage:[UIImage imageNamed:@"mrtp"]];
    }
//    cell.photoImg.tag = 63548+indexPath.row;
//    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showPhotoClearness:)];
//    [cell.photoImg addGestureRecognizer:tap];

    return cell;
}

#pragma mark == 初始化标题数组
-(NSArray *)titleArr{
    if (!_titleArr) {
        _titleArr = [[NSArray alloc]initWithObjects:@"会议名称",@"会议地区",@"会议地点",@"主办人",@"讲师",@"会议时间",@"参会人员",@"会前照片",@"会中照片",@"会后照片",@"会议总结", nil];
    }
    return _titleArr;
}

-(NSArray *)contentArr{
    if (!_contentArr) {
        NSLog(@"self.model.address ===%@",self.model.address );
        
        NSArray * array = [self.model.address componentsSeparatedByString:@":"];
        NSArray * arr = [NSArray array];
        if (array.count == 2) {
            arr = @[self.model.title,array[0],array[1],self.model.sponsorName,self.model.teachVeCodeName,self.model.meeting_time_str,self.model.join_user,self.model.pic_start,self.model.pic_center,self.model.pic_end];
        }else{
            arr = @[self.model.title,array[0],@" ",self.model.sponsorName,self.model.teachVeCodeName,self.model.meeting_time_str,self.model.join_user,self.model.pic_start,self.model.pic_center,self.model.pic_end];
        }
        self.contentArr = [[NSArray alloc]initWithArray:arr];
    }
    return _contentArr;
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
