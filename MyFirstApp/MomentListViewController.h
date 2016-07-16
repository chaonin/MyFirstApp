//
//  MomentListViewController.h
//  MyFirstApp
//
//  Created by 郭超年 on 16/7/14.
//  Copyright © 2016年 chaonin. All rights reserved.
//

#import "BaseViewController.h"



//@interface MomentListViewController : BaseViewController

//协议约定

                                                        // 数据源协议           ， 代理协议
@interface MomentListViewController : BaseViewController<UITableViewDataSource, UITableViewDelegate>

@end
