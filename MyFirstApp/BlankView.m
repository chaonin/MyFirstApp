//
//  BlankView.m
//  MyFirstApp
//
//  Created by 郭超年 on 16/7/24.
//  Copyright © 2016年 chaonin. All rights reserved.
//

#import "BlankView.h"
#import "KetangUtility.h"
#import "UIButton+Ketang.h"

@implementation BlankView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+(BlankView *)blankViewWithText:(NSString *)text buttonText:(NSString *)buttonText target:(id)target action:(SEL)action{

    
    BlankView *blankView = [[BlankView alloc] initWithFrame:CGRectMake(0, 64,[KetangUtility screenWidth], [KetangUtility screenHeight]-64)];
    UILabel *blankLabel = [[UILabel alloc] initWithFrame:CGRectMake(([KetangUtility screenWidth]-100)/2, (blankView.frame.size.height-100)/2-20, 100, 100)];
    blankLabel.text = text;
    blankLabel.textColor = [UIColor grayColor];
    blankLabel.textAlignment = NSTextAlignmentCenter;
    blankLabel.font = [UIFont systemFontOfSize:17];
    [blankView addSubview:blankLabel];
    
    UIButton *writeButton =[UIButton contentButtonWithTitle:buttonText target:target action:action];
    
    CGFloat writeButtonX = ([KetangUtility screenWidth] - writeButton.frame.size.width)/2;
    CGFloat writeButtonY = (blankView.frame.size.height-writeButton.frame.size.height)/2  + 20;
    [writeButton setFrame:CGRectMake(writeButtonX, writeButtonY, writeButton.frame.size.width, writeButton.frame.size.height)];
    
    [blankView addSubview:writeButton];
    
    return blankView;
    
}

@end
