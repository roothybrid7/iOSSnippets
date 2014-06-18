//
//  UIStoryboard+RHUtils.h
//  TutorialView
//
//  Created by Satoshi Ohki on 2014/06/19.
//  Copyright (c) 2014年 roothybrid7. All rights reserved.
//

#import <UIKit/UIKit.h>

/*!
    @category UIStoryboard (RHUtils)
    @abstract Storyboard factory methodのショートカットを提供
 */
@interface UIStoryboard (RHUtils)

+ (instancetype)mainStoryboard;
+ (instancetype)tutorialStoryboard;

@end
