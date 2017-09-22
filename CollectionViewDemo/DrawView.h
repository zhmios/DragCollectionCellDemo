//
//  DrawView.h
//  CollectionViewDemo
//
//  Created by zhm on 2017/9/22.
//  Copyright © 2017年 xindongfangzaixian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawView : UIView
@property (nonatomic,weak)UIViewController *controller;
@property (nonatomic,weak)UICollectionViewCell *cell;
@property (nonatomic,assign) CGPoint beginPoint;
- (void)drawBethel;

@end
