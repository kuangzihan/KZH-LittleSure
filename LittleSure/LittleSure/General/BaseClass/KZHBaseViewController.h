//
//  KZHBaseViewController.h
//  环信Demo
//
//  Created by 邝子涵 on 2017/2/24.
//  Copyright © 2017年 邝子涵. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KZHBaseViewController : UIViewController

/**
 *  Nav 标题
 *
 *  此属性为自定义默认nav标题16号字体（51，51，51，1）色，
 *  如特殊页面需改变 Nav背景色 & 字体 & 颜色 请调用
 *  - (void)baseVC_layoutNavigationBar:(UIImage *)backGroundImage titleColor:(UIColor *)titleColor titleFont:(UIFont *)titleFont
 */
@property (nonatomic, weak) UILabel *titleLabel;


// 改变状态栏颜色(白色)
- (void)baseVC_changeStatusBarWhite;
// 改变状态栏颜色(黑色)
- (void)baseVC_changeStatusBarBlack;
// 删除返回按钮
- (void)base_removeLiftBarButton;

@end
