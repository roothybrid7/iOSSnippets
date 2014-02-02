//
//  NavigateFlipSegue.m
//  SegueUnwind
//
//  Created by Satoshi Ohki on 2014/02/02.
//  Copyright (c) 2014年 Satoshi Ohki. All rights reserved.
//

#import "NavigateFlipSegue.h"

@implementation NavigateFlipSegue

- (void)perform
{
    UIViewController *sourceViewController = self.sourceViewController;
    UIViewController *destinationViewController = self.destinationViewController;
    UINavigationController *navigationController = sourceViewController.navigationController;

    if (self.unwind) {
        [UIView transitionWithView:navigationController.view duration:0.3f options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
            [navigationController popToRootViewControllerAnimated:NO];
        } completion:nil];
    } else {
        [UIView transitionWithView:navigationController.view duration:0.3f options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
            [navigationController pushViewController:destinationViewController animated:NO];
        } completion:nil];
    }
}

@end
