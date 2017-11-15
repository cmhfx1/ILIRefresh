//
//  ILIRefreshFooter.m
//  Refresh
//
//  Created by fx on 2017/11/10.
//  Copyright © 2017年 fx. All rights reserved.
//

#import "ILIRefreshFooter.h"

@interface ILIRefreshFooter()

@property (nonatomic,weak)UILabel *titleLb;
@property (nonatomic,weak)UIActivityIndicatorView *indicatView;
@end


@implementation ILIRefreshFooter

+ (instancetype)refreshFooterWithTarget:(id)target sel:(SEL)sel
{
    ILIRefreshFooter *footer = [[ILIRefreshFooter alloc] init];
    footer.backgroundColor = [UIColor whiteColor];
    [footer setTarget:target sel:sel];
    footer.size = CGSizeMake(KScreenWidth, ILIRefreshFooterHeight);
    [footer setupUI];
    return footer;
}

- (void)setupUI
{
    UIActivityIndicatorView *indicatView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    indicatView.hidesWhenStopped = YES;
    self.indicatView = indicatView;
    [self addSubview:indicatView];
    
    UILabel *titleLb = [[UILabel alloc] init];
    titleLb.textColor = ILIRefreshFooterLabelTextColor;
    titleLb.font = ILIRefreshFooterLabelFont;
    titleLb.textAlignment = NSTextAlignmentCenter;
    titleLb.frame = self.bounds;
    titleLb.text = @"上拉加载更多";
    self.titleLb = titleLb;
    [self addSubview:titleLb];
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];

    UIScrollView *sc = (UIScrollView *)newSuperview;
    CGSize contentSize = sc.contentSize;
    self.x = 0.f;
    self.y = self.ignoreInsetBottom + contentSize.height;
    self.scrollView.contentInsetBottom += ILIRefreshFooterHeight;
}

- (void)handleContentSize
{
    self.y = self.scrollView.contentSize.height;
}

- (void)handleContentInset
{
    if (self.scrollView.contentInsetTop == (self.originInset.top+ ILIRefreshHeaderPullMinDistanceRelease)) {
        if(self.state != ILIRefreshStateRefreshing){
            self.state = ILIRefreshStateIdentify;
        }
    }
}

- (void)handleContentOffset
{

    if (self.state == ILIRefreshStateRefreshing || self.state == ILIRefreshStateNoData) return;
    
    CGFloat visiHeight = self.scrollView.height - self.originInset.top - self.originInset.bottom;
    
    CGFloat footerWillAppearOffsetY = 0.f;
    if (self.scrollView.contentSizeHeight < visiHeight) {
        footerWillAppearOffsetY = - self.originInset.top;
    }else{
        footerWillAppearOffsetY  =  self.scrollView.contentSizeHeight + self.ignoreInsetBottom - self.scrollView.height + (self.originInset.bottom - ILIRefreshFooterHeight);
    }
    
    CGFloat footerWillLoadOffsetY = footerWillAppearOffsetY - ILIRefreshFooterAdvanceLoadDistance;
    
    if (self.scrollView.contentOffsetY > footerWillLoadOffsetY && self.scrollView.contentOffsetY > -self.originInset.top) {

        self.state = ILIRefreshStateRefreshing;
    }
}

- (void)setState:(ILIRefreshState)state
{
    [super setState:state];
    
    if (state == ILIRefreshStateRefreshing) {
        NSString *title = @"正在加载...";
        self.titleLb.text = title;
        CGFloat width = [title sizeWithAttributes:@{NSFontAttributeName : ILIRefreshFooterLabelFont}].width;
        self.indicatView.centerY = ILIRefreshFooterHeight/2.0;
        self.indicatView.centerX = KScreenWidth/2.0 - width/2.0 - ILIRefreshFooterTitleLabelLeftInset - 10;
        [self.indicatView startAnimating];
        
        ((void (*) (id, SEL)) (void *)objc_msgSend)(self.target, self.sel);
    }else if(state == ILIRefreshStateIdentify){
        [self.indicatView stopAnimating];
        self.titleLb.text = @"上拉加载更多";
    }else if(state == ILIRefreshStateNoData){
        [self.indicatView stopAnimating];
        self.titleLb.text = @"已无更多数据";
    }
}

- (void)endRefresh
{
    self.state = ILIRefreshStateIdentify;
}

- (void)noticeNodata
{
    self.state = ILIRefreshStateNoData;
}

-(void)beginRefresh{}


@end
