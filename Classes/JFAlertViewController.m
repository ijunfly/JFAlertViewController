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
    NSString *cancelTitle = self.cancelTitle ?: @"取消";
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        __strong __typeof__ (wSelf) sSelf = wSelf;
        if (sSelf.delegate && [sSelf.delegate respondsToSelector:@selector(JFAlertViewCancel:)]) {
            [sSelf.delegate JFAlertViewCancel:sSelf];
        } else if (sSelf.cancelBlock) {
            sSelf.cancelBlock(sSelf);
        }
    }];
    if (self.cancelColor) {
        [cancelAction setValue:self.cancelColor forKey:@"titleTextColor"];
    }
    [self addAction:cancelAction];
    
    // 设置其他按钮
    if ((self.dataSource && [self.dataSource respondsToSelector:@selector(numberOfIndexsInJFAlertView:)])) {
        self.items = [self.dataSource numberOfIndexsInJFAlertView:self];
        self.actionTitles = nil;
        NSAssert(([self.dataSource respondsToSelector:@selector(JFAlertView:titleAtIndexNumber:)]), @"JFAlertViewController // dataSource 实现'numberOfIndexsInJFAlertView:'之后必须实现'JFAlertView:titleAtIndexNumber:' and 'JFAlertView:colorAtIndexNumber:' ");
        
    } else if (self.actionTitles) {
        self.items = self.actionTitles.count;
    } else {
        self.items = 0;
    }
    
    if (self.items == 0) return;

    for (int i = 0; i < self.items; i++) {
        NSString *title = (self.actionTitles) ? self.actionTitles[i] : [self.dataSource JFAlertView:self titleAtIndexNumber:i];
        
        UIAlertAction *temAction = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            __strong __typeof__ (wSelf) sSelf = wSelf;
            if (sSelf.delegate && [sSelf.delegate respondsToSelector:@selector(JFAlertView:clickedAtIndex:)]) {
                [sSelf.delegate JFAlertView:sSelf clickedAtIndex:i];
            } else if (sSelf.actionBlock) {
                sSelf.actionBlock(sSelf, i);
            }
        }];
        UIColor *titleColor = (self.actionColors) ? self.actionColors[i] : [self.dataSource JFAlertView:self colorAtIndexNumber:i];
        if (titleColor) {
            [temAction setValue:titleColor forKey:@"titleTextColor"];
        }
        [self addAction:temAction];
    }
    
}

+ (instancetype)alertControllerWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(UIAlertControllerStyle)preferredStyle {
    //可以添加要写的
    return [super alertControllerWithTitle:title message:message preferredStyle:preferredStyle];
}

+ (JFAlertViewController *)alertViewWithTitle:(NSString *)title
                                      message:(NSString *)message
                               preferredStyle:(UIAlertControllerStyle)preferredStyle
                                 cancelButton:(NSString *)cancel
                                  cancelBlock:(void (^)(JFAlertViewController *alertView))cancelBlock
                                 actionButton:(NSArray <NSString *> *)actionTexts
                                  actionBlock:(void (^)(JFAlertViewController *alertView, NSUInteger index))actionBlock {
    
    JFAlertViewController *doneBaseAlertView = [JFAlertViewController alertControllerWithTitle:title message:message preferredStyle:preferredStyle];
    doneBaseAlertView.cancelTitle = cancel;
    doneBaseAlertView.cancelBlock = cancelBlock;
    if (actionTexts) {
        doneBaseAlertView.actionTitles = actionTexts;
        doneBaseAlertView.actionBlock = actionBlock;
    }
    return doneBaseAlertView;
}

+ (JFAlertViewController *)alertViewWithTitle:(NSString *)title
                                      message:(NSString *)message
                               preferredStyle:(UIAlertControllerStyle)preferredStyle
                                 cancelButton:(NSString *)cancel
                                  cancelColor:(UIColor *)cancelColor
                                  cancelBlock:(void (^)(JFAlertViewController *alertView))cancelBlock
                                 actionButton:(NSArray <NSString *> *)actionTexts
                                  actionColors:(NSArray <UIColor *> *)actionColors
                                  actionBlock:(void (^)(JFAlertViewController *alertView, NSUInteger index))actionBlock {
    JFAlertViewController *doneBaseAlertView = [JFAlertViewController alertControllerWithTitle:title
                                                                                       message:message
                                                                                preferredStyle:preferredStyle];
    doneBaseAlertView.cancelTitle = cancel;
    doneBaseAlertView.cancelBlock = cancelBlock;
    doneBaseAlertView.cancelColor = cancelColor;
    if (actionTexts) {
        doneBaseAlertView.actionTitles = actionTexts;
        doneBaseAlertView.actionBlock = actionBlock;
        doneBaseAlertView.actionColors = actionColors;
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
