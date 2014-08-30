//
//  RH7DetailViewController.m
//  RefreshControl
//
//  Created by 大木 聡 on 2014/08/30.
//  Copyright (c) 2014年 roothybrid7. All rights reserved.
//

#import "RH7DetailViewController.h"

@interface RH7DetailViewController ()
- (void)configureView;
@end

@implementation RH7DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        self.detailDescriptionLabel.text = [self.detailItem description];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
