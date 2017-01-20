//
//  JFAlertViewController.h
//  Tornado
//
//  Created by apple on 16/8/22.
//  Copyright © 2016年 JunFly. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JFAlertViewController;

@protocol JFAlertViewDataSource <NSObject>

@required

/** 返回选项的个数  (cancel按钮不计算在内) */
- (NSUInteger)numberOfIndexsInJFAlertView:(JFAlertViewController *)alertView;

/** 返回选项的title */
- (NSString *)JFAlertView:(JFAlertViewController *)alertView titleAtIndexNumber:(NSUInteger)index;

@end

@protocol JFAlertViewDelegate <NSObject>

@optional

/** 选项的点击事件 */
- (void)JFAlertView:(JFAlertViewController *)alertView clickedAtIndex:(NSUInteger)index;

/** cancel按钮的点击事件 */
- (void)JFAlertViewCancel:(JFAlertViewController *)alertView;

@end

@interface JFAlertViewController : UIAlertController

/** JFAlertViewDataSource */
@property (nonatomic, weak) id <JFAlertViewDataSource> dataSource;
/** JFAlertViewDelegate */
@property (nonatomic, weak) id <JFAlertViewDelegate> delegate;

/** 取消按钮action 若有delegate方法则此block无效 */
@property (copy, nonatomic) void(^cancelBlock)(JFAlertViewController *alertView);
/** 点击按钮action 若有delegate方法则此block无效 */
@property (copy, nonatomic) void(^clickedBlock)(JFAlertViewController *alertView, NSUInteger index);

/** 可以自定义cancel按钮 默认是'取消' */
@property (strong, nonatomic) NSString *cancelTitle;

/** 默认除取消按钮外的一个按钮 若有datasource方法则title无效 */
@property (strong, nonatomic) NSString *defaultFirstTitle;


/**
 快速创建 提示框 默认两个按钮 cancel 和 default
 @param title alert的title
 @param message alert的消息主题
 @param preferredStyle alert的显示style
 @param cancel cancel按钮的title
 @param cancelBlock cancel的action
 @param defaultText 确认按钮的title
 @param clickBlock 确认的action
 @return JFAlertViewController
 */
+ (JFAlertViewController *)alertViewWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(UIAlertControllerStyle)preferredStyle
                                 cancelAction:(NSString *)cancel cancelBlock:(void (^)(JFAlertViewController *alertView))cancelBlock
                                defaultButton:(NSString *)defaultText defaultBlock:(void (^)(JFAlertViewController *alertView, NSUInteger index))clickBlock;


@end
