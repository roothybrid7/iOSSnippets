//
//  UIViewController+RHViewModel.m
//  TutorialView
//
//  Created by Satoshi Ohki on 2014/06/19.
//  Copyright (c) 2014年 roothybrid7. All rights reserved.
//

#import "UIViewController+RHViewModel.h"

#import <objc/runtime.h>

@implementation UIViewController (RHViewModel)

- (void)setViewModel:(id)viewModel
{
    objc_setAssociatedObject(self, @selector(viewModel), viewModel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)viewModel
{
    return objc_getAssociatedObject(self, @selector(viewModel));
}

@end
