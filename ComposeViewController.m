//
//  ComposeViewController.m
//  HYPWeiBo
//
//  Created by 郝一鹏 on 16/3/10.
//  Copyright © 2016年 bupt. All rights reserved.
//

#import "ComposeViewController.h"
#import "HYPTextView.h"
#import "UIView+Extension.h"

@interface ComposeViewController ()<UITextViewDelegate>

@property (nonatomic,strong) HYPTextView *textView;

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //  设置navigationBatItem
    [self setNavigationItems];
    
    //  添加TextView
    [self addTextView];
}
/**
 *  添加TextView
 */
- (void)addTextView{
    
    HYPTextView *textView = [[HYPTextView alloc] init];
    textView.frame = self.view.bounds;
    //  设置placeHolder内容
    textView.placeHolder = @"分享新鲜事";
    self.textView = textView;
    [self.view addSubview:textView];

}


/**
 *      设置navigationBatItem
 */
- (void)setNavigationItems{
    
    self.navigationItem.title = @"发微博";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(send)];
//    self.navigationItem.rightBarButtonItem.enabled = NO;
}


- (void)send{
    NSLog(@"我就不给你发！");
}

- (void)cancel{
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.textView resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark UITextView代理方法



@end
