//
//  HYPPopMenu.h
//  HYPWeiBo
//
//  Created by 郝一鹏 on 16/3/10.
//  Copyright © 2016年 bupt. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HYPPopMenu;

@protocol HMPopMenuDelegate <NSObject>

@optional
- (void)popMenuDidDismissed:(HYPPopMenu *)popMenu;
@end

@interface HYPPopMenu : UIView


@property (nonatomic, weak) id<HMPopMenuDelegate> delegate;

@property (nonatomic, assign, getter = isDimBackground) BOOL dimBackground;



- (void)showInRect:(CGRect)rect;

/**
 *  关闭菜单
 */
- (void)dismiss;

- (instancetype)initWithView:(UIView *)view;


@end
