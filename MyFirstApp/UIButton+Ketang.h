//
//  UIButton+Ketang.h
//  MyFirstApp
//
//  Created by 郭超年 on 16/7/27.
//  Copyright © 2016年 chaonin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Ketang)

+(UIButton *)contentButtonWithTitle:(NSString *)title target:(id)target action:(SEL)action;

+(UIButton *)navigationButtonWithTitle:(NSString *)title target:(id)target action:(SEL)action;

+(UIButton *)navigationBackButtonWithTitle:(NSString *)title target:(id)target action:(SEL)action;


@end
