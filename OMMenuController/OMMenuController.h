//
//  OMMenuController.h
//  OMMenuController
//
//  Created by Nemes Norbert on 6/30/13.
//  Copyright (c) 2013 Nemes Norbert. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OMMenuControllerPickerView.h"
#import "OMMenuButton.h"

@interface OMMenuController : UIViewController <OMMenuControllerPickerViewDelegate, UIScrollViewDelegate>
{
    UIImageView *selectedScreenShotImageView;
    
    CGFloat nullPoint;
    
    BOOL menuIsVisible;
}

@property (nonatomic, retain) NSArray* viewControllers;
@property (nonatomic, retain) OMMenuControllerPickerView *menuPickerView;
@property (nonatomic) NSInteger selectedIndex;
@property (nonatomic, retain) UIScrollView *screenShotsScrollView;
@property (nonatomic, retain) OMMenuButton *menuButton;
@property (nonatomic, retain) NSMutableArray *screenShotsArray;

- (id)initWithViewControllers: (NSArray*) _viewControllers;


@end
