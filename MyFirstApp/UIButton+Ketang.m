//
//  UIButton+Ketang.m
//  MyFirstApp
//
//  Created by 郭超年 on 16/7/27.
//  Copyright © 2016年 chaonin. All rights reserved.
//

#import "UIButton+Ketang.h"
#import "KetangUtility.h"
#import "UIImage+Ketang.h"

@implementation UIButton (Ketang)

+(UIButton *)navigationButtonWithTitle:(NSString *)title target:(id)target action:(SEL)action{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    UIFont *buttonFont = [UIFont systemFontOfSize:14];
    button.titleLabel.font = buttonFont;
    
    //图片拉伸
    UIEdgeInsets stretch = UIEdgeInsetsMake(0, 8, 0, 8);
    UIImage *normalImage = [UIImage imageNamed:@"common_button_navigation_normal"];
    normalImage = [normalImage resizableImageWithCapInsets:stretch resizingMode:UIImageResizingModeStretch];
    [button setBackgroundImage:normalImage forState:UIControlStateNormal];
    
    
    UIImage *activeImage = [UIImage imageNamed:@"common_button_navigation_active"];
    activeImage = [activeImage resizableImageWithCapInsets:stretch resizingMode:UIImageResizingModeStretch];
    [button setBackgroundImage:activeImage forState:UIControlStateHighlighted];
    
    
    CGSize buttonSize = CGSizeMake([KetangUtility screenWidth], 29);//按钮高度29
    NSDictionary *buttonAttributes = [NSDictionary dictionaryWithObjectsAndKeys:button.titleLabel.font,NSFontAttributeName,nil];
    CGRect buttonRect = [title boundingRectWithSize:buttonSize
                                            options:kNilOptions
                                         attributes:buttonAttributes
                                            context:nil];
    
    CGFloat plannedButtonWidth = buttonRect.size.width + 8 + 8;
    if (plannedButtonWidth < 55) {
        plannedButtonWidth = 55;//按钮宽度最小为55
    }
    [button setFrame:CGRectMake(0, 0, plannedButtonWidth, 29)];//按钮高度29
    [button addTarget:target
               action:action
     forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

+(UIButton *)navigationBackButtonWithTitle:(NSString *)title target:(id)target action:(SEL)action{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    UIFont *buttonFont = [UIFont systemFontOfSize:14];
    button.titleLabel.font = buttonFont;
    
    //文字左边多留白
    UIEdgeInsets padding = UIEdgeInsetsMake(0, 7, 0, 0);
    button.contentEdgeInsets = padding;
    
    //图片拉伸
    UIEdgeInsets stretch = UIEdgeInsetsMake(0, 15, 0, 8);
    UIImage *normalImage = [UIImage imageNamed:@"common_button_back_normal"];
    normalImage = [normalImage resizableImageWithCapInsets:stretch resizingMode:UIImageResizingModeStretch];
    [button setBackgroundImage:normalImage forState:UIControlStateNormal];
    
    
    UIImage *activeImage = [UIImage imageNamed:@"common_button_back_active"];
    activeImage = [activeImage resizableImageWithCapInsets:stretch resizingMode:UIImageResizingModeStretch];
    [button setBackgroundImage:activeImage forState:UIControlStateHighlighted];
    
    
    CGSize buttonSize = CGSizeMake([KetangUtility screenWidth], 29);//按钮高度29
    NSDictionary *buttonAttributes = [NSDictionary dictionaryWithObjectsAndKeys:button.titleLabel.font,NSFontAttributeName,nil];
    CGRect buttonRect = [title boundingRectWithSize:buttonSize
                                            options:kNilOptions
                                         attributes:buttonAttributes
                                            context:nil];
    
    //按钮宽度计算方法改变，因为左侧留白是15，而不是8
    CGFloat plannedButtonWidth = buttonRect.size.width + 15 + 8;
    if (plannedButtonWidth < 55) {
        plannedButtonWidth = 55;//按钮宽度最小为55
    }
    [button setFrame:CGRectMake(0, 0, plannedButtonWidth, 29)];//按钮高度29
    [button addTarget:target
               action:action
     forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}


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

    UIImage *activeImage = [UIImage imageWithColor:[UIColor grayColor] andSize:button.frame.size];
    [button setBackgroundImage:activeImage forState:UIControlStateHighlighted];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    
    [button addTarget:target
               action:action
     forControlEvents:UIControlEventTouchUpInside];
    
    return button;
    
}

@end
