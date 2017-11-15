//
//  UIScrollView+ILIRefresh.h
//  Refresh
//
//  Created by fx on 2017/11/5.
//  Copyright © 2017年 fx. All rights reserved.
//

#import <UIKit/UIKit.h>

@class  ILIRefreshHeader;  
@class  ILIRefreshFooter;

@interface UIScrollView (ILIRefresh)

@property (strong, nonatomic) ILIRefreshHeader *ili_header;

@property (strong, nonatomic) ILIRefreshFooter *ili_footer;

@end
