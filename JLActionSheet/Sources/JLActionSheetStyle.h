//
//  JLActionSheetStyle.h
//  JLActionSheet
//
//  Created by Jason Loewy on 2/1/13.
//  Copyright (c) 2013 Jason Loewy. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum JLStyle {
    JLSTYLE_STEEL,
    JLSTYLE_SUPERCLEAN,
    JLSTYLE_CLEANBLUE,
    JLSTYLE_FERRARI
} JLStyle;

@interface JLActionSheetStyle : NSObject

@property (nonatomic, strong) NSArray *textColors;

/// Border Colors
@property (nonatomic, strong, readonly) UIColor* lightBorderColor;
@property (nonatomic, strong, readonly) UIColor* darkBorderColor;

- (id) initWithStyle:(JLStyle) style;

- (UIColor*) getBGColorHighlighted:(BOOL) highlighted;
- (UIColor*) getCancelBGColorHighlighted:(BOOL) highlighted;

- (UIEdgeInsets)getTitleInsets;
- (UIFont *)getTitleFont;
- (NSMutableParagraphStyle *)getTitleParagraphStyle;

/// Text Color Accessors
- (UIFont *) getTextFont;
- (UIColor*) getTextColor:(BOOL) isCancel;
- (UIColor *)getTextColorAtIndex:(NSNumber *)index;
- (UIColor*) getTextShadowColor:(BOOL) isCancel;

@end
