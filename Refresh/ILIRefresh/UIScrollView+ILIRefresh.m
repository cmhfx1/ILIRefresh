//
//  UIScrollView+ILIRefresh.m
//  Refresh
//
//  Created by fx on 2017/11/5.
//  Copyright © 2017年 fx. All rights reserved.
//

#import "UIScrollView+ILIRefresh.h"

#import "ILIRefreshHeader.h"
#import "ILIRefreshFooter.h"

#import <objc/runtime.h>



@implementation UIScrollView (ILIRefresh)


static const char ILIRefreshHeaderKey = '\0';
- (void)setIli_header:(ILIRefreshHeader *)ili_header
{
    if (ili_header != self.ili_header) {
        
        [self.ili_header removeFromSuperview];
        [self insertSubview:ili_header atIndex:0];

        [self willChangeValueForKey:@"ili_header"];
        objc_setAssociatedObject(self, &ILIRefreshHeaderKey,
                                 ili_header, OBJC_ASSOCIATION_ASSIGN);
        [self didChangeValueForKey:@"ili_header"];
    }
}
- (ILIRefreshHeader *)ili_header
{
    return objc_getAssociatedObject(self, &ILIRefreshHeaderKey);
}



static const char ILIRefreshFooterKey = '\0';
- (void)setIli_footer:(ILIRefreshFooter *)ili_footer
{
    if (ili_footer != self.ili_footer) {

        [self.ili_footer removeFromSuperview];
        [self insertSubview:ili_footer atIndex:0];
        

        [self willChangeValueForKey:@"ili_footer"];
        objc_setAssociatedObject(self, &ILIRefreshFooterKey,
                                 ili_footer, OBJC_ASSOCIATION_ASSIGN);
        [self didChangeValueForKey:@"ili_footer"];
    }
}

- (ILIRefreshFooter *)ili_footer
{
    return objc_getAssociatedObject(self, &ILIRefreshFooterKey);
}


@end







@implementation UITableView (MJRefresh)

+ (void)load
{
    
    method_exchangeImplementations(class_getInstanceMethod(self, @selector(reloadData)), class_getInstanceMethod(self, @selector(ILI_reloadData)));
}

- (void)ILI_reloadData
{
    [self ILI_reloadData];
    
    if (self.ili_header) {
        [self sendSubviewToBack:self.ili_header];
    }
    
}

@end
