//
//  OMMenuControllerPickerScrollViewEnhancer.m
//  OMMenuController
//
//  Created by Nemes Norbert on 6/30/13.
//  Copyright (c) 2013 Nemes Norbert. All rights reserved.
//

#import "OMMenuControllerPickerScrollViewEnhancer.h"

@implementation OMMenuControllerPickerScrollViewEnhancer
@synthesize scrollView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    return scrollView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
