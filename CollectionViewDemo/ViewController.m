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
@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet DragCollectionView *collectionView;

@property(nonatomic,strong)UILongPressGestureRecognizer *longPress;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.curController = self;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(addWaterMark:) name:@"DragCollectionViewAddSticker" object:nil];
    
}

- (void)addWaterMark:(NSNotification *)not{
    NSValue *frameValue = not.object;
    CGRect frame = [frameValue CGRectValue];
    UIView *view = [[UIView alloc]initWithFrame:frame];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"1"]];
    imageView.frame = CGRectMake(0, 0, 60, 60);
    imageView.center = view.center;
    [self.view addSubview:imageView];
//    imageView.alpha = 0;
//    [UIView animateWithDuration:0.26 animations:^{
//        imageView.alpha = 1;
//    }completion:^(BOOL finished) {
//
//    }];
//    
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    DragCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DragCollectionViewCell" forIndexPath:indexPath];
    return cell;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
