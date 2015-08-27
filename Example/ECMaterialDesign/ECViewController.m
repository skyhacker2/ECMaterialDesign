//
//  ECViewController.m
//  ECMaterialDesign
//
//  Created by Eleven Chen on 08/27/2015.
//  Copyright (c) 2015 Eleven Chen. All rights reserved.
//

#import "ECViewController.h"
#import <ECMaterialDesign/ECMaterial.h>

@interface ECViewController ()
@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *view2;

@end

@implementation ECViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    UITapGestureRecognizer* tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self.view addGestureRecognizer:tapGestureRecognizer];
}

- (void)tap:(UITapGestureRecognizer*) recognizer
{
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        CGPoint point = [recognizer locationInView:self.view];
        if (CGRectContainsPoint(self.view1.frame, point)) {
            CGPoint pt = [self.view convertPoint:point toView:self.view1];
            [self.view1 inflateWithColor:[self randomColor] atPoint:pt duration:0.5 completion:^(){NSLog(@"completed");}];
        }
        if (CGRectContainsPoint(self.view2.frame, point)) {
            CGPoint pt = [self.view convertPoint:point toView:self.view2];
            [self.view2 deflateWithColor:[self randomColor] atPoint:pt];
        }
    }
}

- (UIColor*) randomColor
{
    CGFloat r = (rand() % 255) / 255.0f;
    CGFloat g = (rand() % 255) / 255.0f;
    CGFloat b = (rand() % 255) / 255.0f;
    return [UIColor colorWithRed:r green:g blue:b alpha:1];
}

@end
