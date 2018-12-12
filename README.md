### 删除原有的fd高度计算，使用系统的预估高度来进行计算，并加入缓存


简书地址  https://www.jianshu.com/p/67b0e83d2d71

![ForkingDogDemo](forkingDogDemo.gif)

*  第一步 使用下面 缓存高度代码 

* 第二步  在cell内部 设置从上到下 完美约束就可以 

> 你有你的自由，我有我的快乐！开心最重要！

> 是情是爱 是缘分，愿你的代码溜到飞起来

```
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//如果想要预估区头和区尾同样的方法
NSString *key = [NSString stringWithFormat:@"%@_%ld",indexPath,(long)tableView.tag];
NSNumber * heightNum = self.autoHeightCache[key];
if(heightNum)return heightNum.floatValue;
return 44.0f;
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
NSString *key = [NSString stringWithFormat:@"%@_%ld",indexPath,(long)tableView.tag];
CGFloat height =  CGRectGetHeight(cell.frame);
self.autoHeightCache[key] = @(height);
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
return UITableViewAutomaticDimension;
}
```
* 策滑自己试着写的 使用方法

* isScale 是否缩放
* MAXOPEN_LEFT  控制滑开的最大宽度
> LgMenuMacro.h 文件中的  MAXOPEN_LEFT 控制滑开的最大宽度
 #define MAXOPEN_LEFT [UIScreen mainScreen].bounds.size.width*4/6.0f
 
 *  增加缩放参数  scaleValue
 ```
 /* 缩放的比例 减少的缩放比例 必须设置 isScale 有效
 * scaleValue 默认为 0.3
 * 0.0 ~ 1.0
 */
 @property (nonatomic,assign)CGFloat scaleValue;
```

```
 LeftViewController *leftVc = [[LeftViewController alloc]init];

   LgTabBarViewController *tabarVc = [[LgTabBarViewController alloc]init];
	
   LgMenuViewController *menuVc = [[LgMenuViewController alloc]initWithLeftViewController:leftVc andMainViewController:tabarVc];
	//是否缩放 ------ 可以设置侧滑时候是否错放参数
   menuVc.isScale = YES;
   menuVc.scaleValue = 0.5f;
  self.window.rootViewController = menuVc;
```
### 在其他控制器中主动打开和关闭
```
-(void)openLgMenu;
-(void)closeLgMenu;
```
*  重新整理了一下代码中的各个文件夹

![新加的cell](ad.gif)

|下拉刷新修改过的文件名|-----|-------|
|--- |--- |--- |
||||

*  考试要考的哦 ！
> QQ 1176281703  QQ群 637387838



![图片来自官方](https://github.com/airbnb/lottie-ios/raw/master/_Gifs/Examples2.gif)
地址：https://github.com/airbnb/lottie-ios
素材下载地址：https://www.lottiefiles.com/
下载下来是 json 文件
oc 语言使用 pod 安装 
pod 'lottie-ios'
pod  install 命令 完成后
导入头文件
```
#import <lottie-ios/Lottie/LOTAnimationView.h>
LOTAnimationView *animation = [LOTAnimationView animationNamed:@"ripple"];
animation.backgroundColor = [UIColor redColor];
animation.frame = CGRectMake(0, 100, 300, 300);
[self.view addSubview:animation];

//执行动画有两种方式 
#mark 第一种 全部执行完
[animation playWithCompletion:^(BOOL animationFinished) {
// Do Something
}];
# mark 也可以直接设置动画进度
animation.animationProgress = progress;
# mark 还可以使用 
[animation playFromProgress:0.25 toProgress:0.5 withCompletion:^(BOOL animationFinished) {
// Do Something
}];

# mark 从官方摘抄代码
// ===========  还可以自定义present 动画  ======= 

ToAnimationViewController *vc = [[ToAnimationViewController alloc] init];
vc.transitioningDelegate = self;
[self presentViewController:vc animated:YES completion:NULL];
#pragma mark -- View Controller Transitioning

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
LOTAnimationTransitionController *animationController = [[LOTAnimationTransitionController alloc] initWithAnimationNamed:@"vcTransition1" fromLayerNamed:@"outLayer" toLayerNamed:@"inLayer" applyAnimationTransform:NO];
return animationController;
}
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
LOTAnimationTransitionController *animationController = [[LOTAnimationTransitionController alloc] initWithAnimationNamed:@"vcTransition2" fromLayerNamed:@"outLayer" toLayerNamed:@"inLayer" applyAnimationTransform:NO];
return animationController;
}

```
![效果图](https://github.com/airbnb/lottie-ios/raw/master/_Gifs/transitionMasked.gif)
![效果图](https://github.com/airbnb/lottie-ios/raw/master/_Gifs/transitionPosition.gif)

