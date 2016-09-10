//
//  PostMomentViewController.h
//  MyFirstApp
//
//  Created by 郭超年 on 16/7/16.
//  Copyright © 2016年 chaonin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

//遵从UITextViewDeledate代理协议
@interface PostMomentViewController : BaseViewController<UITextViewDelegate>

-(PostMomentViewController *)initWithDictionary:(NSDictionary*)dictionary;

@end
