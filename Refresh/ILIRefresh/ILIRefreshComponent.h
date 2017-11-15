//
//  ILIRefreshComponent.h
//  Refresh
//
//  Created by fx on 2017/11/15.
//  Copyright © 2017年 fx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+ILIExtension.h"
#import "UIScrollView+ILIExtension.h"
#import "ILIRefreshConst.h"
#import <objc/message.h>

typedef NS_ENUM(NSInteger, ILIRefreshState) {
    ILIRefreshStateIdentify = 0,
    ILIRefreshStatePulling,
    ILIRefreshStateCanRefesh,
    ILIRefreshStateRefreshing,
    ILIRefreshStateNoData
};

@interface ILIRefreshComponent : UIView

@property (nonatomic,assign)CGFloat ignoreInsetTop;
@property (nonatomic,assign)CGFloat ignoreInsetBottom;

@property (nonatomic,weak)id target;
@property (nonatomic,assign)SEL sel;

@property (nonatomic,weak)UIScrollView *scrollView;
@property (nonatomic,assign)UIEdgeInsets originInset;
@property (nonatomic,assign)ILIRefreshState state;


-(void)setTarget:(id)target sel:(SEL)sel;

-(void)beginRefresh;
-(void)endRefresh;

-(void)noticeNodata;


@end
