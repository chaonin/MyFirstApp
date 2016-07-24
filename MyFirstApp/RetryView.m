//
//  RetryView.m
//  MyFirstApp
//
//  Created by 郭超年 on 16/7/24.
//  Copyright © 2016年 chaonin. All rights reserved.
//

#import "RetryView.h"
#import "KetangUtility.h"

@implementation RetryView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+(RetryView *)retryViewWithText:(NSString *)text buttonText:(NSString *)buttonText target:(id)target action:(SEL)action{
    
    
    RetryView *retryView = [[RetryView alloc] initWithFrame:CGRectMake(0, 64,[KetangUtility screenWidth], [KetangUtility screenHeight]-64)];
    UILabel *retryLabel = [[UILabel alloc] initWithFrame:CGRectMake(([KetangUtility screenWidth]-100)/2, (retryView.frame.size.height-100)/2-20, 100, 100)];
    retryLabel.text = text;
    retryLabel.textColor = [UIColor grayColor];
    retryLabel.textAlignment = NSTextAlignmentCenter;
    retryLabel.font = [UIFont systemFontOfSize:17];
    [retryView addSubview:retryLabel];
    
    UIButton *retryButton = [UIButton buttonWithType:UIButtonTypeCustom];
    NSString *retryText = buttonText;
    [retryButton setTitle:retryText forState:UIControlStateNormal];
    [retryButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    UIFont *retryButtonFont = [UIFont systemFontOfSize:14];
    retryButton.titleLabel.font = retryButtonFont;
    //Button的圆角设置
    retryButton.layer.cornerRadius = 5;//圆角半径
    retryButton.layer.borderWidth = 1;//按钮边框粗细
    retryButton.layer.borderColor = [UIColor grayColor].CGColor;
    retryButton.layer.masksToBounds = YES;//圆角范围外的部分剪切不现实
    CGSize retryButtonSize = CGSizeMake([KetangUtility screenWidth], 29);//按钮高度29
    NSDictionary *retryButtonAttributes = [NSDictionary dictionaryWithObjectsAndKeys:retryButton.titleLabel.font,NSFontAttributeName,nil];
    CGRect retryButtonRect = [retryText boundingRectWithSize:retryButtonSize
                                                     options:kNilOptions
                                                  attributes:retryButtonAttributes
                                                     context:nil];
    CGFloat plannedRetryButtonWidth = retryButtonRect.size.width + 8 + 8;//按钮两边宽度留白8
    if (plannedRetryButtonWidth < 55) {
        plannedRetryButtonWidth = 55;//按钮宽度最小为55
    }
    [retryButton setFrame:CGRectMake(([KetangUtility screenWidth]-plannedRetryButtonWidth)/2, (retryView.frame.size.height-29)/2+20, plannedRetryButtonWidth, 29)];//按钮高度29
    [retryButton addTarget:target
                    action:action
          forControlEvents:UIControlEventTouchUpInside];
    [retryView addSubview:retryButton];
    
    return retryView;
    
}

@end
