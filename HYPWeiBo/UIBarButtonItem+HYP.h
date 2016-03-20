//
//  UIBarButtonItem+HYP.h
//  
//
//  Created by 郝一鹏 on 16/3/6.
//
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (HYP)

+ (UIBarButtonItem *)itemWithImageName:(NSString *)imageName highImageName:(NSString *)highImageName target:(id)target action:(SEL)action;

@end
