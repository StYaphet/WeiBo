//
//  HYPTabBar.h
//  HYPWeiBo
//
//  Created by 郝一鹏 on 16/3/10.
//  Copyright © 2016年 bupt. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HYPTabBar;

@protocol HYPTabBarDelegate <NSObject>

@optional

- (void)tabBarDidClickAddButton:(UITabBar *)tabBar;

@end

@interface HYPTabBar : UITabBar

@property (nonatomic,weak) id <HYPTabBarDelegate> tabBarDelegate;

@end
