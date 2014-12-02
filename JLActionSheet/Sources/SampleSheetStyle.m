//
//  SampleSheetStyle.m
//  JLActionSheet
//
//  Created by Philip Yu on 20/11/14.
//  Copyright (c) 2014 Jason Loewy. All rights reserved.
//

#import "SampleSheetStyle.h"

@interface JLActionSheetStyle ()

@property (nonatomic, strong) UIColor* standardBGColor;
@property (nonatomic, strong) UIColor* highlightedBGColor;

@property (nonatomic, strong) UIColor* cancelBGColor;
@property (nonatomic, strong) UIColor* cancelHighlightedBG;


/// Font Colors
@property (nonatomic, strong) UIColor* textColor;
@property (nonatomic, strong) UIColor* textShadowColor;
@property (nonatomic, strong) UIColor* cancelTextColor;
@property (nonatomic, strong) UIColor* cancelTextShadowColor;

@end

@implementation SampleSheetStyle

@synthesize darkBorderColor = _darkBorderColor;
@synthesize lightBorderColor = _lightBorderColor;

#define Color(r,g,b,a) [UIColor colorWithRed:(r/(float)255) green:(g/(float)255) blue:(b/(float)255) alpha:a]

- (id) init
{
    if (self =[super init])
    {
        self.standardBGColor        = Color(255, 255, 255, 1.0);
        self.highlightedBGColor     = Color(220, 220, 220, 1.0);
        
        self.cancelBGColor          = self.standardBGColor;
        self.cancelHighlightedBG    = self.highlightedBGColor;
        
        _darkBorderColor        = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
        _lightBorderColor       = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:0.0];
        
        self.textColor              = [UIColor blackColor];
        self.textShadowColor        = [UIColor colorWithWhite:255 alpha:0.0];
        
        self.cancelTextColor              = [UIColor blackColor];
        self.cancelTextShadowColor        = [UIColor whiteColor];
    }
    
    return self;
}

- (UIEdgeInsets)getTitleInsets {
    return UIEdgeInsetsMake(15, 15, 15, 15);
}

@end
