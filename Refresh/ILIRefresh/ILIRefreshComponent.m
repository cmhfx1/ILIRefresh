//
//  ILIRefreshComponent.m
//  Refresh
//
//  Created by fx on 2017/11/15.
//  Copyright © 2017年 fx. All rights reserved.
//

#import "ILIRefreshComponent.h"

@interface ILIRefreshComponent ()
@end

@implementation ILIRefreshComponent

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.clipsToBounds = YES;
        self.state = ILIRefreshStateIdentify;
    }
    return self;
}

- (void)setTarget:(id)target sel:(SEL)sel
{
    self.target = target;
    self.sel = sel;
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    
    if (![newSuperview isKindOfClass:[UIScrollView class]]) return;
    UIScrollView *sc = (UIScrollView *)newSuperview;
    self.scrollView = sc;
    self.originInset = sc.contentInset;
    
    [sc addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
    [sc addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    [sc addObserver:self forKeyPath:@"contentInset" options:NSKeyValueObservingOptionNew context:nil];
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"contentSize"]) {
        [self handleContentSize];
    }else if([keyPath isEqualToString:@"contentOffset"]){
        [self handleContentOffset];
    }else if([keyPath isEqualToString:@"contentInset"]){
        [self handleContentInset];
    }
    
}
-(void)handleContentSize{ }
-(void)handleContentOffset{ }
-(void)handleContentInset{ }
@end
