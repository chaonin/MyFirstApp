//
//  BaseViewController.m
//  MyFirstApp
//
//  Created by 郭超年 on 16/7/12.
//  Copyright © 2016年 chaonin. All rights reserved.
//

#import "BaseViewController.h"
#import "KetangUtility.h"
#import "UIButton+Ketang.h"

@interface BaseViewController ()

@property (nonatomic, strong)UIActivityIndicatorView *loading;//非阻塞加载

@property (nonatomic, strong)UIView *modal;//阻塞加载

@end

@implementation BaseViewController

-(void)navigationBack{
 
    if (self.navigationController != nil) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)setBackButton{
    
    UIButton *button = [UIButton navigationBackButtonWithTitle:@"返回" target:self action:@selector(navigationBack)];
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    UIBarButtonItem *offset = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                            target:nil
                                                                            action:nil];
    CGFloat buttonOffset;
    if ([KetangUtility screenWidth] >= 414) {
        //iphone 6+, iphone6S+
        buttonOffset = -12;
    } else {
        //其他设备
        buttonOffset = -8;
    }
    offset.width = buttonOffset;
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:offset, barButton, nil];

}

-(void)setLeftNavigationButtonWithTitle:(NSString *)title target:(id)target action:(SEL)action{
    
    UIButton *button = [UIButton navigationButtonWithTitle:title target:target action:action];
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    UIBarButtonItem *offset = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                            target:nil
                                                                            action:nil];
    CGFloat buttonOffset;
    if ([KetangUtility screenWidth] >= 414) {
        //iphone 6+, iphone6S+
        buttonOffset = -12;
    } else {
        //其他设备
        buttonOffset = -8;
    }
    offset.width = buttonOffset;
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:offset, barButton, nil];
    
}
-(void)setRightNavigationButtonWithTitle:(NSString *)title target:(id)target action:(SEL)action{
    
    UIButton *button = [UIButton navigationButtonWithTitle:title target:target action:action];
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    UIBarButtonItem *offset = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                            target:nil
                                                                            action:nil];
    CGFloat buttonOffset;
    if ([KetangUtility screenWidth] >= 414) {
        //iphone 6+, iphone6S+
        buttonOffset = -12;
    } else {
        //其他设备
        buttonOffset = -8;
    }
    offset.width = buttonOffset;
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:offset, barButton, nil];
}


-(void)showAlertWithTitle:(NSString *)title message:(NSString *)message buttonText:(NSString *)buttonText{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:buttonText
                                                     style:UIAlertActionStyleDefault
                                                   handler:nil];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
    
}


-(void)showModaLoading{
    
    if (self.modal == nil) {
        //黑色遮罩
        self.modal = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [KetangUtility screenWidth], [KetangUtility screenHeight])];
        self.modal.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];

    }
    
    //更黑的圆角矩形
    UIView *black = [[UIView alloc] initWithFrame:CGRectMake(([KetangUtility screenWidth]-80)/2, ([KetangUtility screenHeight]-80)/2, 80, 80)];
    black.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    black.layer.cornerRadius = 12;
    black.layer.masksToBounds = YES;
    [self.modal addSubview:black];

    //白色加载动画
    UIActivityIndicatorView *modalLoading = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(([KetangUtility screenWidth]-80)/2, ([KetangUtility screenHeight]-80)/2, 80, 80)];
    modalLoading.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    [self.modal addSubview:modalLoading];
    [modalLoading startAnimating];
    
    //把阻塞加载呈现给用户
    UIWindow *window = [UIApplication sharedApplication].windows[0];
    [window addSubview:self.modal];

}
-(void)hideModaLoading{

    [self.modal removeFromSuperview];
}


-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{

    //如果导航控制器上只有一个页面，就不需要手势识别
    if (self.navigationController.viewControllers.count == 1) {
        return NO;
    }
    //其他情况则需要
    return YES;
}

-(void)showLoading{
    
    if (self.loading == nil) {
        self.loading = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(([KetangUtility screenWidth]-20)/2, ([KetangUtility screenHeight]-20)/2, 20, 20)];
        self.loading.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    }
    [self.loading startAnimating];
    [self.view addSubview:self.loading];
    
}
-(void)hideLoading{

    [self.loading stopAnimating];
    [self.loading removeFromSuperview];
    
}

-(void)setSingleLineTitle:(NSString *)title {
    
    //自定义导航栏标题
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 44)];
    titleLabel.text = title;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:17];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.backgroundColor = [UIColor clearColor];
    self.navigationItem.titleView = titleLabel;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //class 12: restuct the inheriment

    //自定义背景颜色
    UIColor *gray = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    self.view.backgroundColor = gray;
    
    //自定义导航栏背景颜色
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.2 green:0.72 blue:0.46 alpha:1];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    [self.navigationItem setHidesBackButton:YES];
    
    //自动调整可滚动视图显示设置为NO（将变为上对齐）
    self.automaticallyAdjustsScrollViewInsets = NO;
  
        
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
