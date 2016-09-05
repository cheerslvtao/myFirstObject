



//
//  AroundMallVC.m
//  LeeLogin
//
//  Created by 李雪虎 on 16/8/4.
//  Copyright © 2016年 Leexiaohu. All rights reserved.
//

#import "AroundMallVC.h"
#import "StoreTableViewCell.h"
#import "ListGoodsVC.h"//商品
@interface AroundMallVC ()<UITableViewDataSource,UITableViewDelegate,BMKMapViewDelegate,BMKPoiSearchDelegate,BMKBusLineSearchDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate>
{
    BMKMapView *_mapView;//地图
    //    BMKPoiSearch *_searcher;
    BMKBusLineSearch *_searcher;//搜索公交详情检索
    BMKGeoCodeSearch *_searcherCoding;//编码搜索
    BMKLocationService *_service;//定位
    float locaLatitude;
    float locaLongitude;
    BMKReverseGeoCodeOption *reverseGeoCodeOption;//逆地理编码
    
}
@end

@implementation AroundMallVC

- (void)viewDidLoad {
    [super viewDidLoad];
    NSDictionary *dic=[[NSDictionary alloc]initWithObjectsAndKeys:@"新百广场店",@"a",@"新百广场三楼",@"b",@"0311-87654321",@"c", nil];
    NSDictionary *dicc =[[NSDictionary alloc]initWithObjectsAndKeys:@"华强广场店",@"a",@"华强广场四楼",@"b",@"0311-23455423",@"c", nil];
    _cellArray = @[dic,dicc];
    self.title = @"周边商店";
    [self createUItabelView];
    // Do any additional setup after loading the view.
}
#pragma mark--表格以及表格的代理方法
//创建表
-(void)createUItabelView
{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_width, SCREEN_height) style:UITableViewStyleGrouped ];
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.delegate =self;
    tableView.dataSource = self;
    tableView.bounces = YES;
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:tableView];
    
    [tableView registerClass:[StoreTableViewCell class] forCellReuseIdentifier:@"cell"];
}
//返回区头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return SCREEN_height/3*2;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_width, SCREEN_height/3*2)];
    _mapView = [[BMKMapView alloc] initWithFrame:view.bounds];
    _mapView.delegate = self;
    _service = [[BMKLocationService alloc]init];
    _service.delegate = self;
    //启动LocationService
    [_service startUserLocationService];
    
    //初始化检索对象编码检索
    _searcherCoding =[[BMKGeoCodeSearch alloc]init];
    _searcherCoding.delegate = self;
    [view addSubview:_mapView];
    //白色标题框
    UIView *writhView = [[UIView alloc]initWithFrame:CGRectMake(15, 15, SCREEN_width-30, 50)];
    writhView.backgroundColor = [UIColor whiteColor];
    [writhView.layer setMasksToBounds:YES];//编辑
    [writhView.layer setBorderWidth:1.0];//边框宽度
    [writhView.layer setCornerRadius:10.0];//圆角度
    writhView.layer.borderColor=BGCOLOR.CGColor;//边框颜色
    [view addSubview:writhView];
    //VE号
    UILabel *VELabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, writhView.frame.size.width/2-15,30)];
    VELabel.backgroundColor = BGCOLOR;
    VELabel.textAlignment = NSTextAlignmentRight;
    [writhView addSubview:VELabel];
    //会员等级
    UILabel *membersLabel = [[UILabel alloc]initWithFrame:CGRectMake(writhView.frame.size.width/2+5, 10, writhView.frame.size.width/2-15, 30)];
    membersLabel.textAlignment = NSTextAlignmentLeft;
    membersLabel.backgroundColor = BGCOLOR;
    membersLabel.textColor = TEXTCOLOR;
    [writhView addSubview:membersLabel];
    return view;
}
//返回行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return 2;
}
//返回内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.mallLabel.text = _cellArray[indexPath.row][@"a"];
    cell.storeLabel.text = _cellArray[indexPath.row][@"b"];
    cell.phoneLabel.text = _cellArray[indexPath.row][@"c"];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ListGoodsVC *vc = [ListGoodsVC new];
    vc.mallString= _cellArray[indexPath.row][@"a"];
    vc.storeString = _cellArray[indexPath.row][@"b"];
    vc.phoneString = _cellArray[indexPath.row][@"c"];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark --百度地图代理方法
//处理方向变更信息
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    _mapView.showsUserLocation = YES;
    [_mapView updateLocationData:userLocation];
    
    [_mapView setCenterCoordinate:userLocation.location.coordinate animated:YES];
    
    NSLog(@"%f %f",userLocation.location.coordinate.longitude,userLocation.location.coordinate.latitude);
    NSLog(@"heading is %@",userLocation.heading);
}
//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    
    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    
    locaLatitude=[[NSString stringWithFormat:@"%0.3f",userLocation.location.coordinate.longitude ]floatValue];
    NSLog(@"~~~~~~~~~~~~~%f",locaLatitude);
    locaLongitude=[[NSString stringWithFormat:@"%0.3f",userLocation.location.coordinate.longitude ] floatValue];
    CLLocationCoordinate2D pt = (CLLocationCoordinate2D){39.915,116.404};
    BMKReverseGeoCodeOption *reverseGeoCodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
    reverseGeoCodeSearchOption.reverseGeoPoint = pt;
    BOOL flag = [_searcherCoding reverseGeoCode:reverseGeoCodeSearchOption];
    if(flag){
        NSLog(@"反geo检索发送成功");
    }else
    {
        NSLog(@"反geo检索发送失败");
    }
}
//反向地理编码搜索代理方法
-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:
(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    
    NSLog(@"searcher!!!!!!%@",searcher);
    NSLog(@"result~~~~~~%@",result.addressDetail.city);
    NSLog(@"result~~~~~~%@",result.addressDetail.streetName);
    NSLog(@"result~~~~~~%@",result.addressDetail.streetNumber);
    
    if (error == BMK_SEARCH_NO_ERROR)
    {
        NSLog(@"%@",searcher);
        NSLog(@"%@",result);
        
        
    }else{
        NSLog(@"没有找到");
    }
}
//定位失败
- (void)didFailToLocateUserWithError:(NSError *)error
{
    NSLog(@"error%@",error);
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
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
