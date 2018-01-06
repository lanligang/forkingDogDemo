//
//  LeftViewController.m
//  ForkingDogDemo
//
//  Created by Macx on 2018/1/6.
//  Copyright © 2018年 石家庄光耀. All rights reserved.
//

#import "LeftViewController.h"
#import <Masonry.h>
#import <UITableView+FDTemplateLayoutCell.h>
 //单独文字
#import "TextTableViewCell.h"
 //混合样式
#import "MixTableViewCell.h"
 //masCell
#import "MasTextCellTableViewCell.h"
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



    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.myTableView];
 [self.myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
  make.left.mas_equalTo(0);
  if(@available(iOS 11.0,*)){
   make.top.mas_equalTo(self.view.safeAreaInsets.top).offset(80.0f);
   make.bottom.mas_equalTo(self.view.safeAreaInsets.bottom);
  }else{
   make.top.and.bottom.mas_equalTo(80.0f);
  }
  make.width.mas_equalTo(200.0f);
 }];

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
 __weak LeftViewController *weakSelf = self;
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
