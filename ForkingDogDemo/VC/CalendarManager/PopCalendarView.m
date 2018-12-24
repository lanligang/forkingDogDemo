//
//  PopCalendarView.m
//  ForkingDogDemo
//
//  Created by ios2 on 2018/12/24.
//  Copyright © 2018 LenSky. All rights reserved.
//

#import "PopCalendarView.h"
#import <Masonry.h>
#import "LGCalendarManager.h"
#import "CalendarModel.h"
@interface PopCalendarView()
<UICollectionViewDelegate,
UICollectionViewDataSource,
UITableViewDelegate,
UITableViewDataSource>

@end

@implementation PopCalendarView {
	NSArray *_dataSource;
	NSArray *_currentMoth;
	//当前某个月的索引值
	NSInteger _currentMonthIndex;
	CalendarShowType _type;
	NSInteger _monthCount;
	UIView *_containtView;
	UITableView *_tableV;
	UICollectionView *_collectionView;
	UILabel *_titleLable;
	UIButton * _titleBtn;
}

+(instancetype)showWithType:(CalendarShowType)type andMonthCount:(NSInteger)monthCount
{

	UIWindow *window = [[UIApplication sharedApplication].delegate window];
	[window.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
		if ([obj isKindOfClass: [PopCalendarView class]]) {
			[obj removeFromSuperview];
		}
	}];

	PopCalendarView *popV = [[PopCalendarView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds))];
	[window addSubview:popV];
	[popV loadContaintViewWithType:type andMonthCount:monthCount];

	return popV;
}

-(void)loadContaintViewWithType:(CalendarShowType)type andMonthCount:(NSInteger)monthCount
{
	_type = type;
	_monthCount = monthCount;
	_containtView = (UIView *)[[UIControl alloc]init];
	_containtView.backgroundColor = [UIColor whiteColor];
	[self addSubview:_containtView];
	_containtView.layer.cornerRadius = 5.0f;
	_containtView.clipsToBounds = YES;
	self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.4f];

	CGFloat width = CGRectGetWidth(self.bounds) *0.8f;
	CGFloat itemSpace = 5;
	UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
	CGFloat itemWidth = (width - 8* itemSpace )/7;
	layout.itemSize = CGSizeMake(itemWidth, itemWidth);
	layout.minimumLineSpacing = 5;
	layout.minimumInteritemSpacing = 5;

	UICollectionView *collectionView =[[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
	[collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
	collectionView.backgroundColor = [UIColor whiteColor];
	collectionView.scrollEnabled = NO;
	collectionView.delegate = self;
	collectionView.dataSource = self;
	_collectionView = collectionView;
	[_containtView addSubview:collectionView];

	UIView *topView = [UIView new];
	[_containtView addSubview:topView];

	topView.backgroundColor = [UIColor redColor];
	[topView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.and.right.mas_equalTo(0);
		make.top.mas_equalTo(0);
		make.height.mas_equalTo(50.0f);
	}];

	UILabel *monthTitleLable = [UILabel new];
	_titleLable = monthTitleLable;
	monthTitleLable.textAlignment = NSTextAlignmentCenter;
	monthTitleLable.textColor = [UIColor whiteColor];
	monthTitleLable.font = [UIFont systemFontOfSize:14.0f];
	[topView addSubview:monthTitleLable];

	[monthTitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.and.bottom.mas_equalTo(0);
		make.left.mas_equalTo(40.0f);
		make.right.mas_equalTo(-40.0f);
	}];


	{
	   UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
	   [topView addSubview:btn];
	   _titleBtn = btn;
	   [btn addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
	   [btn mas_makeConstraints:^(MASConstraintMaker *make) {
		   make.width.mas_equalTo(width/2.0f);
		   make.top.bottom.mas_equalTo(0);
		   make.centerX.mas_equalTo(0);
	   }];
	}
	//创建一左一右的按钮
	{
	   UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
	   [btn setTitle:@"<" forState:UIControlStateNormal];
	   [topView addSubview:btn];
	   [btn addTarget:self action:@selector(leftClicked:) forControlEvents:UIControlEventTouchUpInside];
	   [btn mas_makeConstraints:^(MASConstraintMaker *make) {
		   make.width.mas_equalTo(60);
		   make.top.bottom.mas_equalTo(0);
		   make.left.mas_equalTo(0);
	   }];
	}
	// ===================================
	{
	   UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
	   [btn setTitle:@">" forState:UIControlStateNormal];
	   [topView addSubview:btn];
	   [btn addTarget:self action:@selector(rightClicked:) forControlEvents:UIControlEventTouchUpInside];
	   [btn mas_makeConstraints:^(MASConstraintMaker *make) {
		   make.right.mas_equalTo(0);
		   make.top.bottom.mas_equalTo(0);
		   make.width.mas_equalTo(60.0f);
	   }];
	}

	LGCalendarManager *dataManager = [[LGCalendarManager alloc]initWithStartDate:[[NSDate date] timeIntervalSince1970]];
	NSArray *array = [dataManager getCalendarDataSoruceWithLimitMonth:monthCount type:type];
	_dataSource  = array;

	if (type == CalendarLastType) {
		//只显示当月之前的
		CalendarHeaderModel *monthModel = (CalendarHeaderModel *)_dataSource.lastObject;
		_currentMonthIndex = _dataSource.count - 1;
		_currentMoth = monthModel.calendarItemArray;
		monthTitleLable.text = monthModel.headerText;
	}else if (type == CalendarMiddleType){
		NSInteger index = monthCount/2 + ((monthCount%2 ==0)?-1:0);
		CalendarHeaderModel *monthModel = (CalendarHeaderModel *)_dataSource[index];
		_currentMonthIndex = index;
		_currentMoth = monthModel.calendarItemArray;
		monthTitleLable.text = monthModel.headerText;
	}else if (type == CalendarNextType){
		CalendarHeaderModel *monthModel = (CalendarHeaderModel *)_dataSource.firstObject;
		_currentMonthIndex = 0;
		_currentMoth = monthModel.calendarItemArray;
		monthTitleLable.text = monthModel.headerText;
	}
	NSInteger row = _currentMoth.count /7 +((_currentMoth.count%7>0)?1:0);
	CGFloat height = row * itemWidth + (row -1)*itemSpace;

	UIView *week = [UIView new];
	week.backgroundColor = [UIColor whiteColor];
	[_containtView addSubview:week];
	[week mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(topView.mas_bottom);
		make.height.mas_equalTo(35.0f);
		make.left.and.right.mas_equalTo(0);
	}];
	NSString *titles[] = {@"日",@"一",@"二",@"三",@"四",@"五",@"六"};
	UILabel *lastLable = nil;
	for (int i = 0; i<7; i++) {
		UILabel *weekLable = [UILabel new];
		weekLable.textColor = (i == 0||i == 6)?[UIColor redColor]:[UIColor blackColor];
		weekLable.textAlignment = NSTextAlignmentCenter;
		weekLable.font = [UIFont systemFontOfSize:14.0f];
		weekLable.text =titles[i];
		[week addSubview:weekLable];
		[weekLable mas_makeConstraints:^(MASConstraintMaker *make) {
			if (!lastLable) {
				make.left.mas_equalTo(5);
			}else{
				make.left.equalTo(lastLable.mas_right).offset(itemSpace);
			}
			make.width.mas_equalTo(itemWidth);
			make.top.and.bottom.mas_equalTo(0);
		}];
		lastLable = weekLable;
	}

	[collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.mas_equalTo(week.mas_bottom).offset(2.0f);
		make.left.mas_equalTo(5);
		make.right.mas_equalTo(-5);
		make.height.mas_equalTo(height);
	}];
	CGFloat topY =	CGRectGetHeight([UIApplication sharedApplication].statusBarFrame) + CGRectGetHeight(self.bounds)/5.0f;
	[_containtView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerX.mas_equalTo(0);
		make.top.mas_equalTo(topY);
		make.width.mas_equalTo(width);
		make.bottom.equalTo(collectionView.mas_bottom).offset(10);
	}];
	[collectionView reloadData];

	UITableView *tableV = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
	[tableV registerClass:[UITableViewCell class] forCellReuseIdentifier:@"tableCell"];
	tableV.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
	tableV.delegate = self;
	tableV.dataSource = self;
	tableV.backgroundColor = [UIColor whiteColor];
	[_containtView addSubview:tableV];
	[tableV mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(topView.mas_bottom);
		make.height.mas_equalTo(0);
		make.width.mas_equalTo(width/2.0f);
		make.centerX.mas_equalTo(0);
	}];
	_tableV.hidden = YES;
	_tableV = tableV;

}

-(void)rightClicked:(UIButton *)btn
{
	_currentMonthIndex ++;
	if (_currentMonthIndex>(_dataSource.count -1)) {
		_currentMonthIndex = _dataSource.count -1;
		return;
	}
	CalendarHeaderModel *monthModel = (CalendarHeaderModel *)_dataSource[_currentMonthIndex];
	_currentMoth = monthModel.calendarItemArray;
	_titleLable.text = monthModel.headerText;
	[_collectionView reloadData];
	[_tableV reloadData];
	[self updateCollectionHeight];
}
-(void)leftClicked:(UIButton *)btn
{
	_currentMonthIndex --;
	if (_currentMonthIndex<0) {
		_currentMonthIndex = 0;
		return;
	}
	CalendarHeaderModel *monthModel = (CalendarHeaderModel *)_dataSource[_currentMonthIndex];
	_currentMoth = monthModel.calendarItemArray;
	_titleLable.text = monthModel.headerText;
	[_collectionView reloadData];
	[_tableV reloadData];
	[self updateCollectionHeight];
}

-(void)updateCollectionHeight
{
	CGFloat width = CGRectGetWidth(self.bounds) *0.8f;
	CGFloat itemSpace = 5;
	NSInteger row = _currentMoth.count /7 +((_currentMoth.count%7>0)?1:0);
	CGFloat itemWidth = (width - 8* itemSpace )/7;
	CGFloat height = row * itemWidth + (row -1)*itemSpace;
	[UIView animateWithDuration:0.2 animations:^{
		[_collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
			make.height.mas_equalTo(height);
		}];
		[_collectionView layoutIfNeeded];
	}];
	if (_titleBtn.selected) {
		[_tableV scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_currentMonthIndex inSection:0] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
	}
}

-(void)clicked:(UIButton *)btn
{
	btn.selected = !btn.selected;
	CGFloat height = 200.0f;
	if (btn.selected == NO) {
		height = 0;
	}
	[_tableV reloadData];
	[UIView animateWithDuration:0.3 animations:^{
		[_tableV mas_updateConstraints:^(MASConstraintMaker *make) {
			make.height.mas_equalTo(height);
		}];
		[_containtView layoutIfNeeded];
	}];
	if (height>0) {
		[_tableV scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_currentMonthIndex inSection:0] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
	}
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = nil;
	cell =  [tableView dequeueReusableCellWithIdentifier:@"tableCell" forIndexPath:indexPath];
	[cell setSelectionStyle:UITableViewCellSelectionStyleNone];
	UILabel *lable = [cell.contentView viewWithTag:100];
	if (!lable) {
		lable = [UILabel new];
		lable.tag = 100;
		lable.textAlignment = NSTextAlignmentCenter;
		lable.textColor = [UIColor blackColor];
		lable.font = [UIFont systemFontOfSize:13.0f];
		[cell.contentView addSubview:lable];
		[lable mas_makeConstraints:^(MASConstraintMaker *make) {
			make.centerX.mas_equalTo(0);
			make.top.and.bottom.mas_equalTo(0);
		}];
	}
	if (indexPath.row == _currentMonthIndex) {
		lable.textColor = [UIColor redColor];
	}else{
		lable.textColor = [UIColor blackColor];
	}
	CalendarHeaderModel *monthModel = _dataSource[indexPath.row];
	lable.text = monthModel.headerText;
	return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	_currentMonthIndex = indexPath.row;
	CalendarHeaderModel *monthModel = (CalendarHeaderModel *)_dataSource[indexPath.row];
	_titleLable.text = monthModel.headerText;
	_currentMoth = monthModel.calendarItemArray;
	[_collectionView reloadData];
	_titleBtn.selected = NO;
	[self updateCollectionHeight];
	[tableView mas_updateConstraints:^(MASConstraintMaker *make) {
			make.height.mas_equalTo(0);
	}];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	return CGFLOAT_MIN;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
	return CGFLOAT_MIN;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 40.0f;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	return nil;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
	return nil;
}


#pragma mark CollectionViewDelegate && dataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
	return _currentMoth.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
	UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
	UIView *v =	[cell.contentView viewWithTag:100];
	cell.backgroundColor = [UIColor whiteColor];
	UILabel *lable = (UILabel *)v;
	if (!v) {
		UILabel *titleLable = [UILabel new];
		titleLable.font = [UIFont systemFontOfSize:13.0f];
		titleLable.textAlignment = NSTextAlignmentCenter;
		titleLable.textColor = [UIColor redColor];
		titleLable.frame = cell.bounds;
		titleLable.tag = 100;
		lable = titleLable;
		[cell.contentView addSubview:titleLable];
	}
	CalendarModel *model =  _currentMoth[indexPath.row];
	lable.text = (model.day >0)?[NSString stringWithFormat:@"%ld",(long)model.day]:@"";
	lable.textColor = [UIColor blackColor];
	lable.font = [UIFont systemFontOfSize:13.0f];
	if (model.day>0) {
		lable.clipsToBounds = YES;
		lable.backgroundColor = [UIColor yellowColor];
		lable.layer.cornerRadius = CGRectGetHeight(lable.frame)/2.0f;
	}else{
		lable.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.1f];
		lable.clipsToBounds = YES;
		lable.layer.cornerRadius = CGRectGetHeight(lable.frame)/2.0f;
	}
	if (model.holiday&&model.holiday.length>0) {
		lable.backgroundColor = [UIColor blackColor];
		lable.textColor = [UIColor whiteColor];
		lable.font = [UIFont systemFontOfSize:12.0f];
		lable.text = model.holiday;
		if ([model.holiday isEqualToString:@"今天"]) {
			lable.backgroundColor = [UIColor redColor];
		}
	}
	return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
	[self dismiss];
}


-(void)dismiss
{
	[UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:10.0 options:0 animations:^{
		_containtView.transform = CGAffineTransformMakeScale(0.9, 0.9);
	} completion:nil];

	__weak typeof(self)ws = self;
	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.28 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
		[ws removeFromSuperview];
	});

}
@end
