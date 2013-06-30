//
//  OMMenuControllerPickerView.h
//  OMMenuController
//
//  Created by Nemes Norbert on 6/30/13.
//  Copyright (c) 2013 Nemes Norbert. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OMMenuControllerPickerScrollViewEnhancer.h"

@class OMMenuControllerPickerView;
@protocol OMMenuControllerPickerViewDelegate <NSObject>

-(void)selectedIndexChangedInPickerView: (OMMenuControllerPickerView*) pickerView;

@end

@interface OMMenuControllerPickerView : UIView <UIScrollViewDelegate>

@property (nonatomic, retain) UIScrollView *scrollView;
@property NSInteger selectedIndex;
@property id<OMMenuControllerPickerViewDelegate, UIScrollViewDelegate> delegate;

- (id)initWithTitles: (NSArray*) _titles;

@end
