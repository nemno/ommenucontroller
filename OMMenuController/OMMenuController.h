//
//  OMMenuController.h
//  OMMenuController
//
//  Created by Nemes Norbert on 6/30/13.
//  Copyright (c) 2013 Nemes Norbert. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OMMenuControllerPickerView.h"

@interface OMMenuController : UIViewController <OMMenuControllerPickerViewDelegate>

@property (nonatomic, retain) NSArray* viewControllers;
@property (nonatomic, retain) OMMenuControllerPickerView *menuPickerView;
@property (nonatomic) NSInteger selectedIndex;

- (id)initWithViewControllers: (NSArray*) _viewControllers;


@end
