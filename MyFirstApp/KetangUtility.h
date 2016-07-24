//
//  KetangUtility.h
//  MyFirstApp
//
//  Created by 郭超年 on 16/7/17.
//  Copyright © 2016年 chaonin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface KetangUtility : NSObject

+(NSNumber *)timestamp;
+(NSMutableDictionary *)dateThen:(NSNumber *)timestamp;

+(CGFloat)screenWidth;
+(CGFloat)screenHeight;

@end
