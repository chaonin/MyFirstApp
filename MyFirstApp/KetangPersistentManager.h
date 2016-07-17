//
//  KetangPersistentManager.h
//  MyFirstApp
//
//  Created by 郭超年 on 16/7/16.
//  Copyright © 2016年 chaonin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KetangPersistentManager : NSObject

+(id)getMoment;
+(BOOL)saveDictionary:(NSDictionary *)dictionary;

@end
