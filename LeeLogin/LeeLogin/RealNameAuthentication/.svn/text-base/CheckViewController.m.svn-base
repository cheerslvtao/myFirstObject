//
//  CheckViewController.m
//  ShiMingRenZheng
//
//  Created by 吕涛 on 16/8/2.
//  Copyright © 2016年 吕涛. All rights reserved.
//

#import "CheckViewController.h"
#import "CDCardCell.h"
#import "AuthenticationCell.h"
#import "RefuseAlertView.h"
#import "MMProgressHUD.h"
#define AUTHENTICATION_CHECK LINK_BASE_URL(@"/userAccount/authUserIdCard") //审核的实名认证

@interface CheckViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray * _titleArr;
    NSArray * _contentArr;
}

@property (nonatomic,strong) UITableView * checkTableView;
@end

@implementation CheckViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BGCOLOR;
    self.title = @"认证审核"; 
    
    //设置返回按钮  不放在ViewWillappear里面 这是最后一个页面了
    NvigationItemSingle * single = BACK_NAVIGATION;
    [single setNavigationBackItem:self];
    [self.view addSubview:self.checkTableView];
    _titleArr = [[NSArray alloc]initWithObjects:@"姓名",@"身份证号", nil];
    _contentArr = [[NSArray alloc]initWithObjects:self.model.real_name,self.model.idCard,nil];
    [self createButtons];
    
}

#pragma matk ==  通过/拒绝
-(void)createButtons{
    NSArray * arr = @[@"拒绝通过",@"审核通过"];
    for (int i=0; i<2; i++) {
        UIButton * btn = [LeeAllView BigButton:CGRectMake(10, SCREEN_height-60*(i+1), SCREEN_width-20, 40) withTitel:arr[i]];
        [btn addTarget:self action:@selector(checkClickButton:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 44453+i;
        if (i==0) {
            [btn setBackgroundImage:nil forState:UIControlStateNormal];
            btn.backgroundColor = [UIColor redColor];
        }
        [self.view addSubview:btn];
    }
}

#pragma mark == 按钮 点击事件
-(void)checkClickButton:(UIButton *)btn{
    if (btn.tag == 44453) {
        //审核拒绝
        UIView * bgView= [[UIView alloc]initWithFrame:self.view.bounds];
        bgView.backgroundColor = [UIColor blackColor];
        bgView.alpha = 0.7;
        [self.view addSubview:bgView];
        
        RefuseAlertView * view = nil;
        NSArray * arr = [[NSBundle mainBundle] loadNibNamed:@"RefuseAlertView" owner:nil options:nil];
        view = [arr lastObject];
        void(^myBlock)()= ^(){
            [bgView removeFromSuperview];
        };
        view.block = myBlock;
        view.frame = self.view.frame;
        [self.view addSubview:view];
        
//        使用通知中心 将拒绝原因传递过来
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(postRequest:) name:@"refuseReason" object:nil];
        return;
    }
    
    //-------------------------------——————————————————
    //                  审核通过
    //_________________________________________________
     __weak typeof(self)weakself = self;
  
    [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleShrink];
    [MMProgressHUD showWithTitle:@"提示" status:@"玩命加载中..."];

    [HTTPURL postRequest:AUTHENTICATION_CHECK parameters:@{
                                                          @"access_token":ACCESS_TOKEN,
                                                          @"item_ve_code":self.model.ve_code,
                                                          @"type":@"0",
                                                          @"reason":@"success",} success:^(NSURLSessionDataTask *task, id responseObject) {
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

//-------------------------------——————————————————
//                  审核拒绝
//_________________________________________________

-(void)postRequest:(NSNotification *)noti{
    NSDictionary * dic = noti.userInfo;
     __weak typeof(self)weakself = self;
    
    [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleShrink];
    [MMProgressHUD showWithTitle:@"提示" status:@"玩命加载中..."];
    [HTTPURL postRequest:AUTHENTICATION_CHECK parameters:@{
                                                          @"access_token":ACCESS_TOKEN,
                                                          @"item_ve_code":self.model.ve_code,
                                                          @"type":@"1",
                                                          @"reason":dic[@"reason"],
                                                          } success:^(NSURLSessionDataTask *task, id responseObject) {
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
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark == tableView初始化
-(UITableView * )checkTableView{
    if (!_checkTableView) {
        _checkTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_width, SCREEN_height-140) style:UITableViewStylePlain];
        _checkTableView.delegate =self;
        _checkTableView.dataSource = self;
        _checkTableView.showsVerticalScrollIndicator = NO;
        _checkTableView.separatorInset = UIEdgeInsetsZero;
        _checkTableView.estimatedRowHeight = 45;
        _checkTableView.rowHeight = UITableViewAutomaticDimension; //自适应
        [_checkTableView registerNib:[UINib nibWithNibName:@"CDCardCell" bundle:nil] forCellReuseIdentifier:@"CDCardCell"];
        [_checkTableView registerNib:[UINib nibWithNibName:@"AuthenticationCell" bundle:nil] forCellReuseIdentifier:@"AuthenticationCell"];
    }
    return _checkTableView;
}

#pragma mark == delegate & dagasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row <2) {
        AuthenticationCell * cell = [tableView dequeueReusableCellWithIdentifier:@"AuthenticationCell" forIndexPath:indexPath];
        cell.titleLabel.text = _titleArr[indexPath.row];
        cell.contentLabel.text = _contentArr[indexPath.row];
        return cell;
    }
    CDCardCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CDCardCell" forIndexPath:indexPath];
    cell.UploadPhoto.hidden = YES;
    [cell.photoImg setImageWithURL:[NSURL URLWithString:self.model.idCardPic] placeholderImage:[UIImage imageNamed:@"mrsfz"]];
    if (indexPath.row == 3) {
        cell.titleLabel.text = @"身份证背面照片";
        [cell.photoImg setImageWithURL:[NSURL URLWithString:self.model.idCardPic2] placeholderImage:[UIImage imageNamed:@"mrsfz"]];
    }
    return cell;
}


@end
