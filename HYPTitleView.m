//
//  HYPTitleView.m
//  HYPWeiBo
//
//  Created by 郝一鹏 on 16/3/10.
//  Copyright © 2016年 bupt. All rights reserved.
//

#import "HYPTitleView.h"

@implementation HYPTitleView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //设置文字属性
        [self setTitle:@"首页" forState:UIControlStateNormal];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
        self.titleLabel.textAlignment = NSTextAlignmentRight;
        
        //设置button的图片
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateSelected];
        self.imageView.contentMode = UIViewContentModeCenter;
        self.adjustsImageWhenHighlighted = NO;
    }
    return self;
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    
    //设置文字的frame
    return CGRectMake(0, 0, self.bounds.size.width - self.bounds.size.height, self.bounds.size.height);
    
}
- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    return CGRectMake(self.bounds.size.width - self.bounds.size.height, 0, self.bounds.size.height, self.bounds.size.height);
}

@end
