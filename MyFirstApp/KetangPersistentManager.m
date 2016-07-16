//
//  KetangPersistentManager.m
//  MyFirstApp
//
//  Created by 郭超年 on 16/7/16.
//  Copyright © 2016年 chaonin. All rights reserved.
//

#import "KetangPersistentManager.h"

@implementation KetangPersistentManager

+(id)getMoment{

    NSArray *docsDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *dirPath = docsDir[0];
    NSString *dataFilePath = [[NSString alloc] initWithString:[dirPath stringByAppendingString:@"moment"]];
    
    NSFileManager *manager = [NSFileManager defaultManager];
    
    @try {
        BOOL fileExist = [manager fileExistsAtPath:dataFilePath];
        if (fileExist) {
            //返回读取到的结果
            NSArray *moment = [NSKeyedUnarchiver unarchiveObjectWithFile:dataFilePath];
            return moment;
        } else {
            //返回空数组
            NSArray *moment =[[NSArray alloc] init];
            return moment;
        }
    } @catch (NSException *exception) {
        return nil;
    } @finally {
        //什么都不做
    }
}

+(BOOL)saveMoment:(NSArray *) moment{
    
    NSArray *docsDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *dirPath = docsDir[0];
    NSString *dataFilePath = [[NSString alloc] initWithString:[dirPath stringByAppendingString:@"moment"]];
    
    NSFileManager *manager = [NSFileManager defaultManager];
    
    @try {
        BOOL saveSuccess = [NSKeyedArchiver archiveRootObject:moment toFile:dataFilePath];
        return saveSuccess;
    } @catch (NSException *exception) {
        return NO;
    } @finally {
        //什么都不做
    }

}

@end
