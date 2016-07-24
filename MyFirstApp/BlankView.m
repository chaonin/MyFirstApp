//
//  BlankView.m
//  MyFirstApp
//
//  Created by 郭超年 on 16/7/24.
//  Copyright © 2016年 chaonin. All rights reserved.
//

#import "BlankView.h"
#import "KetangUtility.h"

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
    
    UIButton *writeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    NSString *writeText = buttonText;
    [writeButton setTitle:writeText forState:UIControlStateNormal];
    [writeButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    UIFont *writeButtonFont = [UIFont systemFontOfSize:14];
    writeButton.titleLabel.font = writeButtonFont;
    //Button的圆角设置
    writeButton.layer.cornerRadius = 5;//圆角半径
    writeButton.layer.borderWidth = 1;//按钮边框粗细
    writeButton.layer.borderColor = [UIColor grayColor].CGColor;
    writeButton.layer.masksToBounds = YES;//圆角范围外的部分剪切不现实
    CGSize writeButtonSize = CGSizeMake([KetangUtility screenWidth], 29);//按钮高度29
    NSDictionary *writeButtonAttributes = [NSDictionary dictionaryWithObjectsAndKeys:writeButton.titleLabel.font,NSFontAttributeName,nil];
    CGRect writeButtonRect = [writeText boundingRectWithSize:writeButtonSize
                                                     options:kNilOptions
                                                  attributes:writeButtonAttributes
                                                     context:nil];
    CGFloat plannedWriteButtonWidth = writeButtonRect.size.width + 8 + 8;//按钮两边宽度留白8
    if (plannedWriteButtonWidth < 55) {
        plannedWriteButtonWidth = 55;//按钮宽度最小为55
    }
    [writeButton setFrame:CGRectMake(([KetangUtility screenWidth]-plannedWriteButtonWidth)/2, (blankView.frame.size.height-29)/2+20, plannedWriteButtonWidth, 29)];//按钮高度29
    [writeButton addTarget:target
                    action:action
          forControlEvents:UIControlEventTouchUpInside];
    [blankView addSubview:writeButton];
    
    return blankView;
    
}

@end
