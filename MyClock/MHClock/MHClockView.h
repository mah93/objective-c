//
//  MHClockView.h
//  MHClock
//
//  Created by login on 16/2/16.
//  Copyright © 2016年 login. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MHClockView : UIView
/**
 *  表盘颜色 默认白色
 */
@property (nonatomic,retain) UIColor *clockFaceColor;
/**
 *  表盘边框颜色 默认黑色
 */
@property (nonatomic,retain) UIColor *clockFaceEdgeColr;
/**
 *  数字颜色 默认黑色
 */
@property (nonatomic,retain) UIColor *clockNumberColor;
/**
 *  时针颜色 默认黑色
 */
@property (nonatomic,retain) UIColor *hourHandColor;
/**
 *  分针颜色 默认黑色
 */
@property (nonatomic,retain) UIColor *minuteHandColor;
/**
 *  秒针颜色 默认红色
 */
@property (nonatomic,retain) UIColor *secondHandColor;
@end
