//
//  ViewController.m
//  MHClock
//
//  Created by login on 16/2/16.
//  Copyright © 2016年 login. All rights reserved.
//

#import "ViewController.h"
#import "MHClockView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor brownColor];
    MHClockView *clock = [[MHClockView alloc]initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.width)];
    [self.view addSubview:clock];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
