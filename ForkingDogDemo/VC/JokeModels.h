//
//  JokeModels.h
//  ForkingDogDemo
//
//  Created by ios2 on 2018/12/18.
//  Copyright © 2018 LenSky. All rights reserved.
//

#import "FCBaseModel.h"

NS_ASSUME_NONNULL_BEGIN
@interface JokeModel : FCBaseModel
@property (nonatomic,strong)NSString *biaoti;
@property (nonatomic,strong)NSString *dianjishu;
@property (nonatomic,strong)NSString *riqi;
@property (nonatomic,strong)NSString *leibie;
@property (nonatomic,strong)NSString *leibie_en;
@property (nonatomic,strong)NSString *leibieid;
@property (nonatomic,strong)NSString *pinglun;
@property (nonatomic,strong)NSString *xihuan;
@property (nonatomic,strong)NSString *neirong;
@property (nonatomic,strong)NSString *zuozhe;
@property (nonatomic,strong)NSString *shenhuifuzuozhe;
@property (nonatomic,strong)NSString *shenhuifuneirong;
@property (nonatomic,strong)NSString *shenhuifuid;
@property (nonatomic,strong)NSString *Id;
@property (nonatomic,assign)NSInteger num1;
@property (nonatomic,assign)double num2;
@property (nonatomic,assign)int num3;
@property (nonatomic,assign)CGFloat num4;
@property (nonatomic,assign)float num5;
@property (nonatomic,assign)char * char6;
@property (nonatomic,strong)JokeModel *array;

@end

@interface JokeModels : FCBaseModel

@property (nonatomic,strong)NSArray <JokeModel *> *jsokes;

@end

NS_ASSUME_NONNULL_END
