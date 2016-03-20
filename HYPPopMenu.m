//
//  HYPPopMenu.m
//  HYPWeiBo
//
//  Created by 郝一鹏 on 16/3/10.
//  Copyright © 2016年 bupt. All rights reserved.
//

#import "HYPPopMenu.h"

@interface HYPPopMenu ()

/**
 *  最底部的遮盖 ：屏蔽除菜单以外控件的事件
 */
@property (nonatomic, weak) UIButton *cover;
/**
 *  容器 ：容纳具体要显示的内容contentView
 */
@property (nonatomic, weak) UIImageView *container;

@property (nonatomic, weak) UIView *contentView;

@end



@implementation HYPPopMenu



- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIButton *cover = [[UIButton alloc] init];
        cover.backgroundColor = [UIColor clearColor];
        [cover addTarget:self action:@selector(coverClick) forControlEvents:UIControlEventTouchUpInside];
        self.cover = cover;
        [self addSubview:cover];
        
        UIImageView *container = [[UIImageView alloc] initWithFrame:frame];
        container.userInteractionEnabled = YES;
        UIImage *image = [UIImage imageNamed:@"popover_background"];
        image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(0.3 * image.size.height, 0.1 * image.size.width, 0.9 * image.size.height, 0.9 * image.size.width) resizingMode:UIImageResizingModeStretch];
        container.image = image;
        self.container = container;
        [self addSubview:container];
        
    }
    return self;
}

- (instancetype)initWithView:(UIView *)view{
    self = [self initWithFrame:CGRectZero];
    if (self) {
        self.contentView = view;
    }
    return self;
}

- (void)showInRect:(CGRect)rect{
    UIWindow *window =[[UIApplication sharedApplication] keyWindow];
    self.frame = window.bounds;
    
    [window addSubview:self];
    
    self.container.frame = rect;
    
    [self.container addSubview:self.contentView];
    
    CGRect newRect = CGRectMake( 8, 16, rect.size.width - 16, rect.size.height -28);
    
    [self.contentView setFrame:newRect];
    
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.cover.frame = self.bounds;
}

- (void)coverClick{
    [self dismiss];
}

- (void)dismiss{
    [self removeFromSuperview];
}


@end
