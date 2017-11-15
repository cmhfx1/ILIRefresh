//
//  ILIRefreshHeader.m
//  Refresh
//
//  Created by fx on 2017/11/3.
//  Copyright © 2017年 fx. All rights reserved.
//

#import "ILIRefreshHeader.h"


@interface ILIRefreshHeader ()

@property (nonatomic, strong)NSMutableArray *items;
@end

@implementation ILIRefreshHeader

+(instancetype)refreshHeaderWithTarget:(id)target sel:(SEL)sel
{
    ILIRefreshHeader *header = [[ILIRefreshHeader alloc] init];
    header.backgroundColor = [UIColor colorWithRed:122/255.0 green:122/255.0 blue:122/255.0 alpha:0];
    [header setTarget:target sel:sel];
    header.items = [NSMutableArray array];
    [header setupItems];
    return header;
}

- (void)setupItems
{
    UIImage *groundImage = [UIImage imageNamed:@"ground"];
    UIImage *buildingsImage = [UIImage imageNamed:@"buildings"];
    UIImage *catImage = [UIImage imageNamed:@"cat"];
    UIImage *capeBackImage = [UIImage imageNamed:@"cape_back"];
    UIImage *capeFrontImage = [UIImage imageNamed:@"cape_front"];
    UIImage *sunImage = [UIImage imageNamed:@"sun"];
    
    CGFloat groundItemViewy = ILIRefreshHeaderHeight - groundImage.size.height;
    
    ILIRefreshHeaderItem *groundItem = [ILIRefreshHeaderItem headerItemWithImage:groundImage endPoint:CGPointMake((KScreenWidth - groundImage.size.width)/2.0, groundItemViewy) direction:ILIRefreshItemdirectionUp scale:0.4 type:ILIRefreshItemTypeGround];
    [self addOItem:groundItem];

    ILIRefreshHeaderItem *buildingsItem = [ILIRefreshHeaderItem headerItemWithImage:buildingsImage endPoint:CGPointMake((KScreenWidth - buildingsImage.size.width)/2.0, groundItemViewy - buildingsImage.size.height) direction:ILIRefreshItemdirectionUp scale:3.0 type:ILIRefreshItemTypeBuilding];
    [self addOItem:buildingsItem];

    ILIRefreshHeaderItem *sunItem = [ILIRefreshHeaderItem headerItemWithImage:sunImage endPoint:CGPointMake(CGRectGetMinX(groundItem.view.frame) - sunImage.size.width * 0.4, groundItemViewy - buildingsImage.size.height - 10) direction:ILIRefreshItemdirectionUp scale:2.2 type:ILIRefreshItemTypeSun];
    [self addOItem:sunItem];

    ILIRefreshHeaderItem *capeBackItem = [ILIRefreshHeaderItem headerItemWithImage:capeBackImage endPoint:CGPointMake((KScreenWidth - capeBackImage.size.width)/2.0, groundItemViewy - (capeBackImage.size.height /2.0)) direction:ILIRefreshItemdirectionDown scale:2.0 type:ILIRefreshItemTypeCapeBack];
    [self addOItem:capeBackItem];

    ILIRefreshHeaderItem *catItem = [ILIRefreshHeaderItem headerItemWithImage:catImage endPoint:CGPointMake((KScreenWidth - catImage.size.width)/2.0, groundItemViewy - (catImage.size.height /2.0)) direction:ILIRefreshItemdirectionUp scale:1.5 type:ILIRefreshItemTypeCat];
    [self addOItem:catItem];
    
    ILIRefreshHeaderItem *capeFrontItem = [ILIRefreshHeaderItem headerItemWithImage:capeFrontImage endPoint:CGPointMake((KScreenWidth - capeFrontImage.size.width)/2.0, groundItemViewy - (catImage.size.height /2.0)) direction:ILIRefreshItemdirectionDown scale:2.0 type:ILIRefreshItemTypeCapeFront];
    [self addOItem:capeFrontItem];
}

- (void)addOItem:(ILIRefreshHeaderItem *)item
{
    [self addSubview:item.view];
    [self.items addObject:item];
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    
    UIScrollView *sc = (UIScrollView *)newSuperview;
    [sc sendSubviewToBack:self];
    
    self.x = 0.f;
    self.width = sc.width;
    self.y = 0 - self.ignoreInsetTop - ILIRefreshHeaderHeight;
    self.height = ILIRefreshHeaderHeight;
}

- (void)handleContentOffset
{
    if (self.state == ILIRefreshStateRefreshing)  return;
    CGFloat distance = -self.scrollView.contentOffset.y - self.originInset.top;
    if (distance < 0){
        self.state = ILIRefreshStateIdentify;
        return;
    }
    if (self.scrollView.isDragging) {
        if (distance > ILIRefreshHeaderPullMinDistanceRelease) {
            self.state = ILIRefreshStateCanRefesh;
        }else{
            CGFloat percent = MIN(distance / ILIRefreshHeaderPullMinDistanceRelease, 1);
            self.backgroundColor = [UIColor colorWithRed:122/255.0 green:122/255.0 blue:122/255.0 alpha:percent];
            self.state = ILIRefreshStatePulling;
            for (ILIRefreshHeaderItem *item in self.items) {
                [item updateProgress:percent];
            }
        }
    }else{
        if (self.state == ILIRefreshStateCanRefesh) {
            self.state = ILIRefreshStateRefreshing;
        }else if(self.state == ILIRefreshStatePulling){
            self.state = ILIRefreshStateIdentify;
        }
    }
}

- (void)setState:(ILIRefreshState)state
{
    ILIRefreshState originS = self.state;
    [super setState:state];
    if (state == ILIRefreshStateRefreshing) {
        for (ILIRefreshHeaderItem *item in self.items) {
            item.view.origin = item.endP;
        }
        [UIView  animateWithDuration:.3f animations:^{
            self.scrollView.contentOffsetY = -self.originInset.top - ILIRefreshHeaderPullMinDistanceRelease;
            self.scrollView.contentInsetTop += ILIRefreshHeaderPullMinDistanceRelease;
        }];
        ILIRefreshHeaderItem *catItem;
        ILIRefreshHeaderItem *capeItem;
        ILIRefreshHeaderItem *capeBackItem;
        
        for (ILIRefreshHeaderItem *item in self.items) {
            if (item.type == ILIRefreshItemTypeGround || item.type == ILIRefreshItemTypeBuilding || item.type == ILIRefreshItemTypeSun) {
                
                [UIView animateWithDuration:.8f delay:.6 options:UIViewAnimationOptionTransitionCurlUp animations:^{
                    item.view.origin = item.beginP;
                } completion:nil];
                
            }else if(item.type == ILIRefreshItemTypeCat){
                catItem = item;
            }else if (item.type == ILIRefreshItemTypeCapeFront){
                capeItem = item;
            }else if(item.type == ILIRefreshItemTypeCapeBack){
                capeBackItem = item;
            }
        }
        
        [UIView animateWithDuration:0.2 delay: 0.f options: UIViewAnimationOptionAutoreverse | UIViewAnimationOptionRepeat animations: ^{
            
            capeItem.view.transform = CGAffineTransformMakeTranslation(0.5, 0);
            catItem.view.transform = CGAffineTransformMakeTranslation(2.0, 0);
            
        } completion: ^(BOOL finished) {
            
            capeItem.view.transform = CGAffineTransformIdentity;
            catItem.view.transform = CGAffineTransformIdentity;
        }];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [catItem.view.layer removeAllAnimations];
            [capeItem.view.layer removeAllAnimations];
            
            [UIView  animateWithDuration:.5f delay:.0 options:UIViewAnimationOptionTransitionCurlUp animations:^{
                self.state = ILIRefreshStateIdentify;
                self.scrollView.contentOffsetY += ILIRefreshHeaderPullMinDistanceRelease;
                
                catItem.view.origin = catItem.beginP;
                capeItem.view.origin = catItem.beginP;
                capeBackItem.view.origin = capeBackItem.beginP;
                catItem.view.alpha = 0;
                capeItem.view.alpha = 0;
                capeBackItem.view.alpha = 0;
                
            } completion:^(BOOL finished) {
                self.scrollView.contentInsetTop -= ILIRefreshHeaderPullMinDistanceRelease;
                ((void (*) (id, SEL)) (void *)objc_msgSend)(self.target, self.sel);
                catItem.view.alpha = 1;
                capeItem.view.alpha = 1;
                capeBackItem.view.alpha = 1;
            }];
        });
    }else if(state == ILIRefreshStateIdentify)
    {
        if (originS == ILIRefreshStatePulling) {
            
            [UIView animateWithDuration:.3f delay:0.f options:UIViewAnimationOptionTransitionCurlUp animations:^{
                
                for (ILIRefreshHeaderItem *item in self.items) {
                    item.view.origin = item.beginP;
                }
            } completion:nil];
        }
    }
}

-(void)beginRefresh{}
-(void)endRefresh{}
@end
