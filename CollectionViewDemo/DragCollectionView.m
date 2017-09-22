//
//  DragCollectionView.m
//  CollectionViewDemo
//
//  Created by zhm on 2017/9/22.
//  Copyright © 2017年 xindongfangzaixian. All rights reserved.
//

#import "DragCollectionView.h"
#import "DragCollectionViewCell.h"
@interface DragCollectionView ()

@property(nonatomic,strong)UILongPressGestureRecognizer *longPress;
@property (nonatomic, strong) UIImageView *cellImageView;
@property (nonatomic, strong) NSIndexPath *fromIndexPath;
@property (nonatomic, strong) NSIndexPath *toIndexPath;

@end

@implementation DragCollectionView

- (void)awakeFromNib{
    [super awakeFromNib];
    self.longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressBeginMove:)];
    [self addGestureRecognizer:self.longPress];
    
    
}

- (void)longPressBeginMove:(UILongPressGestureRecognizer *)sender {
    //获取点击的位置
    CGPoint point = [sender locationInView:self];
    if (sender.state == UIGestureRecognizerStateBegan) {
        //根据手势点击的位置，获取被点击cell所在的indexPath
        self.fromIndexPath = [self indexPathForItemAtPoint:point];
        
        if (!_fromIndexPath) return;
        //根据indexPath获取cell
        DragCollectionViewCell *cell = (DragCollectionViewCell *)[self cellForItemAtIndexPath:_fromIndexPath];
        
        //创建一个imageView，imageView的image由cell渲染得来
        self.cellImageView = [self createCellImageView:cell.bigImgView];
        
        //更改imageView的中心点为手指点击位置
       __block CGPoint curPoint = [self convertPoint:cell.center toView:self.curController.view];
        
        _cellImageView.center = curPoint;
//        _cellImageView.alpha = 0.0;
        [UIView animateWithDuration:0.25 animations:^{
            _cellImageView.center = curPoint;
            _cellImageView.transform = CGAffineTransformMakeScale(1.15, 1.15);
//            _cellImageView.alpha = 0.9;
           
        } completion:^(BOOL finished) {
           
        }];
        
    } else if (sender.state == UIGestureRecognizerStateChanged){
       
        //更改imageView的中心点为手指点击位置
        CGPoint center = self.cellImageView.center;
        CGPoint curPoint = [self convertPoint:point toView:self.curController.view];
        center = curPoint;
        self.cellImageView.center = center;
        

    } else if (sender.state == UIGestureRecognizerStateEnded) {

      BOOL isMutul = CGRectIntersectsRect(self.frame,_cellImageView.frame);
        if (isMutul == NO) {
            NSValue *frameValue = [NSValue valueWithCGRect:_cellImageView.frame];
//            CGRect frame = [frameValue CGRectValue];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"DragCollectionViewAddSticker" object:frameValue];
            
        }
        
        [UIView animateWithDuration:0.25 animations:^{

            _cellImageView.transform = CGAffineTransformIdentity;

        } completion:^(BOOL finished) {
            [self.cellImageView removeFromSuperview];
            self.cellImageView = nil;
        }];
    }
}

- (UIImageView *)createCellImageView:(UIView *)snapView {
    
    //打开图形上下文，并将cell的根层渲染到上下文中，生成图片
    UIGraphicsBeginImageContextWithOptions(snapView.bounds.size, NO, 4.f);
    
    [snapView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageView *cellImageView = [[UIImageView alloc] initWithImage:image];
    cellImageView.layer.shadowOffset = CGSizeMake(-5.0, 0.0);
    cellImageView.layer.shadowRadius = 5.0;
    [self.curController.view addSubview:cellImageView];
    [self.curController.view bringSubviewToFront:cellImageView];
    
    return cellImageView;
}

@end
