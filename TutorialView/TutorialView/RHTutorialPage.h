//
//  RHTutorialPage.h
//  TutorialView
//
//  Created by Satoshi Ohki on 2014/06/19.
//  Copyright (c) 2014年 roothybrid7. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RHTutorialIcon : NSObject

@property (nonatomic) NSString *name;

@end


@interface RHTutorialDescription : NSObject

@property (nonatomic) NSString *text;

@end

@interface RHTutorialPage : NSObject

@property (nonatomic) NSString *backgroundImageName;
@property (nonatomic) NSString *subTitle;
@property (nonatomic) NSString *iconName;
@property (nonatomic) NSString *descriptionText;
@property (nonatomic) NSArray *extra;

/*!
    @method pages
    @abstract `RCTutorialPage`でインスタンス化したTutorialデータの一覧を返す
 */
+ (NSArray *)pages;


@end
