//
//  SnapeViewController.m
//  ForkingDogDemo
//
//  Created by ios2 on 2018/11/30.
//  Copyright © 2018 LenSky. All rights reserved.
//

#import "SnapeViewController.h"
#import <SceneKit/SceneKit.h>
#import "MySCNScene.h"
#import <Masonry.h>
#import "RequestBaseTool.h"
#import "SVHUDMacro.h"
#import "LgPageControlViewController.h"
#import "UINavigationController+circleDismiss.h"

@interface SnapeViewController ()<LgPageControlDelegate>{
	LgPageControlViewController *_pageVc;
	LgPageView *_pageView;

}
@property (nonatomic,strong)NSMutableArray *zongyeshus;

@property (nonatomic,strong)NSMutableArray *dataSource;

@property (nonatomic,strong)NSMutableArray *jokeIds;

@end

@implementation SnapeViewController

-(void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	[self.navigationController configerAlpha:1.0f];
	[self.navigationController configerColor:[[UIColor orangeColor]colorWithAlphaComponent:1.0f]];
	[self.navigationController.navigationBar setTranslucent:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];

	self.navigationItem.title = @"笑话大全";
	NSString *urlStr = @"http://khd.funnypicsbox.com/jokes/lanmu.json";
	SV_NOHIDDEN
	[RequestBaseTool getUrlStr:urlStr andParms:nil andCompletion:^(id obj) {
		if (obj && [obj isKindOfClass:[NSArray class]]) {
			NSArray *array = (NSArray *)obj;
				//leibie
			for (int i = 0; i<array.count; i++) {
				NSDictionary *dic = array[i];
				[self.dataSource addObject:dic[@"leibie"]];
				[self.jokeIds addObject:[NSString stringWithFormat:@"%@",dic[@"leibieid"]]];
				[self.zongyeshus addObject:[NSString stringWithFormat:@"%@",dic[@"zongyeshu"]]];
			}
			//刷新表数据
			[_pageVc reloadData];
			SV_Dismiss
		}
	} Error:^(NSError *errror) {

	}];

CGFloat topY =	CGRectGetHeight([UIApplication sharedApplication].statusBarFrame) + CGRectGetHeight(self.navigationController.navigationBar.frame);

	LgPageView *pageView =[[LgPageView alloc]initWithFrame:CGRectMake(0, topY, CGRectGetWidth(self.view.frame), 40.0f)
											  andTitleFont:[UIFont systemFontOfSize:18.0f]
										   andSeletedColor:[UIColor redColor]
											andNormalColor:[UIColor lightGrayColor]
											  andLineColor:[UIColor redColor]
											 andLineHeight:3.0f];
	_pageView = pageView;
	[self.view addSubview:pageView];

	LgPageControlViewController *pageVc = [[LgPageControlViewController alloc]initWithTitleView:pageView andDelegateVc:self];
	pageVc.canClearSubVcCache = YES;
	pageVc.minClearCount = 2;
	_pageVc = pageVc;
	pageVc.view.frame = CGRectMake(0,
								   CGRectGetMaxY(pageView.frame),
								   CGRectGetWidth(self.view.frame),
								   CGRectGetHeight(self.view.frame)- CGRectGetMaxY(pageView.frame));
}
-(void)viewWillLayoutSubviews
{
	[super viewWillLayoutSubviews];\
	CGFloat topY =	CGRectGetHeight([UIApplication sharedApplication].statusBarFrame) + CGRectGetHeight(self.navigationController.navigationBar.frame);
	_pageView.frame = CGRectMake(0, topY, CGRectGetWidth(self.view.frame), 40.0f);
	_pageVc.view.frame = CGRectMake(0,
								   CGRectGetMaxY(_pageView.frame),
								   CGRectGetWidth(self.view.frame),
								   CGRectGetHeight(self.view.frame)- CGRectGetMaxY(_pageView.frame));
}
-(UIBezierPath *)getBezierPath
{
	UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, 10, 10)];
	return path;
}

#pragma mark  按钮点击
-(void)changeCountClicked:(UIButton *)btn
{
	btn.selected = !btn.selected;
	if (btn.selected) {
		[self.dataSource addObjectsFromArray:@[@"朴实无华",@"礼仪文化"]];
	}else{
		[self.dataSource addObjectsFromArray:@[@"搞笑达人",@"二次元市场"]];
	}
	[_pageVc addPageNumber];
}

#pragma mark LgPageControlDelegate

-(NSInteger)lgPageControl:(LgPageControlViewController *)pageController
{
	return self.dataSource.count;
}
-(UIViewController *)lgPageControl:(LgPageControlViewController *)pageController withIndex:(NSInteger)index
{
	UIViewController *vc = nil;
	[self vcWithIndex:index andVc:&vc];
	return vc;
}

-(void)vcWithIndex:(NSInteger)index andVc:(UIViewController **)vc
{
	*vc = ({
		id aVc =  (UIViewController *)[[NSClassFromString(@"JokeViewController") alloc]init];
		[aVc setValue:self.jokeIds[index] forKey:@"jokeId"];
		[aVc setValue:self.zongyeshus[index] forKey:@"maxPage"];
		aVc;
	});
}

-(NSArray *)lgPageTitlesWithLgPageView:(LgPageView *)pageView
{
	return self.dataSource;
}

-(NSMutableArray *)dataSource
{
	if (!_dataSource)
	 {
		_dataSource = [[NSMutableArray alloc]init];
	 }
	return _dataSource;
}
-(NSMutableArray *)zongyeshus
{
	if (!_zongyeshus)
	 {
		_zongyeshus = [[NSMutableArray alloc]init];
	 }
	return _zongyeshus;
}


-(NSMutableArray *)jokeIds
{
	if (!_jokeIds)
	 {
		_jokeIds = [[NSMutableArray alloc]init];
	 }
	return _jokeIds;
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
/*
 return;
 UIView *bgView = [UIView new];
 [self.view addSubview:bgView];
 bgView.backgroundColor = [UIColor redColor];
 UIImageView *imgV = [UIImageView new];
 imgV.backgroundColor = [UIColor blueColor];
 [bgView addSubview:imgV];

 [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
 make.centerY.mas_equalTo(0);
 make.left.mas_equalTo(0);
 make.size.mas_equalTo((CGSize){20,20});
 }];

 UILabel *lable = [UILabel new];
 lable.textColor = [UIColor yellowColor];
 lable.text = @"fsdkfjdksfjdksfjk积分看电视剧反馈到健身房";
 [bgView addSubview:lable];

 CGFloat width = 	[lable sizeThatFits:CGSizeMake(CGRectGetWidth(self.view.frame), 10)].width;

 [lable mas_makeConstraints:^(MASConstraintMaker *make) {
 make.centerY.mas_equalTo(0);
 make.right.mas_equalTo(0);
 make.left.equalTo(imgV.mas_right).offset(5);
 make.size.mas_equalTo((CGSize){width,20});
 }];


 [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
 make.left.equalTo(imgV.mas_left);
 make.right.equalTo(lable.mas_right);
 make.height.mas_equalTo(20.0f);
 make.top.mas_equalTo(100);
 make.centerX.mas_equalTo(0);
 }];

 return;
 //创建SCNView
 SCNView *svnV = [[SCNView alloc]initWithFrame:self.view.bounds];
 svnV.allowsCameraControl = YES;
 svnV.showsStatistics = YES;
 svnV.autoenablesDefaultLighting = YES;
 [self.view addSubview:svnV];
 MySCNScene *sCNScene = [MySCNScene scene];
 svnV.scene = sCNScene;
 //设置背景图片
 sCNScene.background.contents =[UIImage imageNamed:@"001"];

 SCNShape *customShape = [SCNShape shapeWithPath:[self getBezierPath] extrusionDepth:4];
 SCNNode *shapeNode = [SCNNode nodeWithGeometry:customShape];

 SCNCamera *camera = [SCNCamera camera];
 if (@available(iOS 11.0, *)) {
 camera.fieldOfView = - M_PI_4;
 camera.focalLength = 5 ;
 } else {
 camera.xFov = 20;
 camera.yFov = 40;
 }
 camera.zNear = 1; // 相机能照到的最近距离，默认1m
 camera.zFar = 60; //相机能照到的最远的距离，默认100m

 SCNNode *camaraNode = [SCNNode node];

 camaraNode.camera = camera;
 //	shapeNode.transform=SCNMatrix4FromGLKMatrix4(GLKMatrix4Invert(GLKMatrix4MakeLookAt(5, 5, 10, 0, 0, 0, 0, 1, 0), nil));

 shapeNode.position =  SCNVector3Make(0,0, -10);
 camaraNode.transform = SCNMatrix4MakeTranslation(10, 10, 20);
 camaraNode.position = SCNVector3Make(0,0, 8);

 [svnV.scene.rootNode addChildNode:shapeNode];
 [svnV.scene.rootNode addChildNode:camaraNode];
 */
