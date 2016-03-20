//
//  HYPControllerTool.m
//  HYPWeiBo
//
//  Created by 郝一鹏 on 16/3/14.
//  Copyright © 2016年 bupt. All rights reserved.
//

#import "HYPControllerTool.h"
#import "HYPTabBarViewController.h"
#import "HYPNavigitionViewController.h"
#import "HYPNewFeatureViewController.h"

@implementation HYPControllerTool

+ (void)chooseRootViewController{
    NSString *versionKey = @"CFBundleVersion";
    
    
    //  从沙盒中取出上一个版本号
    NSUserDefaults * defaults =  [NSUserDefaults standardUserDefaults];
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:versionKey];
    
    //  从Bundle中 取出当前的版本号
    NSDictionary *info = [[NSBundle mainBundle] infoDictionary];
    NSString *currentVersion = [info objectForKey:versionKey];
    
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    
    
    if (![lastVersion isEqualToString:currentVersion]) {//  如果两个版本号不相同，显示新特性控制器，并将新的版本号存储起来
        HYPNewFeatureViewController *newFeatureVC = [[HYPNewFeatureViewController alloc] init];
        window.rootViewController = newFeatureVC;
        [defaults setObject:currentVersion forKey:versionKey];
        //  一定要写这句，写了之后就马上存储到plist里了，不写的话是随机存储的
        [defaults synchronize];
        
    }else{//  如果版本号相同直接显示tabbarcontroller
        HYPTabBarViewController *tabVC = [[HYPTabBarViewController alloc] init];
        window.rootViewController = tabVC;
    }

}

@end
