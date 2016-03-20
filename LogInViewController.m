//
//  LogInViewController.m
//  HYPWeiBo
//
//  Created by 郝一鹏 on 16/3/3.
//  Copyright © 2016年 bupt. All rights reserved.
//

#import "LogInViewController.h"
#import "AFNetworking.h"
#import "HYPAccount.h"
#import "HYPAccountTool.h"
#import "HYPControllerTool.h"


@interface LogInViewController () <UIWebViewDelegate>

{
    UIWebView *_webView;
    
}

@end

@implementation LogInViewController



//设置视图层次结构
- (void)loadView{
    [super loadView];
    
    _webView = [[UIWebView alloc] init];
    
    self.view = _webView;
    
    _webView.delegate = self;

    
}

//  加载授权页面
- (void)viewDidLoad{
    [super viewDidLoad];
    
    NSString *urlString = @"https://api.weibo.com/oauth2/authorize?client_id=2406184446&redirect_uri=http://www.baidu.com/&response_type=code";
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLRequest *oauthReq = [NSURLRequest requestWithURL:url];
    
    [_webView loadRequest:oauthReq];
    
}


#pragma mark - 代理方法
//webview中的内容加载完毕后触发该方法去向服务器索取申请assesstoken所需的code
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
    NSString *urlString = webView.request.URL.absoluteString;
    NSLog(@"%@",urlString);
    
    NSRange codeRange = [urlString rangeOfString:@"code="];
    NSRange fromRang = [urlString rangeOfString:@"&from"];
    
    if (codeRange.length) {
        
        NSString *code = [urlString substringWithRange:NSMakeRange(codeRange.location + codeRange.length, fromRang.location - codeRange.location - codeRange.length)];
        NSLog(@"%@",code);
        
        [self getTokenWithCode:code];
    }
}

//获取assesstoken，accesstouken的固化到文件沙盒中，使用的时候从沙盒中取出

- (void)getTokenWithCode:(NSString *)code{
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *baseURL = @"https://api.weibo.com/oauth2/access_token";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"client_id"] = @"2406184446";
    params[@"client_secret"] = @"f28d5dfc62120b5944e4393cd7191691";
    params[@"grant_type"] = @"authorization_code";
    params[@"code"] = code;
    params[@"redirect_uri"] = @"http://www.baidu.com/";
    
    [manager POST:baseURL parameters:params progress:nil success:^(NSURLSessionDataTask *dataTask, NSDictionary *responseObject){
        NSLog(@"%@",responseObject);
        
        HYPAccount *account = [HYPAccount initWithDictionary:responseObject];
        
        [HYPAccountTool saveAccount:account];
        
        [HYPControllerTool chooseRootViewController];
        
        
        
    } failure:^(NSURLSessionDataTask *dataTask, NSError *error){
        NSLog(@"%@",[error localizedDescription]);
    }];
    
}

- (BOOL)hidesBottomBarWhenPushed{
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
