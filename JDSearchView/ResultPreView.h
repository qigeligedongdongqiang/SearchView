//
//  ResultPreView.h
//  JDSearchView
//
//  Created by Ngmm_Jadon on 2017/6/26.
//  Copyright © 2017年 Ngmm_Jadon. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^PreViewSelectBlock)(NSString *text);
typedef void(^UpToSearchBlock)(NSString *text);

@interface ResultPreView : UIView

@property (nonatomic, copy) NSString *searchText;
@property (nonatomic, copy) PreViewSelectBlock selectAction;
@property (nonatomic, copy) UpToSearchBlock upToAction;

@end
