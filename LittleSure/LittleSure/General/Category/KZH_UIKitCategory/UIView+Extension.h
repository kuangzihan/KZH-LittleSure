//
//  UIView+Extension.h
//  环信Demo
//
//  Created by 邝子涵 on 2017/2/27.
//  Copyright © 2017年 邝子涵. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

// 设置圆角
- (void)borderViewStyleWithCornerRadius:(CGFloat)cornerRadius withColor:(UIColor *)color;
// 隐藏view动画
- (void)hiddenWith:(BOOL)ishidden withDuration:(CGFloat)duration;
// 长线
- (void)addLongLine:(CGFloat)y;
// 断线
- (void)addLine:(CGFloat)y;

@end
