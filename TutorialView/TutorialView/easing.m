//  easing.m
//  TutorialView
//
//  Created by Satoshi Ohki on 2014/06/19.
//  Copyright (c) 2014年 roothybrid7. All rights reserved.
//

#import "easing.h"

CGFloat exponentialEaseOut(CGFloat p)
{
    return (p == 1.0) ? p : 1 - pow(2, -10 * p);
}
