//
//  ViewController.m
//  MyCollectionView
//
//  Created by login on 16/1/28.
//  Copyright © 2016年 login. All rights reserved.
//

#import "ViewController.h"
#import "MyCollectionViewCell.h"
#import "MyCollectionViewLayout.h"
#define colletionCell 3
#define screenHeight [[UIScreen mainScreen]bounds].size.height //屏幕高度
#define screenWidth [[UIScreen mainScreen]bounds].size.width   //屏幕宽度
@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,MyCollectionViewLayoutDelegate> {
    UICollectionView *mycollectionView;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    MyCollectionViewLayout *flowLayout = [[MyCollectionViewLayout alloc]init];
    flowLayout.interSpace = 5;
    flowLayout.edgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    flowLayout.colNumber = 3;
    flowLayout.delegate = self;
    
    mycollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight) collectionViewLayout:flowLayout];
    mycollectionView.delegate = self;
    mycollectionView.dataSource = self;
    mycollectionView.backgroundColor = [UIColor whiteColor];
    [mycollectionView registerClass:[MyCollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    [self.view addSubview:mycollectionView];
}
#pragma mark -- 返回每个item的高度
- (CGFloat)itemHeightLayOut:(MyCollectionViewLayout *)layout indexPath:(NSIndexPath *)indexPath {
    CGFloat randomHeight = 50 + arc4random()%200;
    return randomHeight;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 30;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellIdentifier = @"UICollectionViewCell";
    MyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.row = indexPath.row;
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
