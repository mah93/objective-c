//
//  ViewController.m
//  MyDush
//
//  Created by login on 16/1/4.
//  Copyright © 2016年 login. All rights reserved.
//

#import "ViewController.h"
#import "LineChartView.h"
@interface ViewController ()
{
    NSMutableArray *randomArray;
    LineChartView *lineChart;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    randomArray = [[NSMutableArray alloc]init];
    for (int i = 0; i < 20; i ++) {
        NSString *string = [NSString stringWithFormat:@"%d",arc4random()%200];
        [randomArray addObject:string];
    }
    
    lineChart = [[LineChartView alloc]initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 350)];
    lineChart.contentList = [randomArray copy];
    lineChart.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:lineChart];
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    button.center = CGPointMake(self.view.center.x, CGRectGetMaxY(lineChart.frame) + 50);
    button.backgroundColor = [UIColor orangeColor];
    [button addTarget:self action:@selector(dddd) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
}

- (void)dddd
{
    [randomArray removeAllObjects];
    int arrayCount = arc4random()%20 + 20;
    for (int i = 0; i < arrayCount; i ++) {
        NSString *string = [NSString stringWithFormat:@"%d",arc4random()%200];
        [randomArray addObject:string];
    }
    lineChart.contentList = [randomArray copy];
    [lineChart setNeedsDisplay];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
