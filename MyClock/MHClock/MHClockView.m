//
//  MHClockView.m
//  MHClock
//
//  Created by login on 16/2/16.
//  Copyright © 2016年 login. All rights reserved.
//

#import "MHClockView.h"
#define SELFHEIGHT self.frame.size.height
#define SELFWIDTH self.frame.size.width
#define CLOCKFACEWIDTH SELFWIDTH * 0.8
#define CENTERROUND 8
#define CLOCKEDGEWIDTH 5
@interface MHClockView ()
/**
 *  当前小时数
 */
@property (nonatomic,assign) CGFloat currentHour;
/**
 *  当前分钟数
 */
@property (nonatomic,assign) CGFloat currentMinute;
/**
 *  当前秒数
 */
@property (nonatomic,assign) CGFloat currentSecond;
/**
 *  时针
 */
@property (nonatomic,retain) CAShapeLayer *hourHand;
/**
 *  分针
 */
@property (nonatomic,retain) CAShapeLayer *minuteHand;
/**
 *  秒针
 */
@property (nonatomic,retain) CAShapeLayer *secondHand;
@end

static CGFloat current;

@implementation MHClockView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        self.clockFaceEdgeColr = [UIColor blackColor];
        self.clockFaceColor = [UIColor whiteColor];
        self.clockNumberColor = [UIColor blackColor];
        self.hourHandColor = [UIColor blackColor];
        self.minuteHandColor = [UIColor blackColor];
        self.secondHandColor = [UIColor redColor];
        
        [self numberInClockFace];
        [self getCurrentTime];
    }
    return self;
}
/**
 *  获取当前时间
 */
- (void)getCurrentTime {
    NSDate *date = [NSDate date];
    NSDateFormatter *matter = [[NSDateFormatter alloc]init];
    matter.dateFormat = @"Hmmss";
    NSString *dateString = [matter stringFromDate:date];
    NSLog(@"%@",dateString);
    
    if (dateString.length == 5) {
        dateString = [NSString stringWithFormat:@"0%@",dateString];
    }
    
    self.currentHour = [[dateString substringToIndex:2] floatValue];
    self.currentMinute = [[dateString substringWithRange:NSRangeFromString(@"{2,2}")] floatValue];
    self.currentSecond = [[dateString substringFromIndex:4] floatValue];
    [self creatHand];
}
/**
 *  绘制表针
 */
- (void)creatHand {
    self.hourHand = [CAShapeLayer layer];
    self.hourHand.path = [UIBezierPath bezierPathWithRect:CGRectMake(-2, -CLOCKFACEWIDTH/2 + 70, 4, CLOCKFACEWIDTH/2 - 70)].CGPath;
    self.hourHand.fillColor = self.hourHandColor.CGColor;
    self.hourHand.position = CGPointMake(SELFWIDTH/2, SELFHEIGHT/2);
    [self.layer addSublayer:self.hourHand];
    
    self.minuteHand = [CAShapeLayer layer];
    self.minuteHand.path = [UIBezierPath bezierPathWithRect:CGRectMake(-1, -CLOCKFACEWIDTH/2 + 40, 2, CLOCKFACEWIDTH/2 - 40)].CGPath;
    self.minuteHand.fillColor = self.minuteHandColor.CGColor;
    self.minuteHand.position = CGPointMake(SELFWIDTH/2, SELFHEIGHT/2);
    [self.layer addSublayer:self.minuteHand];

    self.secondHand = [CAShapeLayer layer];
    self.secondHand.path = [UIBezierPath bezierPathWithRect:CGRectMake(-0.5, -CLOCKFACEWIDTH/2 + 20, 1, CLOCKFACEWIDTH/2)].CGPath;
    self.secondHand.fillColor = self.secondHandColor.CGColor;
    self.secondHand.position = CGPointMake(SELFWIDTH/2, SELFHEIGHT/2);
    [self.layer addSublayer:self.secondHand];
    
    self.secondHand.affineTransform = CGAffineTransformMakeRotation(self.currentSecond / 60 * 2.0 * M_PI);
    self.minuteHand.affineTransform = CGAffineTransformMakeRotation((self.currentMinute * 60 + self.currentSecond) / (60 * 60) * 2.0 * M_PI);
    self.hourHand.affineTransform = CGAffineTransformMakeRotation((self.currentHour * 60 * 60 + (self.currentMinute * 60 + self.currentSecond))/ (60 * 60 * 12) * 2.0 * M_PI);

    current = self.currentHour * 60 * 60 + self.currentMinute * 60 + self.currentSecond;
    NSTimer *timer = [NSTimer timerWithTimeInterval:1.0f target:self selector:@selector(startClock) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];

}
/**
 *  绘制表盘
 */
- (void)drawRect:(CGRect)rect {
    
    CGRect roundEdgeRect = CGRectMake((SELFWIDTH - CLOCKFACEWIDTH-CLOCKEDGEWIDTH)/2, (SELFWIDTH - CLOCKFACEWIDTH-CLOCKEDGEWIDTH)/2, CLOCKFACEWIDTH+CLOCKEDGEWIDTH, CLOCKFACEWIDTH+CLOCKEDGEWIDTH);
    CGContextRef refEdge = UIGraphicsGetCurrentContext();
    CGContextAddEllipseInRect(refEdge, roundEdgeRect);
    [self.clockFaceEdgeColr set];
    CGContextFillPath(refEdge);

    
    CGRect roundRect = CGRectMake((SELFWIDTH - CLOCKFACEWIDTH)/2, (SELFWIDTH - CLOCKFACEWIDTH)/2, CLOCKFACEWIDTH, CLOCKFACEWIDTH);
    CGContextRef ref = UIGraphicsGetCurrentContext();
    CGContextAddEllipseInRect(ref, roundRect);
    [self.clockFaceColor set];
    CGContextFillPath(ref);
//    CGContextStrokePath(ref);
    
    CGContextRef round = UIGraphicsGetCurrentContext();
    CGContextAddEllipseInRect(round, CGRectMake((SELFWIDTH - CENTERROUND)/2, (SELFWIDTH - CENTERROUND)/2, CENTERROUND, CENTERROUND));
    [[UIColor blackColor] set];
    CGContextFillPath(round);
}
/**
 *  创建表盘上的数字
 */
- (void)numberInClockFace {
    for (int i = 1; i <= 12; i ++) {
        [self creatNumberLabelWithText:[NSString stringWithFormat:@"%d",i] Angel:i * 30];
    }
}
/**
 *  创建数字
 *
 *  @param text  数字
 *  @param angel 所在角度
 */
- (void)creatNumberLabelWithText:(NSString *)text Angel:(CGFloat)angel {
    
    UILabel *numberLabel = [[UILabel alloc]init];
    numberLabel.bounds = CGRectMake(0, 0, 30, 20);
    numberLabel.center = [self getCenterFromAngel:angel];
    numberLabel.text = text;
    numberLabel.backgroundColor = [UIColor clearColor];
    numberLabel.textColor = self.clockNumberColor;
    numberLabel.font = [UIFont boldSystemFontOfSize:20];
    numberLabel.textAlignment = NSTextAlignmentCenter;
    numberLabel.tag = [text integerValue];
    [self addSubview:numberLabel];
}
/**
 *  从角度获取X、Y
 *
 *  @param angel 角度
 *
 *  @return 中心点
 */
- (CGPoint)getCenterFromAngel:(CGFloat)angel {
    CGFloat radius = SELFWIDTH/2 * 0.65;
    CGFloat pointX = fabs(sin(angel/180 * M_PI)) * radius;
    CGFloat pointY = fabs(cos(angel/180 * M_PI)) * radius;
    CGFloat addX;
    CGFloat addY;
    if (angel >= 0 && angel < 90) {
        addX = pointX;
        addY = -pointY;
    } else if (angel >= 90 && angel < 180) {
        addX = pointX;
        addY = pointY;
    } else if (angel >= 180 && angel < 270) {
        addX = -pointX;
        addY = pointY;
    } else if (angel >= 270 && angel <= 360) {
        addX = -pointX;
        addY = -pointY;
    }
    return CGPointMake(SELFWIDTH/2 + addX, SELFWIDTH/2 + addY);
}
/**
 *  开始
 */
- (void)startClock {
    current ++;
    self.secondHand.affineTransform = CGAffineTransformMakeRotation(current / 60 * 2.0 * M_PI);
    self.minuteHand.affineTransform = CGAffineTransformMakeRotation(current / (60 * 60) * 2.0 * M_PI);
    self.hourHand.affineTransform = CGAffineTransformMakeRotation(current / (60 * 60 * 12) * 2.0 * M_PI);
}
- (void)setHourHandColor:(UIColor *)hourHandColor {
    _hourHandColor = hourHandColor;
    self.hourHand.fillColor = self.hourHandColor.CGColor;
}
- (void)setMinuteHandColor:(UIColor *)minuteHandColor {
    _minuteHandColor = minuteHandColor;
    self.minuteHand.fillColor = self.hourHandColor.CGColor;
}
- (void)setSecondHandColor:(UIColor *)secondHandColor {
    _secondHandColor = secondHandColor;
    self.secondHand.fillColor = self.secondHandColor.CGColor;
}
- (void)setClockNumberColor:(UIColor *)clockNumberColor {
    _clockNumberColor = clockNumberColor;
    for (int i = 1; i <= 12; i++) {
        UILabel *numberLabel = (UILabel *)[self viewWithTag:i];
        numberLabel.textColor = self.clockNumberColor;
    }
}
/*
// Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
