//
//  SVHUDMacro.h
//  ForkingDogDemo
//
//  Created by ios2 on 2018/12/18.
//  Copyright © 2018 LenSky. All rights reserved.
//

#ifndef SVHUDMacro_h
#define SVHUDMacro_h
#if __OBJC__
#import <SVProgressHUD.h>

#define SV_SET \
[SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];\
[SVProgressHUD setFont:[UIFont systemFontOfSize:14.0f]];\
[SVProgressHUD setForegroundColor:[UIColor redColor]];\


#define SV_SHOW \
[SVProgressHUD show];\

#define SV_Dismiss \
[SVProgressHUD dismiss];\

#define SV_DismissLate(s) \
[SVProgressHUD dismissWithDelay:s];\


#define SV_Normal (s)\
SV_SET;\
SV_SHOW;\
SV_DismissLate(s);\

#define SV_NOHIDDEN \
SV_SET;\
SV_SHOW;\


#endif

#endif /* SVHUDMacro_h */
