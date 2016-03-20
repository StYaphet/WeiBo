//
//  HYPAccountTool.h
//  HYPWeiBo
//
//  Created by 郝一鹏 on 16/3/14.
//  Copyright © 2016年 bupt. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HYPAccount;

@interface HYPAccountTool : NSObject

+ (void)saveAccount:(HYPAccount *)account;

+ (HYPAccount *)account;
@end
