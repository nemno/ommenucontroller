//
//  OMMenuControllerPickerView.m
//  OMMenuController
//
//  Created by Nemes Norbert on 6/30/13.
//  Copyright (c) 2013 Nemes Norbert. All rights reserved.
//

#import "OMMenuControllerPickerView.h"

@implementation OMMenuControllerPickerView
@synthesize scrollView;
@synthesize selectedIndex;
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [UIColor redColor];
    }
    return self;
}

- (id)initWithTitles: (NSArray*) _titles
{
    CGFloat minY = [UIScreen mainScreen].bounds.size.height - 64.0f;
    
    self = [super initWithFrame:CGRectMake(0.0f, minY, 320.0f, 44.0f)];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [UIColor redColor];
        
        self.scrollView = [[UIScrollView alloc] initWithFrame: CGRectMake((320.0f - 80.0f) / 2.0f, 0.0f, 80.0f, 44.0f)];
//        self.scrollView.delegate = self.delegate;
        self.scrollView.clipsToBounds = NO;
        
        OMMenuControllerPickerScrollViewEnhancer *enhancer = [[OMMenuControllerPickerScrollViewEnhancer alloc] initWithFrame:self.bounds];
        enhancer.scrollView = self.scrollView;
        [self addSubview: enhancer];
        
        int i = 0;
        for (NSString *titleString in _titles) {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f + (i * 80.0f), 0.0f, 80.0f, 44.0f)];
            label.backgroundColor = [UIColor clearColor];
            label.textColor = [UIColor whiteColor];
            label.textAlignment = NSTextAlignmentCenter;
            label.text = titleString;
            [self.scrollView addSubview:label];
            i++;
        }
        
        [self.scrollView setContentSize:CGSizeMake(_titles.count * 80.0f, 44.0f)];
        self.scrollView.pagingEnabled = YES;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview: self.scrollView];
        
        OMMenuControllerPickerScrollViewEnhancer *selectionIndicatorEnhancer = [[OMMenuControllerPickerScrollViewEnhancer alloc] initWithFrame:CGRectMake((320.0f - 80.0f) / 2.0f, 0.0f, 80.0f, 44.0f)];
        selectionIndicatorEnhancer.backgroundColor = [UIColor greenColor];
        selectionIndicatorEnhancer.alpha = 0.2f;
        selectionIndicatorEnhancer.scrollView = self.scrollView;
        
        [self addSubview: selectionIndicatorEnhancer];
        
    }
    return self;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)_scrollView
{
    CGFloat offsetX = _scrollView.contentOffset.x;
    NSNumber *offsetNumber = [NSNumber numberWithFloat:offsetX];
    
    float selectedFloatValue = [offsetNumber floatValue] / 80.0f;
    
    NSNumber *selectedFloatNumber = [NSNumber numberWithFloat: selectedFloatValue];
    
    self.selectedIndex = [selectedFloatNumber integerValue];
    
    [self.delegate selectedIndexChangedInPickerView:self];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    [self.delegate pickersScrollViewDidScrollInPickerView:self];
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
