//
//  MyScene.m
//  ForkingDogDemo
//
//  Created by ios2 on 2018/9/3.
//  Copyright © 2018年 LenSky. All rights reserved.
//

#import "MyScene.h"

@implementation MyScene

#pragma mark 添加背景
-(void)addBackground
{
	SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"bgImg"];
	//设置为背景
	background.name = @"bg";
	background.size = CGSizeMake(self.size.width, self.size.height);
	//设置中心点类似layer 的设置
	background.position =(CGPoint){background.size.width/2.0f,background.size.height/2.0f};
	//添加子背景
	[self addChild:background];

}

/*
 这里要涉及到SKAction，简单介绍一下，因为游戏的大部分动作行为都是它来实现的。
 SKAction可以实现的动作有很多，列举几个常用的
 1、相对位移或绝对位移
 2、旋转到指定角度或旋转指定角度
 3、改变尺寸或缩放
 4、隐藏、显示、渐隐、渐现、指定透明度
 5、添加一个或一系列纹理图片
 6、加减速、等待
 7、播放简单的声音等等
 以上是单个动作的SKAction，同样可以通过下面两个函数将多个单一动作整合成复合动作SKAction
 + (SKAction *)sequence:(NSArray *)actions;
 + (SKAction *)group:(NSArray *)actions；
 入参是N多个Action，sequence:函数是串行的来执行数组中的所有Action，group:函数是并行的来执行。通过以上这些我们就可以做各种复杂的动画了。
 */


-(void)addActionAnimation
{
	NSMutableArray *tmpArray = [NSMutableArray array];
	//Texture 纹理
	SKTexture *texture0  = 	[SKTexture textureWithImageNamed:@"001"];
	SKTexture *texture1  = 	[SKTexture textureWithImageNamed:@"002"];
	SKTexture *texture2  = 	[SKTexture textureWithImageNamed:@"003"];
	[tmpArray addObject:texture0];
	[tmpArray addObject:texture1];
	[tmpArray addObject:texture2];
	SKAction *animation = [SKAction animateWithTextures:tmpArray timePerFrame:0.15];
	//这个根据name 查找 Node
	SKSpriteNode *background =  (SKSpriteNode *)[self childNodeWithName:@"bg"];

	/*
	 SKAction的animateWithTextures:timePerFrame:函数可以将一组图片按指定的时间间隔像GIF图片一样展示，类似于UIImageView中的animationImages。

	 SKAction的repeatActionForever:函数将GIF的动作无限循环，做成复合动画。精灵通过运行runAction:函数调用它就可以实现仙人掌呼吸动画了。
	 */

	[background runAction:animation]; //只是运行一遍

//	[background runAction:[SKAction repeatActionForever:animation]]; //一直运行GIF动画模式

	//带有回调的
	/*
	[background runAction:animation completion:^{
		NSLog(@"运行结束");
	}];
	 */

}
#pragma mark 点击的方法
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
	for (UITouch *touch in touches) {
		CGPoint touchLocation = [touch locationInNode:self];
		SKNode *node = [self nodeAtPoint:touchLocation];
		if ([node.name isEqualToString:@"xxx"]) {
			//判断点到了那个上 并且还没有进行动画
			[node removeFromParent];
		}
	}
}

- (void)carrotAnimation {
	//让精灵 按照固定的路径行走
	SKSpriteNode *wheel0 = [SKSpriteNode spriteNodeWithImageNamed:@"04"];
	wheel0.position = CGPointMake(self.size.width/2.0f, self.size.height/2.0f);
	[self addChild:wheel0];
	wheel0.name = @"xxx";
	CGMutablePathRef pathRef = CGPathCreateMutable();
     NSInteger x = 	arc4random()%(NSInteger)(self.size.width/1);
	NSInteger x2 = 	arc4random()%(NSInteger)(self.size.width/1);
	NSInteger endX = arc4random()%(NSInteger)(self.size.width/1);
	CGPathMoveToPoint(pathRef, nil, x, self.size.height);
	CGPathAddLineToPoint(pathRef, nil, x2, self.size.height/2);
	CGPathAddLineToPoint(pathRef, nil, endX, 0);
	SKAction *moveAction = [SKAction followPath:pathRef asOffset:NO orientToPath:NO duration:10];
	SKAction *rotationAction0 = [SKAction rotateByAngle:4*M_PI duration:0.4];

	SKAction *groupAction0 = [SKAction group:@[moveAction]];
	[wheel0 runAction:groupAction0 completion:^{
		[wheel0 removeFromParent];
	}];
	//一直运行旋转
	[wheel0 runAction:[SKAction repeatActionForever:rotationAction0]];
	return;
//旋转动画实现
	SKSpriteNode *wheel = [SKSpriteNode spriteNodeWithImageNamed:@"04"];
	wheel.position = CGPointMake(self.size.width/2.0f, self.size.height/2.0f);
	[self addChild:wheel];
	SKAction *rotationAction = [SKAction rotateByAngle:4*M_PI duration:0.4];
	[wheel runAction:rotationAction completion:^{
		[wheel removeFromParent];
	}];
	//注意释放
	CGPathRelease(pathRef);
	return;
	// 播放一组图片
	NSArray *array = @[[SKTexture textureWithImageNamed:@"luobo2"],
						   [SKTexture textureWithImageNamed:@"luobo3"],
						   [SKTexture textureWithImageNamed:@"luobo4"],
						   [SKTexture textureWithImageNamed:@"luobo5"],
						   [SKTexture textureWithImageNamed:@"luobo6"],
						   [SKTexture textureWithImageNamed:@"luobo7"],
						   [SKTexture textureWithImageNamed:@"luobo8"],
						   [SKTexture textureWithImageNamed:@"luobo9"],
						   [SKTexture textureWithImageNamed:@"luobo1"]];
	SKAction *animation = [SKAction animateWithTextures:array timePerFrame:0.05 resize:YES restore:NO];
		// 随机播放一个声音
	int random = arc4random();
	NSString *str = @"carrot1.mp3";
	if (random % 3 == 1) { str = @"carrot2.mp3"; }
	else if (random % 3 == 2) { str = @"carrot3.mp3"; }
	SKAction *soundAction = [SKAction playSoundFileNamed:str waitForCompletion:NO];
	SKAction *groupAction = [SKAction group:@[animation, soundAction]];
	SKSpriteNode *background =  (SKSpriteNode *)[self childNodeWithName:@"bg"];
	[background runAction:groupAction];

}

-(id)initWithSize:(CGSize)size
{
	if (self==[super initWithSize:size]) {
		self.backgroundColor = [SKColor whiteColor];
		[self addBackground];
		[self addActionAnimation];
	}
	return self;
}



@end
