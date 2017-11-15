//
//  ILIRefreshConst.h
//  Refresh
//
//  Created by fx on 2017/11/6.
//  Copyright © 2017年 fx. All rights reserved.
//


#import <UIKit/UIKit.h>

#pragma mark -- 宏定义

#define KScreenWidth  [UIScreen mainScreen].bounds.size.width
#define KScreenHeight [UIScreen mainScreen].bounds.size.height
#define IS_iPhoneX ([UIScreen mainScreen].bounds.size.width == 375 && [UIScreen mainScreen].bounds.size.height == 812)
#define kStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
#define kNavBarHeight 44.0
#define kTopHeight (kStatusBarHeight + kNavBarHeight)
#define kTabBarHeight ([[UIApplication sharedApplication] statusBarFrame].size.height>20?83:49)

/** refreshHeader  */
UIKIT_EXTERN const CGFloat ILIRefreshHeaderHeight;
UIKIT_EXTERN const CGFloat ILIRefreshHeaderPullMinDistanceRelease;

/** refreshFooter  */
UIKIT_EXTERN const CGFloat ILIRefreshFooterHeight;
UIKIT_EXTERN const CGFloat ILIRefreshFooterTitleLabelLeftInset;
#define ILIRefreshFooterLabelTextColor [UIColor colorWithRed:90/255.0 green:90/255.0 blue:90/255.0 alpha:1.0]
#define ILIRefreshFooterLabelFont [UIFont boldSystemFontOfSize:14]
UIKIT_EXTERN const CGFloat ILIRefreshFooterAdvanceLoadDistance;

