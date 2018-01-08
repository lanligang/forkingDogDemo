//
//  ViewController.m
//  ForkingDogDemo
//
//  Created by ios2 on 2018/1/3.
//  Copyright © 2018年 石家庄光耀. All rights reserved.
//

#import "ViewController.h"

#import <UITableView+FDTemplateLayoutCell.h>
//这里 用mas  只是用来布局
#import <Masonry.h>
//单独文字
#import "TextTableViewCell.h"
//混合样式
#import "MixTableViewCell.h"
//masCell
#import "MasTextCellTableViewCell.h"
#import "LgMenuHeader.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *myTableView;


@property (nonatomic,strong)NSMutableArray *dataSource;


@end

@implementation ViewController


-(void)setTitleView
{
 UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 44.0f)];

 self.navigationItem.titleView  = titleView;
 NSArray *titles =@[@"消息",@"通知"];
 for (int i = 0; i<2; i++)
 {
 UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
 [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
 [btn setTitle:titles[i] forState:UIControlStateNormal];
 [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
 [titleView addSubview:btn];
 if(i==0){
  btn.selected = YES;
  UIView *lineView = [UIView new];
  lineView.backgroundColor =[UIColor lightGrayColor];
  [titleView addSubview:lineView];
  [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
   make.centerX.mas_equalTo(0);
   make.centerY.mas_equalTo(0);
   make.height.mas_equalTo(20.0f);
   make.width.mas_equalTo(1.0f);
  }];
 }
 [btn mas_makeConstraints:^(MASConstraintMaker *make) {
  if(i==0){
   make.right.mas_equalTo(titleView.mas_centerX);
  }else{
   make.left.mas_equalTo(titleView.mas_centerX);
  }
  make.width.mas_equalTo(60.0f);
  make.height.mas_equalTo(44.0f);
  make.centerY.mas_equalTo(0);
 }];
 }
 UIView *spaceView = [UIView new];
 spaceView.bounds =CGRectMake(0, 0, 44, 44);
 UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:spaceView];
 self.navigationItem.rightBarButtonItem =item;

}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setTitleView];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.myTableView];
    
    [_myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
     make.bottom.mas_equalTo(0);
    }];

 UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"header_left"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(openAction:)];
 self.navigationItem.leftBarButtonItem = rightItem;
}
-(void)openAction:(id)sender
{
   [self openLgMenu];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"MixTableViewCell";
    if (indexPath.row==0||indexPath.row==4) {
        identifier = @"TextTableViewCell";
	 }else if (indexPath.row==2||indexPath.row==1){
	  identifier = @"MasTextCellTableViewCell";
	 }
    BaseTableViewCell *cell = nil;
    cell =  [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    cell.model = self.dataSource[indexPath.row];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
 UIViewController *vc = [[UIViewController alloc]init];
 vc.hidesBottomBarWhenPushed = YES;
 //原则上是不能这样写的
 vc.view.backgroundColor = [UIColor whiteColor];

 [self.navigationController pushViewController:vc animated:YES];
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return CGFLOAT_MIN;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"MixTableViewCell";
 if (indexPath.row==0||indexPath.row==4) {
  identifier = @"TextTableViewCell";
 }else if (indexPath.row==2||indexPath.row==1){
  identifier = @"MasTextCellTableViewCell";
 }
    __weak ViewController *weakSelf = self;
    return [tableView fd_heightForCellWithIdentifier:identifier cacheByIndexPath:indexPath configuration:^(BaseTableViewCell *cell) {
        cell.model =weakSelf.dataSource[indexPath.row];
    }];
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
        _dataSource = [@[@"本来包妹已经预料好，晚会直播为了保证效果，假唱也是正常的，可以接受。巴特，今年这一场，我真的震惊了，上去假唱的部分朋友，怕是我把当成聋子和傻子吧",
								 @"在使用mas 自动计算高度的时候 可以避免一些不太会使用xib的人的一些麻烦  关键的一句代码必须要有 敲黑板 划重点‘ make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);  ’ 晚会直播为了保证效果，假唱也是正常的，可以接受。巴特，今年这一场，我真的震惊了，上去假唱的部分朋",
								 @"做好xib约束,用此库计算cell的高度,其中需要注意的一点是label的高度自适应需要增加一句做好xib约束,用此库计算cell的高度,其中需要注意的一点是label的高度自适应需要增加一句代码:  self.testLabel.preferredMaxLayoutWidth = [UIScreen 做好xib约束,用此库计算cell的高度,其中需要注意的一点是label的高度自适应需要增加一句代码:  self.testLabel.preferredMaxLayoutWidth = [UIScreen 做好xib约束,用此库计算cell的高度,其中需要注意的一点是label的高度自适应需要增加一句代码:  self.testLabel.preferredMaxLayoutWidth = [UIScreen 做好xib约束,用此库计算cell的高度,其中需要注意的一点是label的高度自适应需要增加一句代码:  self.testLabel.preferredMaxLayoutWidth = [UIScreen 代码:  self.testLabel.preferredMaxLayoutWidth = [UIScreen ",@"做好xib约束,用此库计算cell的高度,其中需要注意的一点是label的高度自适应需要增加一句代码:  self.testLabel.preferredMaxLayoutWidth = [UIScreen 做好xib约束,用此库计算cell的高度,其中需要注意的一点是label的高度自适应需要增加一句代码:  self.testLabel.preferredMaxLayoutWidth = [UIScreen 做好xib约束,用此库计算cell的高度,其中需要注意的一点是label的高度自适应需要增加一句代码:  self.testLabel.preferredMaxLayoutWidth = [UIScreen ",@"做好xib约束,用此库计算cell的高度,其中需要注意的一点是label的高度自适应需要增加一句代码:  self.testLabel.preferredMaxLayoutWidth = [UIScreen 做好xib约束,用此库计算cell的高度,其中需要注意的一点是label的高度自适应需要增加一句代码:  self.testLabel.preferredMaxLayoutWidth = [UIScreen ",@"经预料好，晚会直播为了保证效果，假唱也是正常的，可以接受。巴特，今年这一场，我真的震惊了，上去假唱的部分朋友，怕是我把经预料好，晚会直播为了保证效果，假唱也是正常的，可以接受。巴特，今年这一场，我真的震惊了，上去假唱的部分朋友，怕是我把经预料好，晚会直播为了保证效果，假唱也是正常的，可以接受。巴特，今年这一场，我真的震惊了，上去假唱的部分朋友，怕是我把经预料好，晚会直播为了保证效果，假唱也是正常的，可以接受。巴特，今年这一场，我真的震惊了，上去假唱的部分朋友，怕是我把",@"经预料好，晚会直播为了保证效果，假唱也是正常的，可以接受。巴特，今年这一场，我真的震惊了，上去假唱的部分朋友，怕是我把经预料好，晚会直播为了保证效果，假唱也是正常的，可以接受。巴特，今年这一场，我真的震惊了，上去假唱的部分朋友，怕是我把经预料好，晚会直播为了保证效果，假唱也是正常的，可以接受。巴特，今年这一场，我真的震惊了，上去假唱的部分朋友，怕是我把经预料好，晚会直播为了保证效果，假唱也是正常的，可以接受。巴特，今年这一场，我真的震惊了，上去假唱的部分朋友，怕是我把经预料好，晚会直播为了保证效果，假唱也是正常的，可以接受。巴特，今年这一场，我真的震惊了，上去假唱的部分朋友，怕是我把经预料好，晚会直播为了保证效果，假唱也是正常的，可以接受。巴特，今年这一场，我真的震惊了，上去假唱的部分朋友，怕是我把经预料好，晚会直播为了保证效果，假唱也是正常的，可以接受。巴特，今年这一场，我真的震惊了，上去假唱的部分朋友，怕是我把经预料好，晚会直播为了保证效果，假唱也是正常的，可以接受。巴特，今年这一场，我真的震惊了，上去假唱的部分朋友，怕是我把经预料好，晚会直播为了保证效果，假唱也是正常的，可以接受。巴特，今年这一场，我真的震惊了，上去假唱的部分朋友，怕是我把经预料好，晚会直播为了保证效果，假唱也是正常的，可以接受。巴特，今年这一场，我真的震惊了，上去假唱的部分朋友，怕是我把",@"经预料好，晚会直播为了保证效果，假唱也是正常的，可以接受。巴特，今年这一场，我真的震惊了，上去假唱的部分朋友，怕是我把经预料好，晚会直播为了保证效果，假唱也是正常的，可以接受。巴特，今年这一场，我真的震惊了，上去假唱的部分朋友，怕是我把经预料好，晚会直播为了保证效果，假唱也是正常的，可以接受。巴特，今年这一场，我真的震惊了，上去假唱的部分朋友，怕是我把经预料好，晚会直播为了保证效果，假唱也是正常的，可以接受。巴特，今年这一场，我真的震惊了，上去假唱的部分朋友，怕是我把经预料好，晚会直播为了保证效果，假唱也是正常的，可以接受。巴特，今年这一场，我真的震惊了，上去假唱的部分朋友，怕是我把经预料好，晚会直播为了保证效果，假唱也是正常的，可以接受。巴特，今年这一场，我真的震惊了，上去假唱的部分朋友，怕是我把经预料好，晚会直播为了保证效果，假唱也是正常的，可以接受。巴特，今年这一场，我真的震惊了，上去假唱的部分朋友，怕是我把经预料好，晚会直播为了保证效果，假唱也是正常的，可以接受。巴特，今年这一场，我真的震惊了，上去假唱的部分朋友，怕是我把经预料好，晚会直播为了保证效果，假唱也是正常的，可以接受。巴特，今年这一场，我真的震惊了，上去假唱的部分朋友，怕是我把"] mutableCopy];
    }
    return _dataSource;
}


-(UITableView *)myTableView
{
    if (!_myTableView)
    {
        _myTableView = [[UITableView alloc]init];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        [_myTableView registerNib:[UINib nibWithNibName:@"TextTableViewCell" bundle:nil] forCellReuseIdentifier:@"TextTableViewCell"];
        [_myTableView registerNib:[UINib nibWithNibName:@"MixTableViewCell" bundle:nil] forCellReuseIdentifier:@"MixTableViewCell"];
	      [_myTableView registerClass:[MasTextCellTableViewCell class] forCellReuseIdentifier:@"MasTextCellTableViewCell"];
	 
    }
    return _myTableView;
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
