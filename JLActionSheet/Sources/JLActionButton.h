//
//  JLActionButton.h
//  JLActionSheet
//
//  Created by Jason Loewy on 1/31/13.
//  Copyright (c) 2013 Jason Loewy. All rights reserved.
//

@class JLActionSheetStyle;

@interface JLActionButton : UIButton

+ (id) buttonWithStyle:(JLActionSheetStyle*)style andTitle:(NSString *)buttonTitle isCancel:(BOOL) isCancel;

- (void) configureForTitle;

@end
