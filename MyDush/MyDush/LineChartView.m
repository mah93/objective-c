//
//  LineChartView.m
//  MyDush
//
//  Created by login on 16/1/4.
//  Copyright © 2016年 login. All rights reserved.
//

#import "LineChartView.h"

#define ORIGIN_POINTX 10
#define OVER_EDGE 40

@interface LineChartView()
{
    NSInteger _maxPointY;
    CAShapeLayer *lineShape;
}
@end

@implementation LineChartView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = 8.0;
        self.layer.masksToBounds=YES;

    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    NSInteger contentX = self.contentList.count;
    
    _maxPointY = 0;
    for(NSString *content in self.contentList)
    {
        if ([content integerValue] > _maxPointY) {
            _maxPointY = [content integerValue];
        }
    }
    if (_maxPointY != 0) {
    
        _maxPointY = _maxPointY/0.8;
        
    }
    
    if (contentX != 0) {
        
        CGFloat pointWidth = (self.frame.size.width - ORIGIN_POINTX * 2)/(self.contentList.count);
        
        CGContextRef contextShodow = UIGraphicsGetCurrentContext();
        
        CGContextMoveToPoint(contextShodow, ORIGIN_POINTX, self.frame.size.height - OVER_EDGE);
        
        for (int i = 0; i < self.contentList.count; i++) {
            NSInteger point = [self.contentList[i] integerValue];
            CGContextAddLineToPoint(contextShodow, ORIGIN_POINTX + (i + 1) * pointWidth, self.frame.size.height - (self.frame.size.height - 2 * OVER_EDGE) * point/_maxPointY - OVER_EDGE);
        }
        
        CGContextAddLineToPoint(contextShodow, self.frame.size.width - ORIGIN_POINTX, self.frame.size.height - OVER_EDGE);
        [[UIColor colorWithRed:1 green:1 blue:1 alpha:0.5] setFill];
        CGContextFillPath(contextShodow);  //填充路径
        
        [lineShape removeFromSuperlayer];
        
        lineShape = [[CAShapeLayer alloc]init];
        [self.layer addSublayer:lineShape];
        lineShape.frame = self.bounds;

        UIBezierPath *step4cPath = [UIBezierPath bezierPath];
        [step4cPath moveToPoint:CGPointMake(ORIGIN_POINTX, self.frame.size.height - OVER_EDGE)];
        
        for (int i = 0; i < self.contentList.count; i++) {
            NSInteger point = [self.contentList[i] integerValue];
            [step4cPath addLineToPoint:CGPointMake(ORIGIN_POINTX + (i + 1) * pointWidth, self.frame.size.height - (self.frame.size.height - 2 * OVER_EDGE) * point/_maxPointY - OVER_EDGE)];
        }

        lineShape.path = step4cPath.CGPath;
        lineShape.lineWidth = 1;
        lineShape.strokeColor = [UIColor redColor].CGColor;
        lineShape.fillColor = nil;
        
        // SS(strokeStart)
        CGFloat SSFrom = 0;
        CGFloat SSTo = 0;
        
        // SE(strokeEnd)
        CGFloat SEFrom = 0;
        CGFloat SETo = 1;
        
        // end status
        lineShape.strokeStart = SSTo;
        lineShape.strokeEnd = SETo;
        
        // animation
        CABasicAnimation *startAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
        startAnimation.fromValue = @(SSFrom);
        startAnimation.toValue = @(SSTo);
        
        CABasicAnimation *endAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        endAnimation.fromValue = @(SEFrom);
        endAnimation.toValue = @(SETo);
        
        CAAnimationGroup *anima = [CAAnimationGroup animation];
        anima.animations = @[startAnimation, endAnimation];
        anima.duration = 3.0f;
        [lineShape addAnimation:anima forKey:nil];

        
//        圆点
        
        CGContextRef contextRec = UIGraphicsGetCurrentContext();
        
        [[UIColor whiteColor] setFill];
        CGContextFillEllipseInRect(contextRec, CGRectMake(ORIGIN_POINTX - 2.5, self.frame.size.height - OVER_EDGE - 2.5, 5, 5));
        [[UIColor orangeColor] setFill];
        CGContextFillEllipseInRect(contextRec, CGRectMake(ORIGIN_POINTX - 1.5, self.frame.size.height - OVER_EDGE - 1.5, 3, 3));
        
        for (int i = 0; i < self.contentList.count; i++) {
            NSInteger point = [self.contentList[i] integerValue];
            [[UIColor whiteColor] setFill];
            CGContextFillEllipseInRect(contextRec, CGRectMake(ORIGIN_POINTX + (i + 1) * pointWidth - 2.5, self.frame.size.height - (self.frame.size.height - 2 * OVER_EDGE) * point/_maxPointY - OVER_EDGE - 2.5, 5, 5));
            [[UIColor orangeColor] setFill];
            CGContextFillEllipseInRect(contextRec, CGRectMake(ORIGIN_POINTX + (i + 1) * pointWidth - 1.5, self.frame.size.height - (self.frame.size.height - 2 * OVER_EDGE) * point/_maxPointY - OVER_EDGE - 1.5, 3, 3));
        }
        

//        上下两根直线
        
        CGContextRef contextStraight1 = UIGraphicsGetCurrentContext();
        CGContextMoveToPoint(contextStraight1, 5, OVER_EDGE - 5);
        CGContextAddLineToPoint(contextStraight1, self.frame.size.width - 5, OVER_EDGE - 5);
        [[UIColor whiteColor] set];
        CGContextStrokePath(contextStraight1);
    
        CGContextRef contextStraight2 = UIGraphicsGetCurrentContext();
        CGContextMoveToPoint(contextStraight2, 5, self.frame.size.height - (OVER_EDGE - 5));
        CGContextAddLineToPoint(contextStraight2, self.frame.size.width - 5, self.frame.size.height - (OVER_EDGE - 5));
        [[UIColor whiteColor] set];
        CGContextStrokePath(contextStraight2);

//        虚线
        
        CGFloat lenghts[] = {5,5};
        
        CGContextRef contextBroken = UIGraphicsGetCurrentContext();
        CGContextSetLineDash(contextBroken, 0, lenghts, 2);
        CGContextMoveToPoint(contextBroken, 5, self.bounds.size.height/2);
        CGContextAddLineToPoint(contextBroken, self.bounds.size.width - 5, self.bounds.size.height/2);
        CGContextStrokePath(contextBroken);
        
//        文字

        NSString *maxPointString = [NSString stringWithFormat:@"最大值：%ld",(long)(_maxPointY*0.6)];
        NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:16.0f], NSFontAttributeName,[UIColor whiteColor],NSForegroundColorAttributeName, nil];
        [maxPointString drawInRect:CGRectMake(self.frame.size.width - 100, OVER_EDGE, 100, 20) withAttributes:dic];
        [@"0" drawInRect:CGRectMake(10, self.frame.size.height - OVER_EDGE + 5, 16, 16) withAttributes:dic];
        
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
