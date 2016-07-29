//
//  BaseViewController.h
//  MyFirstApp
//
//  Created by 郭超年 on 16/7/12.
//  Copyright © 2016年 chaonin. All rights reserved.
//

#import <UIKit/UIKit.h>

//7/26: 签署手势识别协议
@interface BaseViewController : UIViewController<UIGestureRecognizerDelegate>

//驼峰命名法: 第一个单词首字母小写，其他单词首字母大写
-(void)setSingleLineTitle:(NSString *)title;
-(void)showLoading;
-(void)hideLoading;

-(void)showModaLoading;
-(void)hideModaLoading;

-(void)showAlertWithTitle:(NSString *)title message:(NSString *)message buttonText:(NSString *)buttonText;

-(void)setBackButton;
-(void)setLeftNavigationButtonWithTitle:(NSString *)title target:(id)target action:(SEL)action;
-(void)setRightNavigationButtonWithTitle:(NSString *)title target:(id)target action:(SEL)action;


@end
