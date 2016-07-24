//
//  BlankView.h
//  MyFirstApp
//
//  Created by 郭超年 on 16/7/24.
//  Copyright © 2016年 chaonin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BlankView : UIView

+(BlankView *)blankViewWithText:(NSString *)text buttonText:(NSString *)buttonText target:(id)target action:(SEL)action;

@end
