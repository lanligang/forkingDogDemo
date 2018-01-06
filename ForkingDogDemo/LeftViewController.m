//
//  LeftViewController.m
//  ForkingDogDemo
//
//  Created by Macx on 2018/1/6.
//  Copyright © 2018年 石家庄光耀. All rights reserved.
//

#import "LeftViewController.h"
#import <Masonry.h>
#import "LgMenuHeader.h"


@interface LeftViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *myTableView;


@property (nonatomic,strong)NSMutableArray *dataSource;
;
@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];

 UIImageView *bgImagView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bgImg"]];
 bgImagView.frame = [UIScreen mainScreen].bounds;
 [self.view addSubview:bgImagView];
 [self.view addSubview:self.myTableView];


 UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 100.0f)];
 self.myTableView.tableHeaderView = headerView;

 [self.myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
  make.left.mas_equalTo(0);
  if(@available(iOS 11.0,*)){
   make.top.mas_equalTo(self.view.safeAreaInsets.top).offset(0);
   make.bottom.mas_equalTo(self.view.safeAreaInsets.bottom);
  }else{
   make.top.and.bottom.mas_equalTo(0);
  }
  make.width.mas_equalTo(MAXOPEN_LEFT);
 }];

 UIImageView *headerImageV = [[UIImageView alloc]init];
 headerImageV.image = [UIImage imageNamed:@"header_left"];
 headerImageV.layer.cornerRadius =22.0f;
 headerImageV.clipsToBounds = YES;
 [headerView addSubview:headerImageV];
 [headerImageV mas_makeConstraints:^(MASConstraintMaker *make) {
  make.left.mas_equalTo(20.0f);
  make.width.mas_equalTo(44);
  make.height.mas_equalTo(44);
  make.bottom.mas_equalTo(-5);
 }];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
 return self.dataSource.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
 NSArray *arr = self.dataSource[section];
 return arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

 UITableViewCell *cell = nil;
cell =  [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
 cell.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0];
NSArray *arr = self.dataSource[indexPath.section];
 cell.textLabel.text = arr[indexPath.row];
 return cell;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  [self closeLgMenu];
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{

 return CGFLOAT_MIN;

}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
 return 20.0f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   return 44.0f;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
 return nil;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
 return nil;
}

-(NSMutableArray *)dataSource
{
 if (!_dataSource)
 {
 _dataSource = [@[@[@"战绩三国",@"坦克世界"],@[@"吃鸡手游",@"贪玩蓝月",@"吃鸡手游"],@[@"王者荣耀",@"QQ飞车"],@[@"关于我们"]] mutableCopy];
 }
 return _dataSource;
}


-(UITableView *)myTableView
{
 if (!_myTableView)
 {
 _myTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
 _myTableView.delegate = self;
 _myTableView.dataSource = self;
 [_myTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
 _myTableView.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.4];
 _myTableView.separatorStyle = UITableViewCellSelectionStyleNone;
 _myTableView.showsVerticalScrollIndicator = NO;
 }
 return _myTableView;
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
