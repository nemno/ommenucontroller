//
//  OMMenuController.m
//  OMMenuController
//
//  Created by Nemes Norbert on 6/30/13.
//  Copyright (c) 2013 Nemes Norbert. All rights reserved.
//

#import "OMMenuController.h"

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
        
        ///TODO - generate viewcontroller titles array
        
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
        self.menuPickerView.delegate = self;
        [self setSelectedIndex:0];
        [self.view addSubview:self.menuPickerView];
        
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

#pragma mark - OMMenuControllerPickerViewDelegate methods

-(void)selectedIndexChangedInPickerView:(OMMenuControllerPickerView *)pickerView
{
    self.selectedIndex = pickerView.selectedIndex;
}

-(void)setSelectedIndex:(NSInteger)_selectedIndex
{
    
    selectedIndex = _selectedIndex;
    
    for (UIViewController *vc in self.viewControllers) {
        [vc.view removeFromSuperview];
    }
    
    UIViewController *selectedViewController = [self.viewControllers objectAtIndex: self.selectedIndex];
    
    selectedViewController.view.frame = self.view.bounds;
    
    [self.view addSubview: selectedViewController.view];
    
    [self.view bringSubviewToFront: self.menuPickerView];
}

@end
