//
//  MomentCell.m
//  MyFirstApp
//
//  Created by 郭超年 on 16/7/15.
//  Copyright © 2016年 chaonin. All rights reserved.
//

#import "MomentCell.h"

@interface MomentCell()

@property(strong, nonatomic) UILabel *dayLabel;
@property(strong, nonatomic) UILabel *dayOfWeekLabel;
@property(strong, nonatomic) UILabel *yearAndMonthLabel;
@property(strong, nonatomic) UILabel *contentLabel;


@end

@implementation MomentCell

+(CGFloat)contentHeigh:(NSString *) text{
    
    CGSize size = CGSizeMake(240, 999999);
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:15],
                                NSFontAttributeName, nil];
    
    CGRect rect = [text boundingRectWithSize:size
                                     options:NSStringDrawingTruncatesLastVisibleLine|
                   NSStringDrawingUsesLineFragmentOrigin|
                   NSStringDrawingUsesFontLeading
                                  attributes:attributes
                                     context:nil];
    CGFloat height = rect.size.height;
    return height;
}

+(CGFloat)cellHeightFromText:(NSString *) text{

    CGFloat height = [MomentCell contentHeigh:text];
    CGFloat plannedHeight = height + 70 + 70; //上下留白70像素
    if(plannedHeight > 200) {
        return plannedHeight;
    }
    return 200;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    /*
    UILabel *dayLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 16, 47, 46)];
    dayLabel.textColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.3];
    dayLabel.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:40];
    dayLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:dayLabel];
    
    UILabel *dayOfWeekLabel = [[UILabel alloc] initWithFrame:CGRectMake(52, 23, 36, 15)];
    dayOfWeekLabel.textColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.3];
    dayOfWeekLabel.font = [UIFont systemFontOfSize:12];
    dayOfWeekLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:dayOfWeekLabel];
    
    UILabel *yearAndMonthLabel = [[UILabel alloc] initWithFrame:CGRectMake(52, 38, 60, 15)];
    yearAndMonthLabel.textColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.3];
    yearAndMonthLabel.font = [UIFont systemFontOfSize:12];
    yearAndMonthLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:yearAndMonthLabel];
    
    UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-240)/2, 79, 240, 42)];
    contentLabel.textColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.3];
    contentLabel.font = [UIFont systemFontOfSize:15];
    contentLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:contentLabel];*/
    
    //reconstruction 16/7/16 chaonin
    self.dayLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 16, 47, 46)];
    self.dayLabel.textColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.3];
    self.dayLabel.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:40];
    self.dayLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.dayLabel];
    
    self.dayOfWeekLabel = [[UILabel alloc] initWithFrame:CGRectMake(52, 23, 36, 15)];
    self.dayOfWeekLabel.textColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.3];
    self.dayOfWeekLabel.font = [UIFont systemFontOfSize:12];
    self.dayOfWeekLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.dayOfWeekLabel];
    
    self.yearAndMonthLabel = [[UILabel alloc] initWithFrame:CGRectMake(52, 38, 60, 15)];
    self.yearAndMonthLabel.textColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.3];
    self.yearAndMonthLabel.font = [UIFont systemFontOfSize:12];
    self.yearAndMonthLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.yearAndMonthLabel];
    
    //self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-240)/2, 79, 240, 42)];
    self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0,0,0)];
    self.contentLabel.textColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.3];
    self.contentLabel.font = [UIFont systemFontOfSize:15];
    self.contentLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.contentLabel];

    return self;
    
}

+(MomentCell*)prepareCellForTableView:(UITableView *)tableView{
    
    MomentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"moment"];
    
    if(cell == nil){
    
        cell = [[MomentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"moment"];
    }
    
    return cell;

}

-(void)setContentWithDictionary:(NSDictionary *)dictionary{
    
    self.dayLabel.text = [dictionary objectForKey:@"day"];
    self.dayOfWeekLabel.text = [dictionary objectForKey:@"dayOfWeek"];
    self.yearAndMonthLabel.text = [dictionary objectForKey:@"yearAndMonth"];
    self.contentLabel.text = [dictionary objectForKey:@"content"];
    
    CGFloat contentHeight = [MomentCell contentHeigh:self.contentLabel.text];
    CGFloat cellHeight = [MomentCell cellHeightFromText:self.contentLabel.text];
    CGRect rect = CGRectMake(([UIScreen mainScreen].bounds.size.width-240)/2, (cellHeight-contentHeight)/2, 240, contentHeight);
    [self.contentLabel setFrame:rect];

}

@end
