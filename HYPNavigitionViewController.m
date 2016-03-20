//
//  HYPNavigitionViewController.m
//  HYPWeiBo
//
//  Created by 郝一鹏 on 16/3/3.
//  Copyright © 2016年 bupt. All rights reserved.
//

#import "HYPNavigitionViewController.h"
#import "UIBarButtonItem+HYP.h"

@interface HYPNavigitionViewController ()

@end

@implementation HYPNavigitionViewController

+(void)initialize{
    UIBarButtonItem *appearance = [UIBarButtonItem appearance];
    
    //设置普通状态字体的颜色和大小
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:16];
    [appearance setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    //设置高亮状态字体的颜色和大小
    NSMutableDictionary *highlightedTextAttrs = [NSMutableDictionary dictionary];
    highlightedTextAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    highlightedTextAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:16];
    [appearance setTitleTextAttributes:highlightedTextAttrs forState:UIControlStateHighlighted];
    
    //设置不可用状态自已的颜色和大小
    NSMutableDictionary *disableTextAttrs = [NSMutableDictionary dictionary];
    disableTextAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    disableTextAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:16];
    [appearance setTitleTextAttributes:disableTextAttrs forState:UIControlStateDisabled];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if ([self.viewControllers count] > 0) {
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"navigationbar_back" highImageName:@"navigationbar_back_highlighted" target:viewController action:nil];
        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImageName:@"navigationbar_more" highImageName:@"navigationbar_more_highlighted" target:viewController action:nil];
    }
    [super pushViewController:viewController animated:YES];
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
