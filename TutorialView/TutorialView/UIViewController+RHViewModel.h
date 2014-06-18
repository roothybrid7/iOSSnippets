//
//  UIViewController+RHViewModel.h
//  TutorialView
//
//  Created by Satoshi Ohki on 2014/06/19.
//  Copyright (c) 2014年 roothybrid7. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RHViewModelUpdating <NSObject>

@optional
- (id)initWithViewModel:(id)viewModel;
- (id)initWithViewModel:(id)viewModel frame:(CGRect)frame;

@end

@interface UIViewController (RHViewModel)

@property (nonatomic) id viewModel;

@end
