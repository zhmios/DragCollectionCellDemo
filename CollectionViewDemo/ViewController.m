//
//  ViewController.m
//  CollectionViewDemo
//
//  Created by zhm on 2017/9/22.
//  Copyright © 2017年 xindongfangzaixian. All rights reserved.
//

#import "ViewController.h"
#import "DragCollectionViewCell.h"
#import "DragCollectionView.h"
#import "DrawView.h"
@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet DragCollectionView *collectionView;

@property (weak, nonatomic) IBOutlet DrawView *drawView;
@property(nonatomic,strong)UILongPressGestureRecognizer *longPress;
@property(nonatomic,assign)NSInteger number;
@property(nonatomic,assign)CGPoint beginPoint;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.curController = self;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(addWaterMark:) name:@"DragCollectionViewAddSticker" object:nil];
   
}
- (IBAction)btnPress:(id)sender {
    self.number ++;
    if (self.number == 10) {
        self.number = 0;
    }
    [self.collectionView reloadData];
    
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    //    CGPoint beginPoint = [self convertPoint:self.cell.center toView:nil];
    [path moveToPoint:self.beginPoint];
    CGPoint endPoint = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height / 2);
    CGPoint controlPoint = CGPointMake(self.view.frame.size.width - 100, CGRectGetMidY(self.collectionView.frame));
    
    [path addQuadCurveToPoint:endPoint controlPoint:controlPoint];
   
    
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"1"]];
    imageView.frame = CGRectMake(0, 0, 70, 70);
    imageView.center = self.beginPoint;
    [self.view addSubview:imageView];
    
    CAKeyframeAnimation *anima = [CAKeyframeAnimation animationWithKeyPath:@"position"];

    anima.path = path.CGPath;
    anima.duration = 0.5f;
    anima.removedOnCompletion = NO;
    anima.autoreverses = NO;
    anima.fillMode = kCAFillModeForwards;

    [imageView.layer addAnimation:anima forKey:@"pathAnimation"];
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    
    
}

- (void)addWaterMark:(NSNotification *)not{
    NSValue *frameValue = not.object;
    CGRect frame = [frameValue CGRectValue];
    UIView *view = [[UIView alloc]initWithFrame:frame];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"1"]];
    imageView.frame = CGRectMake(0, 0, 60, 60);
    imageView.center = view.center;
    [self.view addSubview:imageView];

}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"row:%ld \n",indexPath.row);
    DragCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DragCollectionViewCell" forIndexPath:indexPath];
    self.drawView.cell = cell;
    CGPoint convertPoint = [collectionView convertPoint:cell.center toView:self.view];
    
    NSLog(@"转变后的坐标:%@",NSStringFromCGPoint(convertPoint));
    if (indexPath.row == self.number) {
//        self.drawView.beginPoint = CGPointMake(convertPoint.x, convertPoint.y - self.drawView.frame.origin.y);
//          [self.drawView drawBethel];
        self.beginPoint = CGPointMake(convertPoint.x, convertPoint.y);
    }
  
    return cell;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
