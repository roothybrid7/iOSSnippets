//
//  UIStoryboard+RHUtils.m
//  TutorialView
//
//  Created by Satoshi Ohki on 2014/06/19.
//  Copyright (c) 2014年 roothybrid7. All rights reserved.
//

#import "UIStoryboard+RHUtils.h"

@implementation UIStoryboard (RHUtils)

static NSString *const MainStoryboardName = @"MainStoryboard";
static NSString *const TutorialStoryboardName = @"TutorialStoryboard";

#pragma mark - Factory methods

+ (instancetype)mainStoryboard
{
    return [self storyboardWithName:MainStoryboardName bundle:nil];
}

+ (instancetype)tutorialStoryboard
{
    return [self storyboardWithName:TutorialStoryboardName bundle:nil];
}

@end
