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

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *myTableView;


@property (nonatomic,strong)NSMutableArray *dataSource;


@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.myTableView];
    
    [_myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
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
    if (indexPath.row%2!=0) {
        identifier = @"TextTableViewCell";
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
    if (indexPath.row%2!=0) {
        identifier = @"TextTableViewCell";
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
        _dataSource = [@[@"本来包妹已经预料好，晚会直播为了保证效果，假唱也是正常的，可以接受。巴特，今年这一场，我真的震惊了，上去假唱的部分朋友，怕是我把当成聋子和傻子吧",@"晚会直播为了保证效果，假唱也是正常的，可以接受。巴特，今年这一场，我真的震惊了，上去假唱的部分朋",@"做好xib约束,用此库计算cell的高度,其中需要注意的一点是label的高度自适应需要增加一句做好xib约束,用此库计算cell的高度,其中需要注意的一点是label的高度自适应需要增加一句代码:  self.testLabel.preferredMaxLayoutWidth = [UIScreen 做好xib约束,用此库计算cell的高度,其中需要注意的一点是label的高度自适应需要增加一句代码:  self.testLabel.preferredMaxLayoutWidth = [UIScreen 做好xib约束,用此库计算cell的高度,其中需要注意的一点是label的高度自适应需要增加一句代码:  self.testLabel.preferredMaxLayoutWidth = [UIScreen 做好xib约束,用此库计算cell的高度,其中需要注意的一点是label的高度自适应需要增加一句代码:  self.testLabel.preferredMaxLayoutWidth = [UIScreen 代码:  self.testLabel.preferredMaxLayoutWidth = [UIScreen ",@"做好xib约束,用此库计算cell的高度,其中需要注意的一点是label的高度自适应需要增加一句代码:  self.testLabel.preferredMaxLayoutWidth = [UIScreen 做好xib约束,用此库计算cell的高度,其中需要注意的一点是label的高度自适应需要增加一句代码:  self.testLabel.preferredMaxLayoutWidth = [UIScreen 做好xib约束,用此库计算cell的高度,其中需要注意的一点是label的高度自适应需要增加一句代码:  self.testLabel.preferredMaxLayoutWidth = [UIScreen ",@"做好xib约束,用此库计算cell的高度,其中需要注意的一点是label的高度自适应需要增加一句代码:  self.testLabel.preferredMaxLayoutWidth = [UIScreen 做好xib约束,用此库计算cell的高度,其中需要注意的一点是label的高度自适应需要增加一句代码:  self.testLabel.preferredMaxLayoutWidth = [UIScreen ",@"经预料好，晚会直播为了保证效果，假唱也是正常的，可以接受。巴特，今年这一场，我真的震惊了，上去假唱的部分朋友，怕是我把经预料好，晚会直播为了保证效果，假唱也是正常的，可以接受。巴特，今年这一场，我真的震惊了，上去假唱的部分朋友，怕是我把经预料好，晚会直播为了保证效果，假唱也是正常的，可以接受。巴特，今年这一场，我真的震惊了，上去假唱的部分朋友，怕是我把经预料好，晚会直播为了保证效果，假唱也是正常的，可以接受。巴特，今年这一场，我真的震惊了，上去假唱的部分朋友，怕是我把",@"经预料好，晚会直播为了保证效果，假唱也是正常的，可以接受。巴特，今年这一场，我真的震惊了，上去假唱的部分朋友，怕是我把经预料好，晚会直播为了保证效果，假唱也是正常的，可以接受。巴特，今年这一场，我真的震惊了，上去假唱的部分朋友，怕是我把经预料好，晚会直播为了保证效果，假唱也是正常的，可以接受。巴特，今年这一场，我真的震惊了，上去假唱的部分朋友，怕是我把经预料好，晚会直播为了保证效果，假唱也是正常的，可以接受。巴特，今年这一场，我真的震惊了，上去假唱的部分朋友，怕是我把经预料好，晚会直播为了保证效果，假唱也是正常的，可以接受。巴特，今年这一场，我真的震惊了，上去假唱的部分朋友，怕是我把经预料好，晚会直播为了保证效果，假唱也是正常的，可以接受。巴特，今年这一场，我真的震惊了，上去假唱的部分朋友，怕是我把经预料好，晚会直播为了保证效果，假唱也是正常的，可以接受。巴特，今年这一场，我真的震惊了，上去假唱的部分朋友，怕是我把经预料好，晚会直播为了保证效果，假唱也是正常的，可以接受。巴特，今年这一场，我真的震惊了，上去假唱的部分朋友，怕是我把经预料好，晚会直播为了保证效果，假唱也是正常的，可以接受。巴特，今年这一场，我真的震惊了，上去假唱的部分朋友，怕是我把经预料好，晚会直播为了保证效果，假唱也是正常的，可以接受。巴特，今年这一场，我真的震惊了，上去假唱的部分朋友，怕是我把",@"经预料好，晚会直播为了保证效果，假唱也是正常的，可以接受。巴特，今年这一场，我真的震惊了，上去假唱的部分朋友，怕是我把经预料好，晚会直播为了保证效果，假唱也是正常的，可以接受。巴特，今年这一场，我真的震惊了，上去假唱的部分朋友，怕是我把经预料好，晚会直播为了保证效果，假唱也是正常的，可以接受。巴特，今年这一场，我真的震惊了，上去假唱的部分朋友，怕是我把经预料好，晚会直播为了保证效果，假唱也是正常的，可以接受。巴特，今年这一场，我真的震惊了，上去假唱的部分朋友，怕是我把经预料好，晚会直播为了保证效果，假唱也是正常的，可以接受。巴特，今年这一场，我真的震惊了，上去假唱的部分朋友，怕是我把经预料好，晚会直播为了保证效果，假唱也是正常的，可以接受。巴特，今年这一场，我真的震惊了，上去假唱的部分朋友，怕是我把经预料好，晚会直播为了保证效果，假唱也是正常的，可以接受。巴特，今年这一场，我真的震惊了，上去假唱的部分朋友，怕是我把经预料好，晚会直播为了保证效果，假唱也是正常的，可以接受。巴特，今年这一场，我真的震惊了，上去假唱的部分朋友，怕是我把经预料好，晚会直播为了保证效果，假唱也是正常的，可以接受。巴特，今年这一场，我真的震惊了，上去假唱的部分朋友，怕是我把"] mutableCopy];
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
    }
    return _myTableView;
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
