//
//  ILIRefreshHeaderItem.h
//  Refresh
//
//  Created by fx on 2017/11/5.
//  Copyright © 2017年 fx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+ILIExtension.h"

#import "ILIRefreshConst.h"


typedef NS_ENUM(NSInteger, ILIRefreshItemdirection) {
    ILIRefreshItemdirectionUp = 0,
    ILIRefreshItemdirectionDown
};

typedef NS_ENUM(NSInteger, ILIRefreshItemType) {
    ILIRefreshItemTypeGround = 0,
    ILIRefreshItemTypeBuilding,
    ILIRefreshItemTypeCat,
    ILIRefreshItemTypeCapeBack,
    ILIRefreshItemTypeCapeFront,
    ILIRefreshItemTypeSun,
};

@interface ILIRefreshHeaderItem : NSObject


@property (nonatomic,strong)UIImageView *view;
@property (nonatomic,assign)CGPoint beginP;
@property (nonatomic,assign)CGPoint endP;
@property (nonatomic,assign)ILIRefreshItemdirection direction;
@property (nonatomic,assign)ILIRefreshItemType type;
@property (nonatomic,assign)CGFloat distance;
@property (nonatomic,assign)CGFloat progress;

+ (instancetype)headerItemWithImage:(UIImage *)image endPoint:(CGPoint)ep direction:(ILIRefreshItemdirection)direction scale:(CGFloat)scale type:(ILIRefreshItemType)type;

- (void)updateProgress:(CGFloat)progress;

@end
