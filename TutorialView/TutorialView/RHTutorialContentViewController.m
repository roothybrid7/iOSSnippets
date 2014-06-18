//
//  RHTutorialContentViewController.m
//  TutorialView
//
//  Created by Satoshi Ohki on 2014/06/19.
//  Copyright (c) 2014年 roothybrid7. All rights reserved.
//

#import "RHTutorialContentViewController.h"

#import <IonIcons.h>
#import "RHTutorialPage.h"

@interface RHTutorialContentViewController ()

@property (nonatomic) NSString *subTitleFontName;
@property (nonatomic) CGFloat subTitleFontSize;
@property (nonatomic) CGSize subTitleLabelSize;
@property (nonatomic) CGFloat subTitleLabelHorizontalMargin;
@property (nonatomic) CGFloat iconHeight;
@property (nonatomic) CGFloat descriptionLabelWidth;
@property (nonatomic) CGFloat descriptionLabelHorizontalMargin;
@property (nonatomic) CGFloat descriptionFontSize;
@property (nonatomic) CGFloat subTitleAndExtraVerticalMargin;
@property (nonatomic) CGFloat extrasVerticalMargin;
@property (nonatomic) CGFloat extraBottomMargin;

@property (nonatomic) CGRect expectedFrame;

@end

@implementation RHTutorialContentViewController

+ (instancetype)viewController
{
    RHTutorialContentViewController *viewController = [[RHTutorialContentViewController alloc] init];
    return viewController;
}

- (void)initializeAttributes
{
    _subTitleFontName = @"Crowds-beta-Thin";
    _subTitleFontSize = 36.0;
    _subTitleLabelSize = CGSizeMake(300, 28);
    _subTitleLabelHorizontalMargin = 10.0;
    _iconHeight = 40.0;
    _descriptionLabelWidth = 280.0;
    _descriptionLabelHorizontalMargin = 20.0;
    _descriptionFontSize = 14.0;
    _subTitleAndExtraVerticalMargin = 30.0;
    _extrasVerticalMargin = 15.0;
    _extraBottomMargin = 25.0;
}

- (id)initWithViewModel:(id)viewModel frame:(CGRect)frame
{
    self = [super init];
    if (self) {
        [self initializeAttributes];
        [self setViewModel:viewModel];
        _expectedFrame = frame;
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadView
{
    UIView *view = [[UIView alloc] initWithFrame:self.expectedFrame];
    self.view = view;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIImageView *)createIconViewWithItem:(RHTutorialIcon *)item
{
    UIImage *image = [UIImage imageNamed:item.name];
    if (image) {
        CGSize windowSize = [[UIScreen mainScreen] bounds].size;
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(windowSize.width / 2 - image.size.width / 2, 0, image.size.width, self.iconHeight)];
        imageView.image = image;
        imageView.contentMode = UIViewContentModeScaleAspectFit | UIViewContentModeTop | UIViewContentModeCenter;
        imageView.clipsToBounds = YES;
        return imageView;
    }
    return nil;
}

- (UILabel *)createDescriptionLabelWithItem:(RHTutorialDescription *)item
{
    UILabel *label = [[UILabel alloc]
                      initWithFrame:CGRectMake(self.descriptionLabelHorizontalMargin, 0, self.descriptionLabelWidth, 0)];
    NSString *text = item.text;

    UIFont *font = [UIFont boldSystemFontOfSize:self.descriptionFontSize];
    CGSize textSize;
    if ([text respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSDictionary *attributes = @{
            NSFontAttributeName: font,
        };
        textSize = [text
                    boundingRectWithSize:CGSizeMake(label.frame.size.width, CGFLOAT_MAX)
                    options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine
                    attributes:attributes
                    context:nil].size;
    } else {
        textSize = [text sizeWithFont:font constrainedToSize:CGSizeMake(label.frame.size.width, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
    }
    label.frame = CGRectMake(label.frame.origin.x, label.frame.origin.y, label.frame.size.width, textSize.height);
    label.text = text;
    label.font = font;
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor clearColor];
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentCenter;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    return label;
}

- (UILabel *)createSubTitleLabelWithText:(NSString *)text
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(self.subTitleLabelHorizontalMargin, 0, self.subTitleLabelSize.width, self.subTitleLabelSize.height)];
    label.text = text;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont fontWithName:self.subTitleFontName size:self.subTitleFontSize];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentCenter;

    return label;
}

- (void)configureView
{
    __weak typeof(self) weakSelf = self;

    RHTutorialPage *page = (RHTutorialPage *)self.viewModel;

    NSArray *extra = page.extra;
    NSMutableArray *views = @[].mutableCopy;

    // SubTitle以下のicon, description用View生成
    [extra enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id item, NSUInteger idx, BOOL *stop) {
        if ([item isKindOfClass:[RHTutorialIcon class]]) {
            UIImageView *imageView = [weakSelf createIconViewWithItem:item];
            if (imageView) {
                [views addObject:imageView];
            }
        } else if ([item isKindOfClass:[RHTutorialDescription class]]) {
            UILabel *label = [weakSelf createDescriptionLabelWithItem:item];
            [views addObject:label];
        }
    }];

    // 位置調整
    __weak UIView *contentView = self.view;
    [views enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL *stop) {
        CGRect viewFrame = view.frame;
        if (idx == 0) {
            viewFrame.origin.y = contentView.frame.size.height - weakSelf.extraBottomMargin - viewFrame.size.height;
        } else {
            UIView *prevView = views[idx - 1];
            viewFrame.origin.y = prevView.frame.origin.y - viewFrame.size.height - weakSelf.extrasVerticalMargin;
        }
        view.frame = viewFrame;
        [contentView addSubview:view];
    }];

    UIView *lastSubView = [views lastObject];
    UILabel *subTitleLabel = [self createSubTitleLabelWithText:page.subTitle];
    CGRect subTitleLabelFrame = subTitleLabel.frame;
    subTitleLabelFrame.origin.y = lastSubView.frame.origin.y - subTitleLabel.frame.size.height - self.subTitleAndExtraVerticalMargin;
    subTitleLabel.frame = subTitleLabelFrame;
    [self.view addSubview:subTitleLabel];
}

@end
