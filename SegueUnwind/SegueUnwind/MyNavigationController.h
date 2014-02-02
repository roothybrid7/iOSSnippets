//
//  MyNavigationController.h
//  SegueUnwind
//
//  Created by Satoshi Ohki on 2014/02/02.
//  Copyright (c) 2014年 Satoshi Ohki. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MyNavigationControllerDelegate <NSObject>

/*!
    @method segueInNavigationControllerForUnwindingToViewController:fromViewController:identifier:
    @abstract NavigationControllerによる遷移でunwindする場合、custom segueを使いたい場合に実装する
    @discussion 戻る側のViewControllerでsegueの実装してNavigationControllerでは何もしない(委譲)
    @return Custom Segueを生成して返すように実装
 */
- (UIStoryboardSegue *)segueInNavigationControllerForUnwindingToViewController:(UIViewController *)toViewController fromViewController:(UIViewController *)fromViewController identifier:(NSString *)identifier;

@end


@interface MyNavigationController : UINavigationController

@end
