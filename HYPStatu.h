//
//  HYPStatu.h
//  HYPWeiBo
//
//  Created by 郝一鹏 on 16/3/14.
//  Copyright © 2016年 bupt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"
#import "HYPUser.h"

@interface HYPStatu : NSObject

@property (nonatomic,strong) HYPUser *user;

@property (nonatomic,copy) NSString *text;

@property (nonatomic,strong) HYPStatu *retweeted_statu;

@property (nonatomic,copy) NSString *idstr;

@end
