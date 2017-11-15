//
//  ILIRefreshHeaderItem.m
//  Refresh
//
//  Created by fx on 2017/11/5.
//  Copyright © 2017年 fx. All rights reserved.
//

#import "ILIRefreshHeaderItem.h"

@implementation ILIRefreshHeaderItem

+ (instancetype)headerItemWithImage:(UIImage *)image endPoint:(CGPoint)ep direction:(ILIRefreshItemdirection)direction scale:(CGFloat)scale type:(ILIRefreshItemType)type
{
    ILIRefreshHeaderItem *item = [[ILIRefreshHeaderItem alloc] init];
    CGPoint origin = CGPointZero;
    if (direction == ILIRefreshItemdirectionUp) {
        origin.y = ep.y + ILIRefreshHeaderPullMinDistanceRelease * scale;
    }else{
        origin.y = ep.y - ILIRefreshHeaderPullMinDistanceRelease * scale;
    }
    origin.x = ep.x;
    UIImageView *imagev = [[UIImageView alloc] initWithImage:image];
    imagev.origin = origin;
    item.view = imagev;
    item.endP = ep;
    item.beginP = origin;
    item.direction = direction;
    item.type = type;
    item.distance = scale * ILIRefreshHeaderPullMinDistanceRelease;
    return item;
}

- (void)updateProgress:(CGFloat)progress
{
    self.progress = progress;
    CGPoint origin = CGPointZero;
    origin.x = _beginP.x;
    if (_direction == ILIRefreshItemdirectionUp) {
        origin.y = _beginP.y - _distance * progress;
    }else{
        origin.y = _beginP.y + _distance * progress;
    }
    self.view.origin = origin;
}

@end
