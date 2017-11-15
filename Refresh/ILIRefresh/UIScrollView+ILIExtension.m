//
//  UIScrollView+ILIExtension.m
//  Refresh
//
//  Created by fx on 2017/11/10.
//  Copyright © 2017年 fx. All rights reserved.
//

#import "UIScrollView+ILIExtension.h"

@implementation UIScrollView (ILIExtension)

- (void)setContentOffsetX:(CGFloat)contentOffsetX
{
    CGPoint contentOffset = self.contentOffset;
    contentOffset.x = contentOffsetX;
    self.contentOffset = contentOffset;
}

- (CGFloat)contentOffsetX
{
    return self.contentOffset.x;
}

- (void)setContentOffsetY:(CGFloat)contentOffsetY
{
    CGPoint contentOffset = self.contentOffset;
    contentOffset.y = contentOffsetY;
    self.contentOffset = contentOffset;
}

- (CGFloat)contentOffsetY
{
    return self.contentOffset.y;
}


- (void)setContentInsetTop:(CGFloat)contentInsetTop
{
    UIEdgeInsets inset = self.contentInset;
    inset.top = contentInsetTop;
    self.contentInset = inset;
}

- (CGFloat)contentInsetTop
{
    return self.contentInset.top;
}

- (void)setContentInsetBottom:(CGFloat)contentInsetBottom
{
    UIEdgeInsets inset = self.contentInset;
    inset.bottom = contentInsetBottom;
    self.contentInset = inset;
}

- (CGFloat)contentInsetBottom
{
    return self.contentInset.bottom;
}

- (void)setContentSizeWidth:(CGFloat)contentSizeWidth
{
    CGSize contentSize = self.contentSize;
    contentSize.width = contentSizeWidth;
    self.contentSize = contentSize;
}

- (CGFloat)contentSizeWidth
{
    return self.contentSize.width;
}


- (void)setContentSizeHeight:(CGFloat)contentSizeHeight
{
    CGSize contentSize = self.contentSize;
    contentSize.height = contentSizeHeight;
    self.contentSize = contentSize;
}

- (CGFloat)contentSizeHeight
{
    return self.contentSize.height;
}



@end
