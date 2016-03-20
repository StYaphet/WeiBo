//
//  HYPSearchBar.m
//  HYPWeiBo
//
//  Created by 郝一鹏 on 16/3/10.
//  Copyright © 2016年 bupt. All rights reserved.
//

#import "HYPSearchBar.h"

@implementation HYPSearchBar

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.borderStyle = UITextBorderStyleRoundedRect;
        self.frame = CGRectMake(0, 0, 360, 30);
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"searchbar_textfield_search_icon"]];
        
        imageView.bounds = CGRectMake(0, 0, 30, 26);
        imageView.contentMode = UIViewContentModeCenter;
        self.leftView = imageView;
        self.leftViewMode = UITextFieldViewModeAlways;
        self.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.returnKeyType = UIReturnKeyDone;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
