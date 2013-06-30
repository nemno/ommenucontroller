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
        [self.view addSubview: self.menuPickerView];
        
        NSMutableArray *screenShotsMutableArray = [NSMutableArray array];
        
        for (UIViewController *viewController in self.viewControllers) {
        
            UIGraphicsBeginImageContext(viewController.view.bounds.size);
            
            [viewController.view.layer renderInContext:UIGraphicsGetCurrentContext()];
            
            UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            
            [screenShotsMutableArray addObject:viewImage];
            
        }
        
        self.screenShotsArray = [NSArray arrayWithArray: screenShotsMutableArray];
        
        self.menuPickerView.scrollView.delegate = self;
        
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
    
    float selectedFloatValue = [offsetNumber floatValue] / 44.0f;
    
    NSNumber *selectedFloatNumber = [NSNumber numberWithFloat: selectedFloatValue];
    
    self.selectedIndex = [selectedFloatNumber integerValue];    
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    for (UIViewController *vc in self.viewControllers) {
        [vc.view removeFromSuperview];
    }
    
    selectedScreenShotImageView = [[UIImageView alloc] initWithImage: [self.screenShotsArray objectAtIndex: self.selectedIndex]];
    
    selectedScreenShotImageView.frame = self.view.bounds;
    
    [self.view addSubview: selectedScreenShotImageView];
    
    [self.view bringSubviewToFront: self.menuPickerView];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    NSLog(@"scrollview: %f", scrollView.contentOffset.x);
    
    CGFloat nullPoint = self.selectedIndex * 44.0f;
    
    NSLog(@"nullpoint: %f", nullPoint);
    
    NSNumber *offsetNumber = [NSNumber numberWithFloat:scrollView.contentOffset.x];
    
    
    if (scrollView.contentOffset.x >= nullPoint) {
        
        if ([offsetNumber intValue] % 44 < 14) {
            selectedScreenShotImageView.frame = CGRectMake(CGRectGetMinX(selectedScreenShotImageView.frame) + ((scrollView.contentOffset.x - nullPoint) * 0.5), CGRectGetMinY(selectedScreenShotImageView.frame) + ((scrollView.contentOffset.x - nullPoint) * 0.5), CGRectGetWidth(selectedScreenShotImageView.frame) - ((scrollView.contentOffset.x - nullPoint) * 1), CGRectGetHeight(selectedScreenShotImageView.frame) - ((scrollView.contentOffset.x - nullPoint) * 1));
            
        } else if([offsetNumber intValue] % 44 > 14 && [offsetNumber intValue] % 44 < 30) {
            selectedScreenShotImageView.frame = CGRectMake(CGRectGetMinX(selectedScreenShotImageView.frame) - ((scrollView.contentOffset.x - nullPoint) * 1), CGRectGetMinY(selectedScreenShotImageView.frame), CGRectGetWidth(selectedScreenShotImageView.frame), CGRectGetHeight(selectedScreenShotImageView.frame));
            
        } else {
            
            
            
            
        }
        
    } else {
        
                
    }
    
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
    
    UIViewController *selectedViewController = [self.viewControllers objectAtIndex: self.selectedIndex];
    
    selectedViewController.view.frame = self.view.bounds;
    
    [self.view addSubview: selectedViewController.view];
    
    [self.view bringSubviewToFront: self.menuPickerView];
}



@end
