//
//  HYPAccountTool.m
//  HYPWeiBo
//
//  Created by 郝一鹏 on 16/3/14.
//  Copyright © 2016年 bupt. All rights reserved.
//

#import "HYPAccountTool.h"
#import "HYPAccount.h"


@implementation HYPAccountTool

+ (void)saveAccount:(HYPAccount *)account{
    
    
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.plist"];
    [NSKeyedArchiver archiveRootObject:account toFile:path];
}

+ (HYPAccount *)account{
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.plist"];
    HYPAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    return account;
}


@end
