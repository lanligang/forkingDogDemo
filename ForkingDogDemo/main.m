//
//  main.m
//  ForkingDogDemo
//
//  Created by ios2 on 2018/1/3.
//  Copyright © 2018年 石家庄光耀. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int run(int argc,char * argv[]){
	int k = 0;
	@autoreleasepool {
		k = UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
	}
	k = run(argc, argv);
	return k;
}

int main(int argc, char * argv[]) {

	return  run(argc, argv);
}


