//
//  UIButton+Ketang.m
//  MyFirstApp
//
//  Created by 郭超年 on 16/7/27.
//  Copyright © 2016年 chaonin. All rights reserved.
//

#import "UIButton+Ketang.h"
#import "KetangUtility.h"

@implementation UIButton (Ketang)

+(UIButton *)contentButtonWithTitle:(NSString *)title target:(id)target action:(SEL)action{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    UIFont *buttonFont = [UIFont systemFontOfSize:14];
    button.titleLabel.font = buttonFont;
    //Button的圆角设置
    button.layer.cornerRadius = 5;//圆角半径
    button.layer.borderWidth = 1;//按钮边框粗细
    button.layer.borderColor = [UIColor grayColor].CGColor;
    button.layer.masksToBounds = YES;//圆角范围外的部分剪切不现实
    
    CGSize buttonSize = CGSizeMake([KetangUtility screenWidth], 29);//按钮高度29
    NSDictionary *buttonAttributes = [NSDictionary dictionaryWithObjectsAndKeys:button.titleLabel.font,NSFontAttributeName,nil];
    CGRect buttonRect = [title boundingRectWithSize:buttonSize
                                            options:kNilOptions
                                         attributes:buttonAttributes
                                            context:nil];
    CGFloat plannedButtonWidth = buttonRect.size.width + 8 + 8;//按钮两边宽度留白8
    if (plannedButtonWidth < 55) {
        plannedButtonWidth = 55;//按钮宽度最小为55
    }
    [button setFrame:CGRectMake(0, 0, plannedButtonWidth, 29)];//按钮高度29
    [button addTarget:target
               action:action
     forControlEvents:UIControlEventTouchUpInside];
    
    return button;
    
}

@end
