//
//  RHTutorialViewController.m
//  TutorialView
//
//  Created by Satoshi Ohki on 2014/06/19.
//  Copyright (c) 2014年 roothybrid7. All rights reserved.
//

#import "RHTutorialViewController.h"

#import <IonIcons.h>
#import "UIStoryboard+RHUtils.h"
#import "RHTutorialPage.h"
#import "RHTutorialContentViewController.h"
#import "RHTutorialScrollView.h"
#import "easing.h"

@interface RHTutorialViewController () <UIScrollViewDelegate>

@property (nonatomic) NSArray *pages;

@property (weak, nonatomic) IBOutlet RHTutorialScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *frontLayerImageView;
@property (weak, nonatomic) IBOutlet UIImageView *backLayerImageView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UIButton *closeButton;

#pragma mark - Auto layout constraint

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *closeButtonTopMarginConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLogoButtonMarginConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollViewBottomMarginConstraint;

#pragma mark - User defined runtime attributes

@property (nonatomic) CGSize closeButtonSize;
@property (nonatomic) CGSize pageDotSize;

#pragma mark -

@property (nonatomic) NSInteger currentPageIndex;
@property (nonatomic) CGSize windowSize;

@end

@implementation RHTutorialViewController

+ (instancetype)viewController
{
    return [[UIStoryboard tutorialStoryboard] instantiateViewControllerWithIdentifier:NSStringFromClass(self)];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.pages = [RHTutorialPage pages];
    self.windowSize = [[UIScreen mainScreen] bounds].size;
    CGRect scrollFrame = self.scrollView.frame;
    scrollFrame.size.height = self.view.frame.size.height - self.scrollViewBottomMarginConstraint.constant;
    self.scrollView.frame = scrollFrame;
    self.scrollView.pagingEnabled = YES;

    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1) {
        self.closeButtonTopMarginConstraint.constant = 0.0;
    }
    if (!IS_IPHONE_5) {
        self.titleLogoButtonMarginConstraint.constant = self.titleLogoButtonMarginConstraint.constant * kRHReductionRatioFrom4InchTo3_5Inch;
    }
    UIImage *icon = [IonIcons imageWithIcon:icon_ios7_close_empty iconColor:[UIColor whiteColor] iconSize:self.closeButtonSize.width imageSize:self.closeButtonSize];
    [self.closeButton setImage:icon forState:UIControlStateNormal];

//    UIImage *currentPageDotIcon =
//        [IonIcons imageWithIcon:icon_record iconColor:[UIColor whiteColor] iconSize:self.pageDotSize.width imageSize:self.pageDotSize];
//
//    self.pageControl.pageIndicatorImage = [UIImage imageNamed:@"pageDot"];
//    self.pageControl.currentPageIndicatorImage = currentPageDotIcon;
    self.pageControl.numberOfPages = [self.pages count];
    self.pageControl.currentPage = 0;
    self.pageControl.enabled = NO;  // タップに反応しないようにする
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.scrollView.contentSize = CGSizeMake([self.pages count] * self.windowSize.width, self.scrollView.contentSize.height);
    [self configureContentViewControllers];
    [self setOriginLayersState];
}

- (void)configureContentViewControllers
{
    __weak typeof(self) weakSelf = self;
    NSArray *pages = self.pages;
    [pages enumerateObjectsUsingBlock:^(RHTutorialPage *page, NSUInteger idx, BOOL *stop) {
        CGRect frame = CGRectMake(idx * weakSelf.windowSize.width, 0, weakSelf.windowSize.width, weakSelf.scrollView.frame.size.height);
        RHTutorialContentViewController *viewController = [[RHTutorialContentViewController alloc] initWithViewModel:page frame:frame];
        [weakSelf addChildViewController:viewController];
        [weakSelf.scrollView addSubview:viewController.view];
        [viewController didMoveToParentViewController:weakSelf];
    }];
}

- (void)dismissViewController
{
    UIViewController *destinationViewController = self.presentingViewController;
    UIView *parentView = destinationViewController.view;
    [self.view.superview insertSubview:parentView atIndex:0];

    [UIView animateWithDuration:0.3 animations:^{
        self.view.alpha = 0;
    } completion:^(BOOL finished) {
        [destinationViewController.view removeFromSuperview];
        [self dismissViewControllerAnimated:NO completion:nil];
    }];
}

- (IBAction)closeButtonDidTouchUpInside:(id)sender
{
    [self dismissViewController];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (self.currentPageIndex >= [self.pages count] - 1) {
        [self dismissViewController];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat scrollingPosition = scrollView.contentOffset.x / self.windowSize.width;
    if (scrollingPosition > 0 && scrollingPosition <= [self.pages count] - 1) {
        [self disolveBackgroundWithContentOffset:scrollingPosition];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    self.pageControl.currentPage = self.currentPageIndex;
}

- (void)disolveBackgroundWithContentOffset:(CGFloat)offset
{
    [self scrollingToNextPageWithOffset:offset];
}

/*!
 @method scrollingToNextPageWithOffset:
 @abstract 横スクロールしたoffsetの小数点以下(<=1)をAlpha値にして透明度を切り替えてFacein/outを実現する
 */
- (void)scrollingToNextPageWithOffset:(CGFloat)offset
{
    NSInteger page = (NSInteger)offset;

    CGFloat alphaValue = offset - (NSInteger)offset;
    if (page != self.currentPageIndex) {
        [self setLayersImagesWithIndex:page];
    }

    CGFloat backLayerAlpha = alphaValue;
    CGFloat frontLayerAlpha = exponentialEaseOut(1 - alphaValue);

    self.backLayerImageView.alpha = backLayerAlpha;
    self.frontLayerImageView.alpha = frontLayerAlpha;
}

- (void)setBackgroundImageView:(UIImageView *)imageView withIndex:(NSUInteger)index
{
    if (index >= [self.pages count]) {
        imageView.image = nil;
        return;
    }

    NSString *imageName = [[self.pages objectAtIndex:index] backgroundImageName];
    imageView.image = [UIImage imageNamed:imageName];
}

- (void)setLayersPrimaryAlphaWithPageIndex:(NSUInteger)index
{
    self.frontLayerImageView.alpha = 1;
    self.backLayerImageView.alpha = 0;
}

- (void)setFrontLayerImageWithPageIndex:(NSUInteger)index
{
    [self setBackgroundImageView:self.frontLayerImageView withIndex:index];
}

- (void)setBackLayerImageWithPageIndex:(NSUInteger)index
{
    [self setBackgroundImageView:self.backLayerImageView withIndex:index + 1];
}

/*!
 @method setLayersImagesWithIndex:
 @abstract 画像を2枚セットする(下[FrontLayer]に現在の表示画像を、上[BackLayer]に次の表示画像)
 */
- (void)setLayersImagesWithIndex:(NSUInteger)index
{
    self.currentPageIndex = index;
    [self setLayersPrimaryAlphaWithPageIndex:index];
    [self setFrontLayerImageWithPageIndex:index];
    [self setBackLayerImageWithPageIndex:index];
}

- (void)setOriginLayersState
{
    self.backLayerImageView.backgroundColor = [UIColor blackColor];
    self.frontLayerImageView.backgroundColor = [UIColor blackColor];
    [self setLayersImagesWithIndex:0];
}

@end
