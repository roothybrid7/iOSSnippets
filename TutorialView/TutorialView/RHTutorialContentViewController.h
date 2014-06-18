//
//  RHTutorialContentViewController.h
//  TutorialView
//
//  Created by Satoshi Ohki on 2014/06/19.
//  Copyright (c) 2014年 roothybrid7. All rights reserved.
//

#import "UIViewController+RHViewModel.h"

@interface RHTutorialContentViewController : UIViewController <RHViewModelUpdating>

- (id)initWithViewModel:(id)viewModel frame:(CGRect)frame;

@end
