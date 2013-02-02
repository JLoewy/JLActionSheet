//
//  JLActionSheetStyle.h
//  JLActionSheet
//
//  Created by Jason Loewy on 2/1/13.
//  Copyright (c) 2013 Jason Loewy. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum JLStyle {
    STEEL,
    SUPERCLEAN,
    CLEANBLUE,
    FERRARI
} JLStyle;

@interface JLActionSheetStyle : NSObject

/// Border Colors
@property (nonatomic, strong, readonly) UIColor* lightBorderColor;
@property (nonatomic, strong, readonly) UIColor* darkBorderColor;

- (id) initWithStyle:(JLStyle) style;

- (UIColor*) getBGColorHighlighted:(BOOL) highlighted;
- (UIColor*) getCancelBGColorHighlighted:(BOOL) highlighted;

/// Text Color Accessors
- (UIColor*) getTextColor:(BOOL) isCancel;
- (UIColor*) getTextShadowColor:(BOOL) isCancel;

@end
