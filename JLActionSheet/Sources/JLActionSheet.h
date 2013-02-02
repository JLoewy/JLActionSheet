//
//  JLActionSheet.h
//  JLActionSheet
//
//  Created by Jason Loewy on 1/31/13.
//  Copyright (c) 2013 Jason Loewy. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "JLActionSheetStyle.h"

@class JLActionSheet;
@protocol JLActionSheetDelegate <NSObject>

- (void) actionSheet:(JLActionSheet*)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex;
- (void) actionSheet:(JLActionSheet*)actionSheet didDismissButtonAtIndex:(NSInteger)buttonIndex;

@end

@interface JLActionSheet : UIView

// Data Objects
@property (readonly) NSInteger cancelButtonIndex;

// UI Objects
@property JLStyle style;

/// Initialization Methods
+ (id) sheetWithTitle:(NSString*) title delegate:(id<JLActionSheetDelegate>) delegate cancleButtonTitle:(NSString*) cancelTitle otherButtonTitles:(NSArray*) buttonTitles;
- (id) initWithTitle:(NSString*) title delegate:(id<JLActionSheetDelegate>) delegate cancleButtonTitle:(NSString*) cancelTitle otherButtonTitles:(NSArray*) buttonTitles;

/// Presentation Methods
- (void) showInView:(UIView*) parentView;
- (void) showOnViewController:(UIViewController*) parentViewController;
- (void) showFromBarItem:(UIBarButtonItem*) barButton onView:(UIView*) parentView;
- (void) showFromBarItem:(UIBarButtonItem*) barButton onViewController:(UIViewController*) parentViewController;

/// Accessor Methods
- (NSString*) titleAtIndex:(NSInteger)buttonIndex;

/// UI Mutator Methods
- (void) allowTapToDismiss:(BOOL) allowTap;

@end
