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

#import "LgPageControlViewController.h"

@interface SnapeViewController ()<LgPageControlDelegate>{
	LgPageControlViewController *_pageVc;
}
@property (nonatomic,strong)NSMutableArray *dataSource;
@end

@implementation SnapeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

	[self.dataSource addObjectsFromArray:@[@"推荐",@"影视类",@"有好货",@"清新派",@"第六空间",@"魅力异族"]];
	[self.navigationController.navigationBar setTranslucent:NO];

		//CGFloat topY =  CGRectGetHeight([UIApplication sharedApplication].statusBarFrame);

	LgPageView *pageView =[[LgPageView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame) - 30, 40.0f)
											  andTitleFont:[UIFont systemFontOfSize:18.0f]
										   andSeletedColor:[UIColor redColor]
											andNormalColor:[UIColor lightGrayColor]
											  andLineColor:[UIColor redColor]
											 andLineHeight:3.0f];

	[self.view addSubview:pageView];

	LgPageControlViewController *pageVc = [[LgPageControlViewController alloc]initWithTitleView:pageView andDelegateVc:self];
	pageVc.canClearSubVcCache = YES;
	pageVc.minClearCount = 2;
	_pageVc = pageVc;
	pageVc.view.frame = CGRectMake(0,
								   CGRectGetMaxY(pageView.frame),
								   CGRectGetWidth(self.view.frame),
								   CGRectGetHeight(self.view.frame)- CGRectGetMaxY(pageView.frame));

	UIButton *changeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
	[changeBtn setTitle:@"加" forState:UIControlStateNormal];
	[changeBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
	changeBtn.bounds = CGRectMake(0, 0, 30, 30);
	changeBtn.center = (CGPoint){CGRectGetMaxX(pageView.frame) + 15.0f, pageView.center.y};
	[changeBtn addTarget:self action:@selector(changeCountClicked:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:changeBtn];


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
	NSString *aclassNames[2] = {@"ADViewController",@"ViewController"};
	NSInteger vcIndex = index%2;
	NSString *className = aclassNames[vcIndex];
	UIViewController *vc = [[NSClassFromString(className) alloc]init];
	return vc;
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




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
