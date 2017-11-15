//
//  UIScrollView+ILIExtension.h
//  Refresh
//
//  Created by fx on 2017/11/10.
//  Copyright © 2017年 fx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (ILIExtension)


@property (nonatomic,assign)CGFloat contentOffsetX;
@property (nonatomic,assign)CGFloat contentOffsetY;

@property (nonatomic,assign)CGFloat contentInsetTop;
@property (nonatomic,assign)CGFloat contentInsetBottom;

@property (nonatomic,assign)CGFloat contentSizeWidth;
@property (nonatomic,assign)CGFloat contentSizeHeight;

@end
