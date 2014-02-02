//
//  MyNavigationController.m
//  SegueUnwind
//
//  Created by Satoshi Ohki on 2014/02/02.
//  Copyright (c) 2014年 Satoshi Ohki. All rights reserved.
//

#import "MyNavigationController.h"

@interface MyNavigationController ()

@end

@implementation MyNavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStoryboardSegue *)segueForUnwindingToViewController:(UIViewController *)toViewController fromViewController:(UIViewController *)fromViewController identifier:(NSString *)identifier
{
    // MARK: 実際の戻り先ViewControllerに処理を任せる
    if ([toViewController conformsToProtocol:@protocol(MyNavigationControllerDelegate)]) {
        id <MyNavigationControllerDelegate> destinationViewController = (id <MyNavigationControllerDelegate>)toViewController;
        UIStoryboardSegue *segue = [destinationViewController segueInNavigationControllerForUnwindingToViewController:toViewController fromViewController:fromViewController identifier:identifier];
        if (segue) {
            return segue;
        }
    }

    return [super segueForUnwindingToViewController:toViewController fromViewController:fromViewController identifier:identifier];
}

@end
