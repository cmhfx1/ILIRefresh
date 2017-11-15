//
//  ViewController.m
//  Refresh
//
//  Created by fx on 2017/11/3.
//  Copyright © 2017年 fx. All rights reserved.
//

#import "ViewController.h"
#import "TestViewController.h"

#import "ILIRefresh.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,assign)NSInteger count;
@property (nonatomic,weak)UITableView *tb;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupSubviews];

}

- (void)setupSubviews
{
    UITableView *tb =[[UITableView alloc] initWithFrame:CGRectMake(0, kTopHeight, KScreenWidth, KScreenHeight-kTopHeight) ];
    
    if (@available(iOS 11.0, *)) {
        tb.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    tb.contentInset = UIEdgeInsetsMake(0, 0, kTabBarHeight, 0);
    
    [self.view addSubview:tb];
    tb.delegate = self;
    tb.dataSource= self;
    self.tb = tb;
    [tb registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    self.count = 20;
    
    tb.ili_header = [ILIRefreshHeader refreshHeaderWithTarget:self sel:@selector(refreshNewData)];
    
    tb.ili_footer = [ILIRefreshFooter refreshFooterWithTarget:self sel:@selector(refreshMoreData)];
}

- (void)refreshNewData
{
    self.count = 2;
    [self.tb reloadData];
}

- (void)refreshMoreData
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.count +=20;
        [self.tb reloadData];
        [self.tb.ili_footer endRefresh];
    });
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.count;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 40;
//}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text =[NSString stringWithFormat:@"%ld",indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.navigationController pushViewController:[TestViewController new] animated:YES];
}



@end
