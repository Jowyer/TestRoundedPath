//
//  ViewController.m
//  TestRoundedPath
//
//  Created by Jun Wang on 13-9-13.
//  Copyright (c) 2013年 jo2studio. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>

#define   DEGREES_TO_RADIANS(degrees)  ((M_PI * degrees)/ 180) 

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    rectWidth = 60;
    rectHeight = 80;
    arcFactor = 1.0 / 10.0;
    
    testView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, rectWidth, rectHeight)];
    testView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:testView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(0, 0, 50, 30);
    [button setTitle:@"Tap" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)dealloc
{
    [testView release]; testView = nil;
    [super dealloc];
}

-(void)buttonTapped
{
    float radius = rectWidth < rectHeight ? rectWidth * arcFactor : rectHeight * arcFactor;
    
    UIBezierPath *aPath = [UIBezierPath bezierPath];
    
    [aPath moveToPoint:CGPointMake(rectWidth / 2, 0)];
    [aPath addLineToPoint:CGPointMake(rectWidth - radius, 0)];
    [aPath addArcWithCenter:CGPointMake(rectWidth - radius, radius) radius:radius startAngle:DEGREES_TO_RADIANS(270) endAngle:DEGREES_TO_RADIANS(360) clockwise:YES];
    [aPath addLineToPoint:CGPointMake(rectWidth, radius)];
    [aPath addLineToPoint:CGPointMake(rectWidth, rectHeight - radius)];
    [aPath addArcWithCenter:CGPointMake(rectWidth - radius, rectHeight - radius) radius:radius startAngle:DEGREES_TO_RADIANS(0) endAngle:DEGREES_TO_RADIANS(90) clockwise:YES];
    [aPath addLineToPoint:CGPointMake(radius, rectHeight)];
    [aPath addArcWithCenter:CGPointMake(radius, rectHeight - radius) radius:radius startAngle:DEGREES_TO_RADIANS(90) endAngle:DEGREES_TO_RADIANS(180) clockwise:YES];
    [aPath addLineToPoint:CGPointMake(0, radius)];
    [aPath addArcWithCenter:CGPointMake(radius, radius) radius:radius startAngle:DEGREES_TO_RADIANS(180) endAngle:DEGREES_TO_RADIANS(270) clockwise:YES];
    
    [aPath closePath];
    
    CAShapeLayer *aLayer = [CAShapeLayer layer];
    aLayer.path = aPath.CGPath;
    aLayer.fillColor=[UIColor clearColor].CGColor;
    aLayer.strokeColor=[UIColor greenColor].CGColor;
    aLayer.lineWidth=3;
    aLayer.frame = testView.bounds;
    [testView.layer addSublayer:aLayer];
    [self drawChangeAnimation:aLayer];
}

-(void)drawChangeAnimation:(CALayer *)layer
{
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath: @"strokeStart"];
    pathAnimation.duration = 5;
    pathAnimation.removedOnCompletion = NO;
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0];
    pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionLinear];
    [layer addAnimation: pathAnimation forKey: @"PathAnim"];
}

@end
