//
//  UIView+Material.h
//  Pods
//
//  Created by Eleven Chen on 15/8/27.
//
//

#import <UIKit/UIKit.h>

@interface UIView (Material)

/// Inflate the view using the color starting at point
- (void) inflateWithColor:(UIColor*) color atPoint:(CGPoint) point duration:(NSTimeInterval) duration completion:(void(^)())block;

/// No completion block
- (void) inflateWithColor:(UIColor*) color atPoint:(CGPoint) point duration:(NSTimeInterval) duration;

- (void) inflateWithColor:(UIColor*) color atPoint:(CGPoint) point;

- (void) deflateWithColor: (UIColor*) color atPoint:(CGPoint) point duration:(NSTimeInterval) duration completion:(void(^)())block;

- (void) deflateWithColor: (UIColor*) color atPoint:(CGPoint) point duration:(NSTimeInterval) duration;

- (void) deflateWithColor: (UIColor*) color atPoint:(CGPoint) point;

@end
