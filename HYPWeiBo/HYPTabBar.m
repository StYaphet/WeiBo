//
//  HYPTabBar.m
//  HYPWeiBo
//
//  Created by 郝一鹏 on 16/3/10.
//  Copyright © 2016年 bupt. All rights reserved.
//

#import "HYPTabBar.h"
#import "UIView+Extension.h"

@interface HYPTabBar ()

@property (nonatomic,weak) UIButton *addButton;


@end

@implementation HYPTabBar


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //添加加号按钮，设置背景图片等
        UIButton *addButton = [[UIButton alloc] init];
        [addButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [addButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        
        [addButton setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [addButton setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        
        [addButton addTarget:self action:@selector(addClick:) forControlEvents:UIControlEventTouchUpInside];
        _addButton = addButton;
        [self addSubview:addButton];
    }
    return self;
}

- (void)addClick:(UIButton *)button{
    NSLog(@"加号被点击了哦");
    if ([self.tabBarDelegate respondsToSelector:@selector(tabBarDidClickAddButton:)]) {
        [self.tabBarDelegate tabBarDidClickAddButton:self];
    }
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    
    //改变addButton的布局
    self.addButton.size  = self.addButton.currentBackgroundImage.size;
    self.addButton.centerX = self.width / 2.0;
    self.addButton.centerY = self.height / 2.0;
    
    int index = 0;
    
    //改变标签的布局
    for (UIView *tabbarButton in self.subviews) {
        if (![tabbarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            continue;
        }else{
            if (index > 1) {
                tabbarButton.frame = CGRectMake((index + 1) * (self.bounds.size.width / 5), 0, self.bounds.size.width / 5, self.bounds.size.height);
            }else{
                tabbarButton.frame = CGRectMake(index * (self.bounds.size.width / 5), 0, self.bounds.size.width / 5, self.bounds.size.height);
            }
        }
        index ++;
    }
}

@end
