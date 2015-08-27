//
//  UIView+Material.m
//  Pods
//
//  Created by Eleven Chen on 15/8/27.
//
//

#import "UIView+Material.h"
#define DURATION 0.5
@implementation UIView (Material)

#pragma mark - public methods
- (void) inflateWithColor:(UIColor*) color atPoint:(CGPoint) point duration:(NSTimeInterval) duration completion:(void(^)())block
{
    self.layer.masksToBounds = YES;
    // Calulate the min radius
    CGFloat radius = [self minRadus:point];
    NSLog(@"radius %f", radius);
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = CGRectMake(point.x - radius, point.y - radius, radius*2, radius*2);
    shapeLayer.path = [UIBezierPath bezierPathWithOvalInRect:shapeLayer.bounds].CGPath;
    shapeLayer.fillColor = color.CGColor;
    [self.layer addSublayer:shapeLayer];
    
    // Animation
    CABasicAnimation *animation = [CABasicAnimation animation];
    float scale = 1.0f / shapeLayer.frame.size.width;
    animation.keyPath = @"transform";
    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 1, 1)];
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(scale, scale, 1)];
    animation.duration = duration;
    animation.removedOnCompletion = YES;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    [CATransaction begin];
    [CATransaction setCompletionBlock:^{
        [shapeLayer removeFromSuperlayer];
        self.backgroundColor = color;
        if (block) {
            block();
        }
    }];
    [shapeLayer addAnimation:animation forKey:nil];
    [CATransaction commit];
}

- (void) inflateWithColor:(UIColor*) color atPoint:(CGPoint) point duration:(NSTimeInterval) duration
{
    [self inflateWithColor:color atPoint:point duration:duration completion:nil];
}

- (void) inflateWithColor:(UIColor*) color atPoint:(CGPoint) point
{
    [self inflateWithColor:color atPoint:point duration:DURATION];
}

- (void) deflateWithColor: (UIColor*) color atPoint:(CGPoint) point duration:(NSTimeInterval) duration completion:(void(^)())block
{
    self.layer.masksToBounds = YES;
    
    // Calulate the min radius
    CGFloat radius = [self minRadus:point];
    NSLog(@"radius %f", radius);
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = CGRectMake(point.x - radius, point.y - radius, radius*2, radius*2);
    shapeLayer.path = [UIBezierPath bezierPathWithOvalInRect:shapeLayer.bounds].CGPath;
    shapeLayer.fillColor = self.backgroundColor.CGColor;
    self.backgroundColor = color;
    [self.layer addSublayer:shapeLayer];
    
    // Animation
    CABasicAnimation *animation = [CABasicAnimation animation];
    float scale = 1.0f / shapeLayer.frame.size.width;
    animation.keyPath = @"transform";
    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(scale, scale, 1)];
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 1, 1)];
    animation.duration = duration;
    animation.removedOnCompletion = YES;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    [CATransaction begin];
    [CATransaction setCompletionBlock:^{
        [shapeLayer removeFromSuperlayer];
        self.backgroundColor = color;
        if (block) {
            block();
        }
    }];
    [shapeLayer addAnimation:animation forKey:nil];
    [CATransaction commit];

}

- (void) deflateWithColor: (UIColor*) color atPoint:(CGPoint) point duration:(NSTimeInterval) duration
{
    [self deflateWithColor:color atPoint:point duration:DURATION completion:nil];
}

- (void) deflateWithColor: (UIColor*) color atPoint:(CGPoint) point
{
    [self deflateWithColor:color atPoint:point duration:DURATION];
}

#pragma mark - private methods

- (CGFloat) minRadus:(CGPoint) point
{
    CGPoint points[] = {{0,0}, {0, self.bounds.size.height}, {self.bounds.size.width, self.bounds.size.height}, {self.bounds.size.width, 0}};
    CGFloat radius = 0;
    for (int i = 0; i < 4; i++) {
        CGPoint pt = points[i];
        CGFloat dis = sqrt(pow(pt.x - point.x, 2) + pow(pt.y - point.y, 2));
        if (dis > radius) {
            radius = dis;
        }
    }
    return radius+0.5;
}

@end
