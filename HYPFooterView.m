//
//  HYPFooterView.m
//  HYPWeiBo
//
//  Created by 郝一鹏 on 16/3/16.
//  Copyright © 2016年 bupt. All rights reserved.
//

#import "HYPFooterView.h"
#import "UIView+Extension.h"

@implementation HYPFooterView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        UILabel *label = [[UILabel alloc] initWithFrame:frame];
        label.width = frame.size.width - 3 * frame.size.height;
        label.textColor = [UIColor grayColor];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentRight;
        [self addSubview:label];
        self.loadMoreLabel = label;
        
        UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        activityView.frame = CGRectMake(label.width, 0, self.height, self.height);
        activityView.hidesWhenStopped = YES;
        activityView.backgroundColor = [UIColor clearColor];
        [self addSubview:activityView];
        self.loadingView = activityView;
    }
    return self;
}

@end
