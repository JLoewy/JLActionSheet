//
//  JLAppDelegate.h
//  JLActionSheet
//
//  Created by Jason Loewy on 1/31/13.
//  Copyright (c) 2013 Jason Loewy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JLViewController;

@interface JLAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) JLViewController *viewController;

@end
