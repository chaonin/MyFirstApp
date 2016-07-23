//
//  MomentCell.h
//  MyFirstApp
//
//  Created by 郭超年 on 16/7/15.
//  Copyright © 2016年 chaonin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MomentCell : UITableViewCell

+(MomentCell*)prepareCellForTableView:(UITableView *)tableView;

-(void)setContentWithDictionary:(NSDictionary *)dictionary;

+(CGFloat)cellHeightFromText:(NSString *) text;

@end
