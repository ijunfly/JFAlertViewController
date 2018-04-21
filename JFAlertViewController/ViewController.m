//
//  ViewController.m
//  JFAlertViewController
//
//  Created by apple on 2016/12/30.
//  Copyright © 2016年 JunFly. All rights reserved.
//

#import "ViewController.h"

#import "JFAlertViewController.h"

@interface ViewController ()<JFAlertViewDelegate, JFAlertViewDataSource>
@property (strong, nonatomic) JFAlertViewController *alertVC;
@property (strong, nonatomic) JFAlertViewController *alertSheetVC;
@property (strong, nonatomic) JFAlertViewController *alertColorVC;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.alertSheetVC = [JFAlertViewController new];
    self.alertSheetVC.delegate = self;
    self.alertSheetVC.dataSource = self;
    self.alertSheetVC.cancelTitle = @"取😇消";
    
}

#pragma JFAlertViewDataSource

- (NSUInteger)numberOfIndexsInJFAlertView:(JFAlertViewController *)alertView {
    return 3;
}

- (NSString *)JFAlertView:(JFAlertViewController *)alertView titleAtIndexNumber:(NSUInteger)index {
    return @[@"哈😀哈", @"大哥💃🏼", @"确认👩‍❤️‍💋‍👩"][index];
}

- (UIColor *)JFAlertView:(JFAlertViewController *)alertView colorAtIndexNumber:(NSUInteger)index {
    return [UIColor redColor];
}

#pragma JFAlertViewDelegate

- (void)JFAlertViewCancel:(JFAlertViewController *)alertView {
    NSLog(@"点击的 %@ 的 取消 按钮", alertView);
}

- (void)JFAlertView:(JFAlertViewController *)alertView clickedAtIndex:(NSUInteger)index {
    NSLog(@"点击的 %@ 的 %@ 按钮", alertView, alertView.actions[index+1].title);
}

#pragma action

- (IBAction)alertAction:(id)sender {
    [self presentViewController:self.alertColorVC animated:YES completion:^{
        NSLog(@"alertVC 的 completion block 方法");
    }];
}


- (IBAction)alertSheetAction:(id)sender {
    [self presentViewController:self.alertSheetVC animated:YES completion:^{
        NSLog(@"alertSheetVC 的 completion block 方法");
    }];
}

#pragma getting

- (JFAlertViewController *)alertVC {
    if (!_alertVC) {
        _alertVC = [JFAlertViewController alertViewWithTitle:@"提示框"
                                                     message:@"我是一个提示框, 这是我的显示消息"
                                              preferredStyle:UIAlertControllerStyleAlert
                                                cancelButton:@"我是取消按钮" cancelBlock:^(JFAlertViewController *alertView) {
            NSLog(@"点击了 %@ 的取消按钮", alertView);
        }
                                                actionButton:@[@"我是确认1⃣️", @"我是确认2⃣️"]
                                                 actionBlock:^(JFAlertViewController *alertView, NSUInteger index) {
            NSLog(@"点击了 %@ 的第%lu个确认按钮", alertView, (unsigned long)index+1);
        }];
    }
    return _alertVC;
}


- (JFAlertViewController *)alertColorVC {
    if (!_alertColorVC) {
        _alertColorVC = [JFAlertViewController alertViewWithTitle:@"提示框"
                                                          message:@"我是一个提示框, 这是我的显示消息"
                                                   preferredStyle:UIAlertControllerStyleAlert
                                                     cancelButton:@"我是取消按钮"
                                                      cancelColor:[UIColor redColor]
                                                      cancelBlock:^(JFAlertViewController *alertView) {
                                                          NSLog(@"点击了 %@ 的取消按钮", alertView);
                                                      }
                                                     actionButton:@[@"我是确认1⃣️", @"我是确认2⃣️"]
                                                      actionColors:@[[UIColor orangeColor], [UIColor grayColor]]
                                                      actionBlock:^(JFAlertViewController *alertView, NSUInteger index) {
                                                          NSLog(@"点击了 %@ 的第%lu个确认按钮", alertView, (unsigned long)index+1);
                                                      }];
    }
    return _alertColorVC;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
