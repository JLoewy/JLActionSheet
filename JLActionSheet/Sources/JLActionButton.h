//
//  JLActionButton.h
//  JLActionSheet
//
//  Created by Jason Loewy on 1/31/13.
//  Copyright (c) 2013 Jason Loewy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JLActionSheetStyle;

@interface JLActionButton : UIButton

+ (id) buttonWithStyle:(JLActionSheetStyle*)style andTitle:(NSString *)buttonTitle isCancel:(BOOL) isCancel;

@end
