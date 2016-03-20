//
//  AppDelegate.m
//  HYPWeiBo
//
//  Created by 郝一鹏 on 16/2/27.
//  Copyright © 2016年 bupt. All rights reserved.
//

#import "AppDelegate.h"
#import "HYPTabBarViewController.h"
#import "HYPNewFeatureViewController.h"
#import "LogInViewController.h"
#import "HYPAccount.h"
#import "HYPAccountTool.h"
#import "HYPControllerTool.h"

@interface AppDelegate ()


@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    

    [self.window makeKeyAndVisible];
    
    HYPAccount *account = [HYPAccountTool account];
    
    if (account) {
        [HYPControllerTool chooseRootViewController];
        
    }else{
        if ([account.date compare:[NSDate date]]!= NSOrderedAscending) {
            [HYPControllerTool chooseRootViewController];
        }
        
        self.window.rootViewController = [[LogInViewController alloc] init];
    }
 

    
    return YES;
}


@end
