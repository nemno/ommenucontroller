//
//  OMMenuController.m
//  OMMenuController
//
//  Created by Nemes Norbert on 6/30/13.
//  Copyright (c) 2013 Nemes Norbert. All rights reserved.
//

#import "OMMenuController.h"
#import <QuartzCore/QuartzCore.h>

@interface OMMenuController ()

@end

@implementation OMMenuController
@synthesize viewControllers;
@synthesize menuPickerView;
@synthesize selectedIndex;
@synthesize screenShotsScrollView;
@synthesize menuButton;
@synthesize screenShotsArray;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithViewControllers: (NSArray*) _viewControllers
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        // Custom initialization
        
        self.view.backgroundColor = [UIColor blueColor];
        
        self.viewControllers = _viewControllers;
                
        NSMutableArray *titlesMutableArray = [NSMutableArray array];
        
        int i = 0;
        for (UIViewController *vc in self.viewControllers) {
            
            //JUST FOR TESTING Different backgrounds
            vc.view.backgroundColor = [UIColor colorWithRed: 0.3f green: 0.3f blue: i * 0.3f alpha: 1.0f];
            [titlesMutableArray addObject: vc.title];
            i++;
        }
        
        NSArray *titlesArray = [NSArray arrayWithArray: titlesMutableArray];
        
        self.menuPickerView = [[OMMenuControllerPickerView alloc] initWithTitles: titlesArray];
        self.menuPickerView.alpha = 0.6f;
        self.menuPickerView.delegate = self;
        [self setSelectedIndex:0];
        
        self.menuPickerView.frame = CGRectMake(0.0f, CGRectGetMinY(self.menuPickerView.frame) + 44.0f, CGRectGetWidth(self.menuPickerView.frame), 44.0f);
        [self.view addSubview: self.menuPickerView];
        
        NSMutableArray *screenShotsMutableArray = [NSMutableArray array];
        
        for (UIViewController *viewController in self.viewControllers) {
        
            UIGraphicsBeginImageContext(viewController.view.bounds.size);
            
            [viewController.view.layer renderInContext:UIGraphicsGetCurrentContext()];
            
            UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            
            [screenShotsMutableArray addObject:viewImage];
            
        }
                
        self.menuPickerView.scrollView.delegate = self;
        
        self.screenShotsScrollView = [[UIScrollView alloc] initWithFrame: CGRectMake(0.0f, 0.0f, 320.0f, CGRectGetHeight(self.view.frame))];
        self.screenShotsScrollView.pagingEnabled = YES;
        self.screenShotsScrollView.backgroundColor = [UIColor clearColor];
        self.screenShotsScrollView.userInteractionEnabled = NO;
        self.screenShotsScrollView.showsHorizontalScrollIndicator = NO;
        
        self.screenShotsArray = [NSMutableArray array];
        
        i = 0;
        for (UIImage *screenImage in screenShotsMutableArray) {
            UIImageView *scImageView = [[UIImageView alloc] initWithImage: screenImage];
            scImageView.frame = CGRectMake( i * 320.0f + 15.0f, 15.0f, 290.0f, CGRectGetHeight(self.screenShotsScrollView.frame) - 30.0f);
            [self.screenShotsScrollView addSubview: scImageView];
            [self.screenShotsArray addObject:scImageView];
            i++;
        }
        
        self.screenShotsScrollView.contentSize = CGSizeMake(i * 320.0f, CGRectGetHeight(self.screenShotsScrollView.frame));
        self.screenShotsScrollView.hidden = YES;
        
        [self.view addSubview: self.screenShotsScrollView];
        
        self.menuButton = [[OMMenuButton alloc] init];
        self.menuButton.frame = CGRectMake(280.0f, 20.0f, 44.0f, 44.0f);
        self.menuButton.backgroundColor = [UIColor purpleColor];
        [self.menuButton addGestureRecognizer: [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(menuButtonTouched)]];
        [self.view addSubview: self.menuButton];
        
        [self.menuButton addGestureRecognizer: [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(dragAndDropMenuButton)]];
        
        menuIsVisible = NO;
        
        UIViewController *selectedViewController = [self.viewControllers objectAtIndex: 0];

        selectedViewController.view.frame = self.view.bounds;

        [self.view addSubview: selectedViewController.view];

        [self.view bringSubviewToFront: self.menuPickerView];
        [self.view bringSubviewToFront: self.menuButton];
        
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIScrollViewDelegate methods

-(void)scrollViewDidEndDecelerating:(UIScrollView *)_scrollView
{
    
    for (UIView *imageView in self.view.subviews) {
        
        if ([imageView isKindOfClass:[UIImageView class]]) {
            [imageView removeFromSuperview];
        }
    }
    
    CGFloat offsetX = _scrollView.contentOffset.x;
    NSNumber *offsetNumber = [NSNumber numberWithFloat:offsetX];
    
    float selectedFloatValue = [offsetNumber floatValue] / 80.0f;
    
    NSNumber *selectedFloatNumber = [NSNumber numberWithFloat: selectedFloatValue];
    
    self.selectedIndex = [selectedFloatNumber integerValue];    
}

-(void)scrollViewDidScroll:(UIScrollView *)_scrollView
{
    [self.screenShotsScrollView setContentOffset: CGPointMake(_scrollView.contentOffset.x * 4, self.screenShotsScrollView.contentOffset.y)];
}

#pragma mark - OMMenuControllerPickerViewDelegate methods

-(void)selectedIndexChangedInPickerView:(OMMenuControllerPickerView *)pickerView
{
    self.selectedIndex = pickerView.selectedIndex;
}

-(void)setSelectedIndex:(NSInteger)_selectedIndex
{
    
    selectedIndex = _selectedIndex;
    
//    for (UIViewController *vc in self.viewControllers) {
//        [vc.view removeFromSuperview];
//    }
//    
//    UIViewController *selectedViewController = [self.viewControllers objectAtIndex: self.selectedIndex];
//    
//    selectedViewController.view.frame = self.view.bounds;
//    
//    [self.view addSubview: selectedViewController.view];
//    
//    [self.view bringSubviewToFront: self.menuPickerView];
//    [self.view bringSubviewToFront: self.menuButton];
}

#pragma mark - UIButton methods


- (void)menuButtonTouched
{
    self.view.userInteractionEnabled = NO;
    
    for (UIViewController *vc in self.viewControllers) {
        [vc.view removeFromSuperview];
    }
    
    if (!menuIsVisible) {
        
        UIImageView *tempImageView = [self.screenShotsArray objectAtIndex: self.selectedIndex];
        
        CGRect tempFrame = tempImageView.frame;
        
        UIGraphicsBeginImageContext(tempImageView.bounds.size);
        
        [tempImageView.layer renderInContext:UIGraphicsGetCurrentContext()];
        
        UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        UIImageView *newImageView = [[UIImageView alloc] initWithImage: viewImage];
        
        newImageView.frame = CGRectMake(CGRectGetMinX(tempImageView.frame) - 15.0f, CGRectGetMinY(tempImageView.frame) - 15.0f, CGRectGetWidth(tempImageView.frame) + 30.0f, CGRectGetHeight(tempImageView.frame) + 30.0f);
        
        [tempImageView removeFromSuperview];
        
        [self.screenShotsScrollView addSubview: newImageView];
        
        [self.screenShotsArray replaceObjectAtIndex: self.selectedIndex withObject: newImageView];
        
        self.screenShotsScrollView.hidden = NO;
        
        [UIView animateWithDuration:0.4f animations:^{
            self.menuPickerView.frame = CGRectMake(0.0f, CGRectGetMinY(self.menuPickerView.frame) - 44.0f, CGRectGetWidth(self.menuPickerView.frame), 44.0f);
            
            newImageView.frame = tempFrame;
            
        } completion:^(BOOL finished) {
            self.view.userInteractionEnabled = YES;
            menuIsVisible = !menuIsVisible;
        }];
    } else {
        
        UIImageView *tempImageView = [self.screenShotsArray objectAtIndex: self.selectedIndex];
        CGRect tempFrame = tempImageView.frame;

        [UIView animateWithDuration:0.4f animations:^{
            self.menuPickerView.frame = CGRectMake(0.0f, CGRectGetMinY(self.menuPickerView.frame) + 44.0f, CGRectGetWidth(self.menuPickerView.frame), 44.0f);
            tempImageView.frame = CGRectMake(CGRectGetMinX(tempImageView.frame) - 15.0f, CGRectGetMinY(tempImageView.frame) - 15.0f, CGRectGetWidth(tempImageView.frame) + 30.0f, CGRectGetHeight(tempImageView.frame) + 30.0f);
            
        } completion:^(BOOL finished) {
            
            tempImageView.frame = tempFrame;
            self.view.userInteractionEnabled = YES;
            self.screenShotsScrollView.hidden = YES;
            menuIsVisible = !menuIsVisible;
            
            UIViewController *selectedViewController = [self.viewControllers objectAtIndex: self.selectedIndex];
            
            selectedViewController.view.frame = self.view.bounds;
            
            [self.view addSubview: selectedViewController.view];
            
            [self.view bringSubviewToFront: self.screenShotsScrollView];
            [self.view bringSubviewToFront: self.menuPickerView];
            [self.view bringSubviewToFront: self.menuButton];
        }];
    }
        
}

#pragma mark - Gesture Recognizer methods

@end
