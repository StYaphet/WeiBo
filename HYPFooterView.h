//
//  HYPFooterView.h
//  HYPWeiBo
//
//  Created by 郝一鹏 on 16/3/16.
//  Copyright © 2016年 bupt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HYPFooterView : UIView

@property (nonatomic, strong) UILabel *loadMoreLabel;
@property (nonatomic, strong) UIActivityIndicatorView *loadingView;

@property (nonatomic, assign) BOOL refreshing;

@end
