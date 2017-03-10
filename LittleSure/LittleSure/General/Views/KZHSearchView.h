//
//  KZHSearchView.h
//  LittleSure
//
//  Created by 邝子涵 on 2017/3/6.
//  Copyright © 2017年 邝子涵. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^KZHSerchBlock)(NSString *searchResult);

@interface KZHSearchView : UIView<UITextFieldDelegate>
// 创建UITextField
@property (nonatomic, weak) UITextField *searTextF;

// 点击return搜索传值
@property (nonatomic, copy) KZHSerchBlock returnBlock;

// 设置placeholder
@property (nonatomic, copy) NSString *placeholder;

@property (nonatomic, copy) NSString *text;


// 默认初始化
+ (KZHSearchView *)defaultWithFrame:(CGRect)frame;


@end
