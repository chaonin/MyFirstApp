//
//  UIImage+Ketang.m
//  MyFirstApp
//
//  Created by 郭超年 on 16/7/27.
//  Copyright © 2016年 chaonin. All rights reserved.
//

#import "UIImage+Ketang.h"

@implementation UIImage (Ketang)

+(UIImage *)imageWithColor:(UIColor*)color andSize:(CGSize)size {

    UIGraphicsBeginImageContext(size);
    [color set];
    UIRectFill(CGRectMake(0, 0, size.width*[UIScreen mainScreen].scale, size.height*[UIScreen mainScreen].scale));
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
