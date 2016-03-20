//
//  HYPHomeViewController.m
//  HYPWeiBo
//
//  Created by 郝一鹏 on 16/3/6.
//  Copyright © 2016年 bupt. All rights reserved.
//

#import "HYPHomeViewController.h"
#import "UIBarButtonItem+HYP.h"
#import "HYPTitleView.h"
#import "HYPPopMenu.h"
#import "AFNetworking.h"
#import "HYPAccountTool.h"
#import "HYPAccount.h"
#import "MJExtension.h"
#import "HYPStatu.h"
#import "HYPUser.h"
#import "UIImageView+WebCache.h"
#import "HYPFooterView.h"
#import "UIView+Extension.h"

@interface HYPHomeViewController () <HMPopMenuDelegate>

@property (nonatomic,strong) NSMutableArray *statusArray;
@property (nonatomic,strong) HYPFooterView *fooerView;

@end

@implementation HYPHomeViewController

- (NSMutableArray *)statusArray
{
    if (_statusArray == nil) {
        _statusArray = [NSMutableArray array];
    }
    return _statusArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    //  设置导航栏
    [self setNavItems];
    
    //  添加下拉刷新控件
    [self addRefreshControl];
    
    
    [self refreshStatus:self.refreshControl];
    
    HYPFooterView *view = [[HYPFooterView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 40)];
    view.loadMoreLabel.text = @"上拉加载更多数据";
    self.fooerView = view;
    
    self.tableView.tableFooterView = self.fooerView;
    
    
    }
/**
 *  添加下拉刷新控件
 */
- (void)addRefreshControl{
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    
    [refreshControl addTarget:self action:@selector(refreshStatus:) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refreshControl;
}


/**
 *  下拉控件对应方法，更新微博
 */
- (void)refreshStatus:(UIRefreshControl *)refreshControl{
    NSLog(@"刷新了！————————————————");
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];

    HYPAccount *account = [HYPAccountTool account];
    HYPStatu *firstStatus = [self.statusArray firstObject];
    NSLog(@"%@",self.statusArray);
    
    
    params[@"access_token"] = account.accessToken;
    
    if (firstStatus) {
        params[@"since_id"] = firstStatus.idstr;
    }
    
    [manager GET:@"https://api.weibo.com/2/statuses/home_timeline.json" parameters:params progress:nil success:^(NSURLSessionTask *task,NSDictionary *statusDic){
        NSMutableArray *newStatus = [HYPStatu mj_objectArrayWithKeyValuesArray:statusDic[@"statuses"]];
        
        
        self.statusArray = [[newStatus arrayByAddingObjectsFromArray:self.statusArray] mutableCopy];
        
        
        [self.tableView reloadData];
        
        [refreshControl endRefreshing];
        
        [self showStatusCount:newStatus.count];
        
    } failure:^(NSURLSessionTask *task, NSError *error){
        NSLog(@"请求失败");
        
        NSLog(@"%@",[error localizedDescription]);
        
        [refreshControl endRefreshing];
    }];
    
}


- (void)showStatusCount:(NSUInteger)count{
    
    UILabel *label = [[UILabel alloc] init];
    
    if (count != 0) {
        label.text = [NSString stringWithFormat:@"刷新了%lu条新数据",(unsigned long)count];
    }else{
        label.text = @"没有新数据";
    }
    
    label.frame = CGRectMake(0, 24, self.view.bounds.size.width, 40);
    
    label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
    
    label.textAlignment = NSTextAlignmentCenter;
    
    label.textColor = [UIColor whiteColor];
    
    [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];
    
    [UIView animateWithDuration:1.0 animations:^{
        label.transform = CGAffineTransformMakeTranslation(0.0, label.bounds.size.height);
    } completion:^(BOOL finish){
        [UIView animateWithDuration:1.0 delay:1.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            label.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finish){
            [label removeFromSuperview];
        }];
    }];
}

//  设置导航栏
- (void)setNavItems{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"navigationbar_friendsearch" highImageName:@"navigationbar_friendsearch_highlighted" target:self action:nil];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImageName:@"navigationbar_pop" highImageName:@"navigationbar_pop_highlighted" target:self action:nil];
    
    
    //自定义一个titleView
    HYPTitleView *titleView = [[HYPTitleView alloc] initWithFrame:CGRectMake(0, 0, 120,36)];
    [titleView addTarget:self action:@selector(clickTitleView:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleView;
}


//  加载微博
- (void)loadMoreStatuses{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [HYPAccountTool account].accessToken;
    HYPStatu *lastStatus = [self.statusArray lastObject];
    if (lastStatus) {
        params[@"max_id"] = @([lastStatus.idstr longLongValue] - 1);
    }
    
    [manager GET:@"https://api.weibo.com/2/statuses/home_timeline.json" parameters:params progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *responseDic){
        
        NSMutableArray *newStatus = [HYPStatu mj_objectArrayWithKeyValuesArray:responseDic[@"statuses"]];
        
        [self.statusArray addObjectsFromArray:newStatus];
        
        [self.tableView reloadData];
        
        [self.fooerView.loadingView stopAnimating];
        
        self.fooerView.loadMoreLabel.text = @"上拉加载新数据";
        
        self.fooerView.refreshing = NO;
        
    } failure:^(NSURLSessionDataTask *task, NSError *error){
        NSLog(@"请求失败");
        NSLog(@"%@",[error localizedDescription]);
        [self.fooerView.loadingView stopAnimating];
        
        self.fooerView.loadMoreLabel.text = @"上拉加载新数据";
        [self.fooerView.loadingView stopAnimating];
        self.fooerView.refreshing = NO;
    }];

}

//  titleView触发事件
- (void)clickTitleView:(UIButton *)titleView{
    
    titleView.selected = !titleView.selected;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeContactAdd];
    button.backgroundColor = [UIColor redColor];
    
    HYPPopMenu *popMenu = [[HYPPopMenu alloc] initWithView:button];
    
    [popMenu showInRect:CGRectMake(120, 46, 150, 100)];
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    self.tableView.tableFooterView.hidden = (self.statusArray.count == 0);

    return self.statusArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    HYPStatu *statu = self.statusArray[indexPath.row];
    
    cell.textLabel.text = statu.text;
    
    HYPUser *user = statu.user;

    cell.detailTextLabel.text = user.name;
    
    NSString *imageURLStr = user.profile_image_url;
    
    NSURL *imageURL = [NSURL URLWithString:imageURLStr];
    
    [cell.imageView sd_setImageWithURL:imageURL placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    
    return cell;
}

#pragma mark scrollView代理方法

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (self.statusArray.count <= 0 || self.fooerView.refreshing == YES) {
        return;
    }
    
    CGFloat delta = scrollView.contentSize.height - scrollView.contentOffset.y;

    CGFloat sawFooterH = self.view.height - self.tabBarController.tabBar.height;
    

    if (delta <= (sawFooterH - 0)) {
        NSLog(@"上拉刷新-------%f",scrollView.contentOffset.y);
        self.fooerView.refreshing = YES;
        NSLog(@"%d",self.fooerView.refreshing);
        self.fooerView.loadMoreLabel.text = @"正在拼命加载中...";
        [self.fooerView.loadingView startAnimating];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 加载更多的微博数据
            [self loadMoreStatuses];
            NSLog(@"加载数据");
            
        });
    }
}

@end
