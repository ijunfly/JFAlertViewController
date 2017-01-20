//
//  JFAlertViewController.m
//  Tornado
//
//  Created by apple on 16/8/22.
//  Copyright © 2016年 JunFly. All rights reserved.
//

#import "JFAlertViewController.h"

@interface JFAlertViewController ()

@property (assign, nonatomic) NSUInteger items;

@end

@implementation JFAlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    __weak __typeof__ (self) wSelf = self;
    
    // 设置 取消按钮
    NSString *cancelTitle = @"取消";
    if (self.cancelTitle) {
        cancelTitle = self.cancelTitle;
    }
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        __strong __typeof__ (wSelf) sSelf = wSelf;
        if (sSelf.delegate && [sSelf.delegate respondsToSelector:@selector(JFAlertViewCancel:)]) {
            [sSelf.delegate JFAlertViewCancel:sSelf];
        } else if (sSelf.cancelBlock) {
            sSelf.cancelBlock(sSelf);
        }
    }];
    [self addAction:cancelAction];
    
    
    // 设置其他按钮
    if ((self.dataSource && [self.dataSource respondsToSelector:@selector(numberOfIndexsInJFAlertView:)])) {
        self.items = [self.dataSource numberOfIndexsInJFAlertView:self];
        self.defaultFirstTitle = nil;
        NSAssert(([self.dataSource respondsToSelector:@selector(JFAlertView:titleAtIndexNumber:)]), @"JFAlertViewController // dataSource 实现'numberOfIndexsInJFAlertView:'之后必须实现'JFAlertView:titleAtIndexNumber:'");
        
    } else if (self.defaultFirstTitle) {
        self.items = 1;
    } else {
        self.items = 0;
    }
    
    if (self.items == 0) {
        return;
    }

    for (int i = 0; i < self.items; i++) {
        NSString *title = (self.items == 1 && self.defaultFirstTitle) ? self.defaultFirstTitle : [self.dataSource JFAlertView:self titleAtIndexNumber:i];
        [self addAction:[UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            __strong __typeof__ (wSelf) sSelf = wSelf;
            if (sSelf.delegate && [sSelf.delegate respondsToSelector:@selector(JFAlertView:clickedAtIndex:)]) {
                [sSelf.delegate JFAlertView:sSelf clickedAtIndex:i];
            } else if (sSelf.clickedBlock) {
                sSelf.clickedBlock(sSelf, i);
            }
        }]];
    }
    
}

+ (instancetype)alertControllerWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(UIAlertControllerStyle)preferredStyle {
    //可以添加要写的
    return [super alertControllerWithTitle:title message:message preferredStyle:preferredStyle];
}

+ (JFAlertViewController *)alertViewWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(UIAlertControllerStyle)preferredStyle cancelAction:(NSString *)cancel cancelBlock:(void (^)(JFAlertViewController *alertView))cancelBlock defaultButton:(NSString *)defaultText defaultBlock:(void (^)(JFAlertViewController *alertView, NSUInteger index))clickBlock {
    JFAlertViewController *doneBaseAlertView = [JFAlertViewController alertControllerWithTitle:title message:message preferredStyle:preferredStyle];
    doneBaseAlertView.cancelTitle = cancel;
    doneBaseAlertView.cancelBlock = cancelBlock;
    if (defaultText) {
        doneBaseAlertView.defaultFirstTitle = defaultText;
        doneBaseAlertView.clickedBlock = clickBlock;
    }
    return doneBaseAlertView;
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
