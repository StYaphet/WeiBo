//
//  HYPAccount.m
//  HYPWeiBo
//
//  Created by 郝一鹏 on 16/3/14.
//  Copyright © 2016年 bupt. All rights reserved.
//

#import "HYPAccount.h"

@interface HYPAccount ()<NSCoding>

@end

@implementation HYPAccount

+ (instancetype)initWithDictionary:(NSDictionary *)dic{
    
    HYPAccount *account = [[HYPAccount alloc] init];
    if (account) {
        account.accessToken = [dic objectForKey:@"access_token"];
        account.expiresIn = [dic objectForKey:@"expires_in"];
        account.uid = [dic objectForKey:@"uid"];
        account.date = [[NSDate date] dateByAddingTimeInterval:account.expiresIn.doubleValue];
    }
    
    return account;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        self.accessToken = [aDecoder decodeObjectForKey:@"accessToken"];
        self.expiresIn = [aDecoder decodeObjectForKey:@"expiresIn"];
        self.uid = [aDecoder decodeObjectForKey:@"uid"];
        self.date = [aDecoder decodeObjectForKey:@"date"];
    }
    
    return self;
    
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.accessToken forKey:@"accessToken"];
    [aCoder encodeObject:self.expiresIn forKey:@"expiresIn"];
    [aCoder encodeObject:self.uid forKey:@"uid"];
    [aCoder encodeObject:self.date forKey:@"date"];
    
}

@end
