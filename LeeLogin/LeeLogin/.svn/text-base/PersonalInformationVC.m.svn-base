

//
//  PersonalInformationVC.m
//  LeeLogin
//
//  Created by 李雪虎 on 16/8/1.
//  Copyright © 2016年 Leexiaohu. All rights reserved.
//

#import "PersonalInformationVC.h"
#import "LoginVC.h"//登录
#import "PersonalInformationVCCell.h"//
#import "HeadPortraitCell.h"//头像Cell
#import "ModifyPictureVC.h"//修改头像
#import "ChangePasswordVC.h"//修改密码
#import "AllModifyVC.h"//所有修改
#import "BindingEmailVC.h"//绑定邮箱
#import "IndividualitySignatureCell.h"//个性签名cell
#define GetUserDataPageModelByVecode @"/userAccount/getUserDataPageModelByVecode"//个人信息
#define SaveUserInfo @"/userAccount/saveUserInfo"//修改个人信息
@interface PersonalInformationVC ()<UITableViewDelegate,UITableViewDataSource,AllModifyVCDelegate>
{
    NSArray *_bigArray;
    NSArray *_contenArray;
    UITableView *tabelView;
}

@end

@implementation PersonalInformationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self starRequest];//发送请求
    self.title = @"个人信息";
    NSArray * firstArray = @[@"头像",@"VE号",@"会员等级",@"昵称",@"姓名",@"联系方式",@"邮箱",@"个性签名"];
    NSArray * secondArray = @[@"推荐人",@"培养人",@"企业员工",@"婚姻状况",@"有无子女",@"政治面貌",@"养老保险",@"人寿保险"];
    _bigArray = [NSArray arrayWithObjects:firstArray,secondArray, nil];
    //个人信息
    [self addView];
    // Do any additional setup after loading the view.
}
-(void)addView
{
    tabelView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_width, SCREEN_height) style:UITableViewStyleGrouped];
    tabelView.backgroundColor = BGCOLOR;
    tabelView.showsVerticalScrollIndicator = NO;//隐藏滑动条
    tabelView.delegate = self;
    tabelView.dataSource = self;
    [tabelView setLayoutMargins:UIEdgeInsetsZero];
    [self.view addSubview:tabelView];
    [tabelView registerClass:[PersonalInformationVCCell class] forCellReuseIdentifier:@"cell"];
    [tabelView registerClass:[HeadPortraitCell class] forCellReuseIdentifier:@"headCell"];
    [tabelView registerClass:[IndividualitySignatureCell class] forCellReuseIdentifier:@"IndividualityCell"];
}
#pragma mark--表代理方法
//返回区头高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0.01;
    }
    return 15;
}
//返回行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==2){
        return 2;
    }else if (section==3){
        return 0;
    }else{
        return 8;
    }
}
//用于设定编中区的个数,默认情况是1个区
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        if (indexPath.row==0||indexPath.row==7) {
            return 80;
        }else{
            return 60;
        }
    }else{
        return 60;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.001;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PersonalInformationVCCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    HeadPortraitCell *headCell = [tableView dequeueReusableCellWithIdentifier:@"headCell"];
    IndividualitySignatureCell *IndividualityCell = [tableView dequeueReusableCellWithIdentifier:@"IndividualityCell"];
    if (indexPath.section==2){
        if (indexPath.row==0) {
            headCell.titelLabel.text = @"修改登录密码";
            headCell.titelLabel.frame = CGRectMake(20, 20, 150, 20);
            headCell.headImgView.frame = CGRectMake(SCREEN_width-30, 15, 15, 30);
            headCell.headImgView.layer.masksToBounds = 0;
            [headCell.headImgView.layer setCornerRadius:0];
            headCell.headImgView.image = [UIImage imageNamed:@"arrow_right"];
            headCell.selectionStyle = UITableViewCellSelectionStyleNone;//取消点击状态
            return headCell;
        }else{
            headCell.titelLabel.text = @"注  销/切换账号";
            headCell.titelLabel.textColor = [UIColor redColor];
            headCell.titelLabel.frame = CGRectMake(20, 20, 150, 20);
            headCell.headImgView.frame = CGRectMake(SCREEN_width-30, 15, 15, 30);
            headCell.headImgView.layer.masksToBounds = 0;
            [headCell.headImgView.layer setCornerRadius:0];
            headCell.headImgView.image = [UIImage imageNamed:@"arrow_right"];
            headCell.selectionStyle = UITableViewCellSelectionStyleNone;//取消点击状态
            return headCell;
        }
    }else if(indexPath.section==0){
        if (indexPath.row==0){
            headCell.titelLabel.text = _bigArray[indexPath.section][indexPath.row];
            [headCell.headImgView setImageWithURL:[NSURL URLWithString:[USER_D objectForKey:@"head_url"]] placeholderImage:[UIImage imageNamed:@"photo"]];
            headCell.selectionStyle = UITableViewCellSelectionStyleNone;//取消点击状态
            return headCell;
        }else if (indexPath.row==7){
            IndividualityCell.titelLabel.text = _bigArray[indexPath.section][indexPath.row];
            IndividualityCell.contentLabel.text = _contenArray[indexPath.section][indexPath.row];//内容
            IndividualityCell.tag = indexPath.row+10;
            IndividualityCell.selectionStyle = UITableViewCellSelectionStyleNone;//取消点击状态
            return IndividualityCell;
        }
        else{
            cell.titelLabel.text = _bigArray[indexPath.section][indexPath.row];//标题
            cell.contentLabel.text = _contenArray[indexPath.section][indexPath.row];//内容
            cell.tag = indexPath.row+10;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;//取消点击状态
        
    }else if (indexPath.section==1){
        cell.titelLabel.text = _bigArray[indexPath.section][indexPath.row];//标题
        cell.contentLabel.text = _contenArray[indexPath.section][indexPath.row];//内容
        cell.tag = indexPath.row+30;
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;//取消点击状态
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {    //第一个区
        if (indexPath.row==0) {    //第一行
            ModifyPictureVC *vc = [ModifyPictureVC new];
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            if (indexPath.row==1||indexPath.row==2||indexPath.row==4) {     //第二行,第三行,第五行
                return;
            }else{
                if (indexPath.row==6){
                    BindingEmailVC *vc = [BindingEmailVC new];
                    [self.navigationController pushViewController:vc animated:YES];
                }else{
                    PersonalInformationVCCell *cell = [self.view viewWithTag:indexPath.row+10];
                    AllModifyVC *modifyVC = [AllModifyVC new];
                    modifyVC.titleString = cell.titelLabel.text;
                    [self.navigationController pushViewController:modifyVC animated:YES];
                }
            }
        }
    }else if (indexPath.section==1){//第二个区
        
        if (indexPath.row==1||indexPath.row==0){
            if (indexPath.row==1) {
                return;
            }else{
                if ([[USER_D objectForKey:@"推荐人"] isEqual:@"无"])
                {
                    PersonalInformationVCCell *cell = [self.view viewWithTag:indexPath.row+30];
                    AllModifyVC *modifyVC = [AllModifyVC new];
                    modifyVC.titleString = cell.titelLabel.text;
                    [self.navigationController pushViewController:modifyVC animated:YES];
                }
            }
            return;
        }else{
            PersonalInformationVCCell *cell = [self.view viewWithTag:indexPath.row+30];
            NSLog(@"%ld",(long)cell.tag);
            NSLog(@"%@",cell.titelLabel.text);
            AllModifyVC *modifyVC = [AllModifyVC new];
            modifyVC.delegate = self;
            modifyVC.titleString = cell.titelLabel.text;
            [self.navigationController pushViewController:modifyVC animated:YES];
        }
    }else if (indexPath.section==2){   //第三个区
        if (indexPath.row==0) {
            ChangePasswordVC *vc = [ChangePasswordVC new];
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            UIAlertController * alert = [UICommonView showTwoAlertWithTitle:@"提示" message:@"您确定要注销/切换账号" preferredStyle:UIAlertControllerStyleAlert sureTitle:@"确定" cancelTitle:@"取消" sureBlock:^{
                LoginVC *vc= [LoginVC new];
                UINavigationController * nv = [[UINavigationController alloc]initWithRootViewController:vc];
                UIWindow *window =[[UIApplication  sharedApplication].delegate window];
                window.rootViewController = nv;
                
            } cancelBlock:^{
                
            }];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }
}
//代理方法
- (void)refreshList
{
    [self storeInformation];//刷新数据
    [tabelView reloadData];//刷新表格
    
}
//存储
#pragma mark -- 上传个人信息信息()
-(void)storeInformation
{
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *VEString = [NSString stringWithFormat:@"%@",[user objectForKey:@"ve_code"]];
    if (VEString==NULL) {
        VEString = @"";
    }
    NSString *membershipString = [NSString stringWithFormat:@"%@",[user objectForKey:@"会员等级"]];
    if (membershipString==NULL) {
        membershipString = @"";
    }
    NSString *nicknameString = [NSString stringWithFormat:@"%@",[user objectForKey:@"昵称"]];
    if (nicknameString==NULL) {
        nicknameString = @"";
    }
    NSString *nameString = [NSString stringWithFormat:@"%@",[user objectForKey:@"姓名"]];
    if (nameString==NULL) {
        nameString = @"";
    }
    NSString *contactString = [NSString stringWithFormat:@"%@",[user objectForKey:@"联系方式"]];
    if (contactString==NULL) {
        contactString = @"";
    }
    NSString *emailString = [NSString stringWithFormat:@"%@",[user objectForKey:@"邮箱"]];
    if (emailString==NULL) {
        emailString = @"";
    }
    NSString *individualitySignatureString = [NSString stringWithFormat:@"%@",[user objectForKey:@"个性签名"]];
    if (individualitySignatureString==NULL) {
        individualitySignatureString = @"";
    }
    NSString *refereesString = [NSString stringWithFormat:@"%@",[user objectForKey:@"推荐人"]];
    if (refereesString==NULL) {
        refereesString = @"无";
    }
    NSString *refereStrVE =[NSString stringWithFormat:@"%@",[user objectForKey:@"recVeCode"]];
    if (refereStrVE==NULL) {
        refereStrVE = @"";
    }
    NSString *personString = [NSString stringWithFormat:@"%@",[user objectForKey:@"培养人"]];
    if (personString==NULL) {
        personString = @"无";
    }
    NSString *enterpriseString = [NSString stringWithFormat:@"%@",[user objectForKey:@"企业员工"]];
    if (enterpriseString==NULL) {
        enterpriseString = @"";
    }
    
    NSString *marriageString = [NSString stringWithFormat:@"%@",[user objectForKey:@"婚姻状况"]];
    if (marriageString==NULL) {
        marriageString = @"未选择";
    }
    NSString *childrenString = [NSString stringWithFormat:@"%@",[user objectForKey:@"有无子女"]];
    if (childrenString==NULL) {
        childrenString = @"未选择";
    }
    NSString *politicalString = [NSString stringWithFormat:@"%@",[user objectForKey:@"政治面貌"]];
    if (politicalString==NULL) {
        politicalString = @"未选择";
    }
    NSString *agedString = [NSString stringWithFormat:@"%@",[user objectForKey:@"养老保险"]];
    if (agedString==NULL) {
        agedString = @"未选择";
    }
    NSString *lifeString = [NSString stringWithFormat:@"%@",[user objectForKey:@"人寿保险"]];
    if (lifeString==NULL) {
        lifeString = @"未选择";
    }
    NSArray *firstContenArray = @[@"",VEString,membershipString,nicknameString,nameString,contactString,emailString,individualitySignatureString];
    NSArray *sectonContenArray = @[refereesString,personString,enterpriseString,marriageString,childrenString,politicalString,agedString,lifeString];
    _contenArray = @[firstContenArray,sectonContenArray];
    //上传个人信息 LINK_URL(SaveUserInfo)
    [HTTPURL postRequest:LINK_URL(SaveUserInfo)parameters:@{@"nickName":nicknameString,@"phone":contactString,@"email":emailString,@"signature":individualitySignatureString,@"job":enterpriseString,@"marrage":marriageString,@"children":childrenString,@"lifeInsurance":lifeString,@"politicalLandscape":politicalString,@"endowmentInsurance":agedString,@"access_token":ACCESS_TOKEN,@"recVeCode":refereStrVE} success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"responseObject====!!!!!====%@",responseObject[@"msg"]);
        NSLog(@"=====responseObject======%@",responseObject);
    } filure:^(NSURLSessionDataTask *task, id error) {
        NSLog(@"%@",error);
    }showHUD:NO sucessMsg:@"" failureMsg:@"网络繁忙,信息更新失败"];
    [tabelView reloadData];
}
#pragma mark --获取个人信息
-(void)starRequest{
    //发送请求
    __block  PersonalInformationVC *personalInformationVC = self;
    
    [HTTPURL postRequest:LINK_BASE_URL(GetUserDataPageModelByVecode) parameters:@{@"access_token":ACCESS_TOKEN} success:^(NSURLSessionDataTask *task, id responseObject) {
        personalInformationVC.personalMOD = [PersonalInformationMOD new];
        NSDictionary *dic = responseObject[@"data"];
        [personalInformationVC.personalMOD setValuesForKeysWithDictionary:dic];
        [personalInformationVC storagelocal];//存储本地更新
        [personalInformationVC storeInformation];//刷新列表
        NSLog(@"~~~获取个人信息~~~~%@",responseObject);
    } filure:^(NSURLSessionDataTask *task, id error) {
        NSLog(@"%@",error);
    }showHUD:YES sucessMsg:@"加载成功" failureMsg:@"加载失败"];
    
    
}
#pragma mark -- 获取新的信息储存到本地
-(void)storagelocal
{
    [USER_D setObject:self.personalMOD.user_level_name forKey:@"会员等级"];
    [USER_D setObject:self.personalMOD.nickname forKey:@"昵称"];
    [USER_D setObject:self.personalMOD.real_name forKey:@"姓名"];
    [USER_D setObject:self.personalMOD.phone forKey:@"联系方式"];
    [USER_D setObject:self.personalMOD.email forKey:@"邮箱"];
    [USER_D setObject:self.personalMOD.signature forKey:@"个性签名"];
    [USER_D setObject:self.personalMOD.rec_name forKey:@"推荐人"];
    [USER_D setObject:self.personalMOD.teach_name forKey:@"培养人"];
    [USER_D setObject:self.personalMOD.job forKey:@"企业员工"];
    [USER_D setObject:self.personalMOD.marrage_name forKey:@"婚姻状况"];
    [USER_D setObject:self.personalMOD.children_name forKey:@"有无子女"];
    [USER_D setObject:self.personalMOD.political_landscape_name forKey:@"政治面貌"];
    [USER_D setObject:self.personalMOD.endowment_insurance_name forKey:@"养老保险"];
    [USER_D setObject:self.personalMOD.life_insurance_name forKey:@"人寿保险"];
    
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self storeInformation];
}
//-(void)viewDidAppear:(BOOL)animated
//{
//    [super viewDidAppear:animated];
//    [self storeInformation];//上传个人信息
//    NSLog(@"aasfasdf");
//}

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
