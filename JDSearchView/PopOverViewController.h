//
//  PopOverViewController.h
//  JDSearchView
//
//  Created by Ngmm_Jadon on 2017/6/26.
//  Copyright © 2017年 Ngmm_Jadon. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PopOverViewController;

@protocol  PopOverViewControllerDelegate<NSObject>

@optional
- (void)popView:(PopOverViewController *)popView didSelectTitle:(NSString *)title;

@end

@interface PopOverViewController : UIViewController

@property (nonatomic, weak) id<PopOverViewControllerDelegate> delegate;

- (instancetype)initWithSourceView:(UIView *)sourceView;

@end
