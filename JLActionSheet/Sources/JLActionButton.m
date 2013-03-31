//
//  JLActionButton.m
//  JLActionSheet
//
//  Created by Jason Loewy on 1/31/13.
//  Copyright (c) 2013 Jason Loewy. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "JLActionButton.h"
#import "JLActionSheetStyle.h"

@interface JLActionButton ()

/// Data Flags
@property BOOL isCancelButton;

@property (nonatomic, strong) UIColor* bgColor;
@property (nonatomic, strong) UIColor* highlightedColor;

@property (nonatomic, strong) CALayer* topBorder;
@property (nonatomic, strong) CALayer* bottomBorder;

@end

@implementation JLActionButton

#pragma mark -
#pragma mark - Inititalization Methods

+ (id) buttonWithStyle:(JLActionSheetStyle*)style andTitle:(NSString *)buttonTitle isCancel:(BOOL) isCancel
{
    JLActionButton* actionButton = [JLActionButton buttonWithType:UIButtonTypeCustom];
    [actionButton setTitle:buttonTitle forState:UIControlStateNormal];
    
    if (!isCancel)
    {
        actionButton.bgColor            = [style getBGColorHighlighted:NO];
        actionButton.highlightedColor   = [style getBGColorHighlighted:YES];
    }
    else if (isCancel)
    {
        actionButton.bgColor            = [style getCancelBGColorHighlighted:NO];
        actionButton.highlightedColor   = [style getCancelBGColorHighlighted:YES];
    }
    
    // Initialize and add the two border objects
    actionButton.topBorder = [[CALayer alloc] init];
    [actionButton.topBorder setBackgroundColor:style.lightBorderColor.CGColor];
    [actionButton.layer addSublayer:actionButton.topBorder];
    
    actionButton.bottomBorder = [[CALayer alloc] init];
    [actionButton.bottomBorder setBackgroundColor:style.darkBorderColor.CGColor];
    [actionButton.layer addSublayer:actionButton.bottomBorder];
    
    
    // Configure the title item
    [actionButton.titleLabel setFont:[UIFont systemFontOfSize:20.0f]];
    [actionButton setTitleColor:[style getTextColor:isCancel] forState:UIControlStateNormal];
    [actionButton setTitleShadowColor:[style getTextShadowColor:isCancel] forState:UIControlStateNormal];
    [actionButton.titleLabel setShadowOffset:CGSizeMake(0.0f, -1.0f)];
    
    [actionButton setAutoresizingMask:(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin)];
    [actionButton setBackgroundColor:actionButton.bgColor];
    return actionButton;
}

#pragma mark -
#pragma mark - UI Methods

- (void) layoutSubviews
{
    [super layoutSubviews];
    [_topBorder setFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), 1)];
    [_bottomBorder setFrame:CGRectMake(0, CGRectGetHeight(self.bounds) - 1, CGRectGetWidth(self.bounds), 1)];
}


- (void) setHighlighted:(BOOL)highlighted
{
    if (highlighted)
        [self setBackgroundColor:_highlightedColor];
    else
        [self setBackgroundColor:_bgColor];
}

/*
 Responsible for configuring the top action button with respect to Y placement when there is a title above it
 */
- (void) configureForTitle
{
    [_topBorder setHidden:YES];
}

@end
