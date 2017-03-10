//
//  KZHSearchView.m
//  LittleSure
//
//  Created by 邝子涵 on 2017/3/6.
//  Copyright © 2017年 邝子涵. All rights reserved.
//

#import "KZHSearchView.h"

@implementation KZHSearchView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupTextF];
    }
    return self;
}

- (instancetype)initDefaultWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupTextF];
    }
    return self;
}


- (void)setupTextF {
    UITextField *searTextF = [[UITextField alloc] init];
    searTextF.textColor = KZH_Black;
    searTextF.font = KZHFONT_14;
    searTextF.keyboardType = UIKeyboardTypeDefault;
    searTextF.returnKeyType = UIReturnKeySearch;
    searTextF.autocorrectionType = UITextAutocorrectionTypeNo;
    searTextF.autocapitalizationType = UITextAutocapitalizationTypeNone;
    // 光标颜色
    searTextF.tintColor = KZH_Black;
    // 设置clearButton
    searTextF.clearsOnInsertion = YES;
    searTextF.clearButtonMode = UITextFieldViewModeAlways;
    searTextF.delegate = self;
    [self addSubview:searTextF];
    self.searTextF = searTextF;
    [searTextF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self).with.insets(UIEdgeInsetsMake(0, 10, 0, 10));
    }];
    
    
    [self addLongLine:0];
    
    [self addLongLine:KZHSearchViewH-0.5];
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    self.returnBlock(textField.text);
    [self.searTextF resignFirstResponder];
    return YES;
}


#pragma mark - 设置text
- (void)setText:(NSString *)text {
    if (_text != text) {
        _text = text;
    }
    self.searTextF.text = _text;
}



#pragma mark - 设置placeholder;
- (void)setPlaceholder:(NSString *)placeholder {
    if (_placeholder != placeholder) {
        _placeholder = placeholder;
    }
    self.searTextF.placeholder = _placeholder;
}


#pragma mark - 便利
+ (KZHSearchView *)defaultWithFrame:(CGRect)frame {
    return [[KZHSearchView alloc] initDefaultWithFrame:frame];
}


@end
