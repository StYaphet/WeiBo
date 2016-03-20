//
//  HYPNewFeatureViewController.m
//  HYPWeiBo
//
//  Created by 郝一鹏 on 16/3/11.
//  Copyright © 2016年 bupt. All rights reserved.
//

#import "HYPNewFeatureViewController.h"
#import "UIView+Extension.h"
#import "HYPTabBarViewController.h"

@interface HYPNewFeatureViewController () <UIScrollViewDelegate>

@property (nonatomic,weak) UIPageControl *pageControl;

@end

@implementation HYPNewFeatureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //设置滚动控件
    [self addScrollView];
    
    // 设置分页控件
    [self addPageControl];
    
}

//添加scroll控件
//scrollView使用时，要先创建，设置frame，设置子视图，设置contentsize
- (void)addScrollView{
    CGFloat width = self.view.bounds.size.width;
    CGFloat height = self.view.bounds.size.height;
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.view.bounds;
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.bounces = NO;
    
    for (int i = 0; i<4; i++) {
        
        UIImage *image = [UIImage imageNamed: [NSString stringWithFormat:@"new_feature_%d",i +1]];
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        
        imageView.frame = CGRectMake(i * width, 0, width, height);
        
        if (i == 3) {
            //  添加选择分享按钮
            UIButton *shareButton = [self addShareButton];
            //  添加开始按钮
            UIButton *startButton = [self addStartButton];
            
            [imageView addSubview:startButton];
            
            [imageView addSubview:shareButton];
        }
        
        imageView.userInteractionEnabled = YES;
        [scrollView addSubview:imageView];
    }
    scrollView.contentSize = CGSizeMake(width * 4, 0);
    scrollView.delegate = self;
    
    [self.view addSubview:scrollView];
}

//添加分页控件
- (void)addPageControl{
    CGFloat width = self.view.bounds.size.width;
    CGFloat height = self.view.bounds.size.height;
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    
    pageControl.size = CGSizeMake(100, 20);
    pageControl.center = CGPointMake(width * 0.5, height * 0.9);
    pageControl.numberOfPages = 4;
    pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
    pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    
    self.pageControl = pageControl;
    
    
    
    
    [self.view addSubview:pageControl];
}

// 添加选择分享按钮
- (UIButton *)addShareButton{
    UIButton *shareButton = [[UIButton alloc] init];
    shareButton.size = CGSizeMake(120, 30);
    shareButton.center = CGPointMake(self.view.bounds.size.width * 0.5, self.view.bounds.size.height * 0.7);
    [shareButton setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
    [shareButton setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
    [shareButton setTitle:@"分享给大家" forState:UIControlStateNormal];
    [shareButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    shareButton.size = CGSizeMake(120, 30);
    
    [shareButton addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
    
    return shareButton;
}

- (UIButton *)addStartButton{
    UIButton *startButton = [[UIButton alloc] init];
    startButton.size = CGSizeMake(100, 40);
    startButton.center = CGPointMake(self.view.bounds.size.width * 0.5, self.view.bounds.size.height * 0.7 + 40);
    [startButton setBackgroundColor:[UIColor orangeColor]];
    [startButton setTitle:@"开始微博" forState:UIControlStateNormal];
    [startButton addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
    return startButton;
}

- (void)share:(UIButton *)button{
    button.selected = !button.selected;
}

- (void)start{
    self.view.window.rootViewController = [[HYPTabBarViewController alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark scrollView代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat page = scrollView.contentOffset.x / scrollView.width;
    
    int pageIndex = (int)(page + 0.5);
    
    self.pageControl.currentPage = pageIndex;
    
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
