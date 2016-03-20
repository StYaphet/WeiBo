//
//  HYPTextView.m
//  HYPWeiBo
//
//  Created by 郝一鹏 on 16/3/17.
//  Copyright © 2016年 bupt. All rights reserved.
//

#import "HYPTextView.h"
#import "UIView+Extension.h"

@interface HYPTextView ()

@property (nonatomic, strong) UILabel *placeHolderLabel;
;
@end

@implementation HYPTextView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //  添加一个Placeholder
        UILabel *placeholderLabel = [[UILabel alloc] init];
        //设置label中文字有几行 
        placeholderLabel.numberOfLines = 0;
        [self addSubview:placeholderLabel];
        self.placeHolderLabel = placeholderLabel;
        //  设置默认占位文字字体
        self.font = [UIFont systemFontOfSize:18];
        self.placeHolderLabel.font = self.font;
        //  设置默认占位文字颜色
        self.placeHolderLabel.textColor = [UIColor grayColor];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
        
    }
    return self;
}
// 初始化的时候把自己注册到通知中心了，在释放的时候一定要注销
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidEndEditingNotification object:self];
}

#pragma mark - 监听文字改变
- (void)textDidChange{
    if (self.text.length == 0) {
        self.placeHolderLabel.hidden = NO;
    }else{
        self.placeHolderLabel.hidden = YES;
    }
}

/**
 *     设置placeholder 的文字
 *
 *  @param placeHolder 占位文字
 */
- (void)setPlaceHolder:(NSString *)placeHolder{
    
    _placeHolder = [placeHolder copy];
    
    //  设置placeholder 的文字
    self.placeHolderLabel.text = placeHolder;
    //  重新布局
    [self setNeedsLayout];
}


/**
 *  设置placeholder 的文字颜色
 *
 *  @param placeHolderColor  文字颜色
 */
- (void)setPlaceHolderColor:(UIColor *)placeHolderColor{
    
    _placeHolderColor = placeHolderColor;
    
    //  设置placeholder 的文字颜色
    self.placeHolderLabel.textColor = placeHolderColor ;
}


/**
 *  设置placeholer的字体
 *
 *
 */
- (void)setFont:(UIFont *)font{
    [super setFont:font];
    self.placeHolderLabel.font = font;
    //  重新布局
    [self setNeedsLayout];
    
}

- (void)setText:(NSString *)text{
    [super setText:text];
    [self textDidChange];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.placeHolderLabel.x = 5;
    self.placeHolderLabel.y = 8;
    self.placeHolderLabel.width = self.width;
    CGSize maxSize = CGSizeMake(self.placeHolderLabel.width, MAXFLOAT);
    self.placeHolderLabel.height = [self.placeHolder sizeWithFont:self.placeHolderLabel.font constrainedToSize:maxSize].height ;
}
@end
