//
//  RHTutorialPage.m
//  TutorialView
//
//  Created by Satoshi Ohki on 2014/06/19.
//  Copyright (c) 2014年 roothybrid7. All rights reserved.
//

#import "RHTutorialPage.h"

@implementation RHTutorialIcon

@end


@implementation RHTutorialDescription

@synthesize text = _text;

- (void)setText:(NSString *)text
{
    _text = [text stringByReplacingOccurrencesOfString:@"\\n" withString:@"\n"];
}

@end


@implementation RHTutorialPage

static NSArray *SeedData;

+ (void)initialize
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *path = [[NSBundle mainBundle] pathForResource:@"TutorialResources" ofType:@"plist"];
        SeedData = [NSArray arrayWithContentsOfFile:path];
    });
}

+ (NSArray *)pages
{
    NSMutableArray *instantiateObjects = @[].mutableCopy;
    for (NSDictionary *item in SeedData) {
        RHTutorialPage *page = [[self alloc] init];
        page.backgroundImageName = item[@"backgroundImageName"];
        page.subTitle = item[@"subTitle"];

        NSArray *sourceExtra = item[@"extra"];
        NSMutableArray *resultExtra = @[].mutableCopy;
        for (NSDictionary *extraItem in sourceExtra) {
            if ([[extraItem allKeys] containsObject:@"iconName"]) {
                RHTutorialIcon *icon = [[RHTutorialIcon alloc] init];
                icon.name = extraItem[@"iconName"];
                [resultExtra addObject:icon];
            } else if ([[extraItem allKeys] containsObject:@"description"]) {
                RHTutorialDescription *desc = [[RHTutorialDescription alloc] init];
                desc.text = extraItem[@"description"];
                [resultExtra addObject:desc];
            }
        }
        page.extra = resultExtra;
        [instantiateObjects addObject:page];
    }
    return [instantiateObjects copy];
}

@end
