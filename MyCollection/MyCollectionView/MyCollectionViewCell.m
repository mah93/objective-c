//
//  MyCollectionViewCell.m
//  MyCollectionView
//
//  Created by login on 16/1/29.
//  Copyright © 2016年 login. All rights reserved.
//

#import "MyCollectionViewCell.h"

@interface MyCollectionViewCell ()
@property (nonatomic,retain) UILabel *mark;
@end
@implementation MyCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor brownColor];
        self.mark = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
//        self.mark.center = CGPointMake(self.center.x, self.center.y);
        self.mark.textColor = [UIColor redColor];
        [self.contentView addSubview:self.mark];
    }
    return self;
}
- (void)setRow:(NSInteger)row {
    self.mark.text = [NSString stringWithFormat:@"%ld",(long)row];
}
@end
