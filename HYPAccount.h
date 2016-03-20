//
//  HYPAccount.h
//  HYPWeiBo
//
//  Created by 郝一鹏 on 16/3/14.
//  Copyright © 2016年 bupt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYPAccount : NSObject

@property (nonatomic,copy) NSString *accessToken;

@property (nonatomic,copy) NSNumber *expiresIn;

@property (nonatomic,copy) NSString *uid;

@property (nonatomic,strong) NSDate *date;

+ (instancetype)initWithDictionary:(NSDictionary *)dic;

@end
