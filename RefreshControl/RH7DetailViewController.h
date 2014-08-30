//
//  RH7DetailViewController.h
//  RefreshControl
//
//  Created by 大木 聡 on 2014/08/30.
//  Copyright (c) 2014年 roothybrid7. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RH7DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
