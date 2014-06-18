//
//  RHTutorialScrollView.m
//  TutorialView
//
//  Created by Satoshi Ohki on 2014/06/19.
//  Copyright (c) 2014年 roothybrid7. All rights reserved.
//

#import "RHTutorialScrollView.h"

@implementation RHTutorialScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (!self.isDragging) {
        [[self nextResponder] touchesEnded:touches withEvent:event];
    }
    [super touchesEnded:touches withEvent:event];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (!self.isDragging) {
        [[self nextResponder] touchesBegan:touches withEvent:event];
    }
    [super touchesBegan:touches withEvent:event];
}

@end
