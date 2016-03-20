//
//  HYPTabBarViewController.m
//  HYPWeiBo
//
//  Created by 郝一鹏 on 16/3/6.
//  Copyright © 2016年 bupt. All rights reserved.
//

#import "HYPTabBarViewController.h"
#import "HYPNavigitionViewController.h"
#import "HYPHomeViewController.h"
#import "HYPMessageViewController.h"
#import "HYPDiscoverViewController.h"
#import "HYPProfileViewController.h"
#import "HYPTabBar.h"
#import "ComposeViewController.h"


@interface HYPTabBarViewController () <HYPTabBarDelegate>

@end

@implementation HYPTabBarViewController

+ (void)initialize{
    
    NSLog(@"tab````````````");
    UITabBarItem *appearance = [UITabBarItem appearance];
    
    //设置普通状态字体的颜色和大小
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    [appearance setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    //设置高亮状态字体的颜色和大小
    NSMutableDictionary *highlightedTextAttrs = [NSMutableDictionary dictionary];
    highlightedTextAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    highlightedTextAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    [appearance setTitleTextAttributes:highlightedTextAttrs forState:UIControlStateSelected];
    
    //设置不可用状态自已的颜色和大小
    NSMutableDictionary *disableTextAttrs = [NSMutableDictionary dictionary];
    disableTextAttrs[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    disableTextAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    [appearance setTitleTextAttributes:disableTextAttrs forState:UIControlStateDisabled];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    HYPTabBar *myTabBar = [[HYPTabBar alloc] init];
    myTabBar.tabBarDelegate = self;
    [self setValue:myTabBar forKey:@"tabBar"];
    
    //加载home控制器
    HYPHomeViewController *homeVC = [[HYPHomeViewController alloc] init];
    
    [self addChildViewController:homeVC withImage:@"tabbar_home" heightImage:@"tabbar_home_selected" title:@"首页"];
    
    //加载消息控制器
    HYPMessageViewController *messageVC = [[HYPMessageViewController alloc] init];
    [self addChildViewController:messageVC withImage:@"tabbar_message_center" heightImage:@"tabbar_message_center_selected" title:@"消息"];
    
    
    //加载发现控制器
    HYPDiscoverViewController *discoverVC = [[HYPDiscoverViewController alloc] init];
    [self addChildViewController:discoverVC withImage:@"tabbar_discover" heightImage:@"tabbar_discover_selected" title:@"发现"];
    
    //加载我控制器
    HYPProfileViewController *profileVC = [[HYPProfileViewController alloc] init];
    [self addChildViewController:profileVC withImage:@"tabbar_profile" heightImage:@"tabbar_profile_selected" title:@"我"];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"!!!!!%@",self.tabBar.items);
}


- (void)addChildViewController:(UIViewController *)childController withImage:(NSString *)image heightImage:(NSString *)heightImage title:(NSString *)title{
    childController.tabBarItem.image = [UIImage imageNamed:image];
    UIImage *selectedImage = [UIImage imageNamed:heightImage];
    selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childController.tabBarItem.selectedImage = selectedImage ;
    childController.title = title;
    HYPNavigitionViewController *nav = [[HYPNavigitionViewController alloc] initWithRootViewController:childController];
    [self addChildViewController:nav];
}


#pragma mark tabBarDelegate方法

- (void)tabBarDidClickAddButton:(UITabBar *)tabBar{
    
    ComposeViewController *composeVC = [[ComposeViewController alloc] init];
    composeVC.view.backgroundColor = [UIColor whiteColor];
    HYPNavigitionViewController *naviComposeVC = [[HYPNavigitionViewController alloc] initWithRootViewController:composeVC];
    [self presentViewController:naviComposeVC animated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
