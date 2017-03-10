//
//  UIView+Extension.m
//  环信Demo
//
//  Created by 邝子涵 on 2017/2/27.
//  Copyright © 2017年 邝子涵. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)
- (void)setX:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x {
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y {
    return self.frame.origin.y;
}

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (void)setCenterX:(CGFloat)centerX {
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY {
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY {
    return self.center.y;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size {
    return self.frame.size;
}

- (void)borderViewStyleWithCornerRadius:(CGFloat)cornerRadius withColor:(UIColor *)color {
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = cornerRadius;
    self.layer.borderWidth = 0.5;
    self.layer.borderColor = color.CGColor;
}

- (void)hiddenWith:(BOOL)ishidden withDuration:(CGFloat)duration{
    CATransition *animation = [CATransition animation];
    animation.type = kCATransitionFade;
    animation.duration = duration;
    [self.layer addAnimation:animation forKey:nil];
    self.hidden = ishidden;
}


- (void)addLongLine:(CGFloat)y{
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, y, SCREEN_WIDTH, 0.5)];
    lineView.backgroundColor = KZH_Line_Gray;
    [self addSubview:lineView];
}


- (void)addLine:(CGFloat)y{
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(5, y, SCREEN_WIDTH - 10, 0.5)];
    lineView.backgroundColor = KZH_Line_Gray;
    [self addSubview:lineView];
}



@end
