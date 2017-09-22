//
//  DrawView.m
//  CollectionViewDemo
//
//  Created by zhm on 2017/9/22.
//  Copyright © 2017年 xindongfangzaixian. All rights reserved.
//

#import "DrawView.h"
@interface DrawView ()

@end
@implementation DrawView


+ (Class)layerClass
{
    return [CAShapeLayer class];
}

- (void)drawBethel{
    
     CAShapeLayer *shapeLayer = (CAShapeLayer *)self.layer;
    shapeLayer.strokeColor = [UIColor purpleColor].CGColor;
     shapeLayer.fillColor = [UIColor clearColor].CGColor;

    shapeLayer.lineJoin = kCALineJoinRound;
    shapeLayer.lineCap = kCALineCapRound;
    shapeLayer.lineWidth = 3;
     UIBezierPath *path = [UIBezierPath bezierPath];
//    CGPoint beginPoint = [self convertPoint:self.cell.center toView:nil];
    [path moveToPoint:self.beginPoint];
    CGPoint endPoint = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
    CGPoint controlPoint = CGPointMake(self.frame.size.width - 100, 0);
    
    [path addQuadCurveToPoint:endPoint controlPoint:controlPoint];
    shapeLayer.path = path.CGPath;
    
//    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"1"]];
//    imageView.frame = CGRectMake(0, 0, 60, 60);
//    imageView.center = self.beginPoint;
//    [self addSubview:imageView];
//    
//    CAKeyframeAnimation *anima = [CAKeyframeAnimation animationWithKeyPath:@"position"];
//    
//    anima.path = path.CGPath;
//    anima.duration = 0.5f;
//    anima.removedOnCompletion = NO;
//    anima.autoreverses = NO;
//    anima.fillMode = kCAFillModeForwards;
//
//    [imageView.layer addAnimation:anima forKey:@"pathAnimation"];

    
    
}

@end
