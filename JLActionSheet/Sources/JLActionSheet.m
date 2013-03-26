//
//  JLActionSheet.m
//  JLActionSheet
//
//  Created by Jason Loewy on 1/31/13.
//  Copyright (c) 2013 Jason Loewy. All rights reserved.
//

#import "JLActionSheet.h"
#import <QuartzCore/QuartzCore.h>


#import "JLActionButton.h"


@interface JLActionSheet ()

@property (nonatomic, strong) id<JLActionSheetDelegate> delegate;

@property (nonatomic, strong) NSString* title;
@property (nonatomic, strong) NSString* cancelTitle;
@property (nonatomic, strong) NSArray* buttonTitles;

/// Display Containers
@property (nonatomic, strong) UIPopoverController* popoverController;

@end


@implementation JLActionSheet

/// UI Objects
#define kDefaultStyle STEEL
#define kActionButtonHeight 60.0f

/// Display Macros
#define kBGFadeOpacity .3

/// Animation Macros
#define kBGFadeDuration .2

#pragma mark - 
#pragma mark - Initialization Methods

const NSInteger cancelButtonTag         = 9382;
const NSInteger buttonParentsViewTag    = 28453;
const NSInteger tapBGViewTag            = 4292;

- (id) initWithTitle:(NSString *)title delegate:(id<JLActionSheetDelegate>)delegate cancleButtonTitle:(NSString *)cancelTitle otherButtonTitles:(NSArray *)buttonTitles
{
    if (self = [super init])
    {
        _title              = title;
        _cancelTitle        = cancelTitle;
        _delegate           = delegate;
        _cancelButtonIndex  = -1;
        
        // Reverse the order of the button titles so the buttons are displayed in the correct order
        NSMutableArray* tempTitles  = [[NSMutableArray alloc] initWithCapacity:buttonTitles.count];
        for (NSString* currentTitle in buttonTitles)
            [tempTitles insertObject:currentTitle atIndex:0];
        _buttonTitles = tempTitles;
        
        [self setBackgroundColor:[UIColor clearColor]];
        [self setStyle:kDefaultStyle];
        [self setAutoresizingMask:(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight)];
        [self setAutoresizesSubviews:YES];
        
        // Create the background clear tap responder view
        UITapGestureRecognizer* tapGesture  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissActionSheet:)];
        UIView* tapBGView                   = [[UIView alloc] initWithFrame:self.frame];
        tapBGView.tag                       = tapBGViewTag;
        
        [tapBGView setBackgroundColor:[UIColor colorWithWhite:0.0 alpha:kBGFadeOpacity]];
        [tapBGView addGestureRecognizer:tapGesture];
        [tapBGView setAutoresizingMask:(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight)];
        [self addSubview:tapBGView];
    }
    
    return self;
}


+ (id) sheetWithTitle:(NSString *)title delegate:(id<JLActionSheetDelegate>)delegate cancleButtonTitle:(NSString *)cancelTitle otherButtonTitles:(NSArray *)buttonTitles
{
    return [[JLActionSheet alloc] initWithTitle:title delegate:delegate cancleButtonTitle:cancelTitle otherButtonTitles:buttonTitles];
}

#pragma mark - 
#pragma mark - Presentation Methods


- (UIView*) layoutButtons
{
    JLActionSheetStyle* currentStlye    = [[JLActionSheetStyle alloc] initWithStyle:_style];
    CGFloat buttonHeight                = kActionButtonHeight;
    NSInteger buttonCount               = _cancelTitle ? (_buttonTitles.count + 1) : _buttonTitles.count;
    CGFloat parentViewHeight            = (buttonHeight * buttonCount);
    UIView* buttonParentView            = [[UIView alloc] initWithFrame:CGRectMake(0, (CGRectGetHeight(self.bounds) - parentViewHeight), CGRectGetWidth(self.bounds), parentViewHeight)];
    CGFloat currentButtonTop            = buttonParentView.bounds.size.height - buttonHeight;
    CGFloat currentButtonTag            = 0;
    
    if (_cancelTitle)
    {
        JLActionButton* cancelButton    = [JLActionButton buttonWithStyle:currentStlye andTitle:_cancelTitle isCancel:YES];
        cancelButton.tag                = currentButtonTag++;
        _cancelButtonIndex              = cancelButton.tag;
        
        [cancelButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [cancelButton setFrame:CGRectMake(0, currentButtonTop, CGRectGetWidth(buttonParentView.bounds), buttonHeight)];
        [buttonParentView addSubview:cancelButton];
        
        currentButtonTop -= buttonHeight;
    }
    
    for (NSString* currentButtonTitle in _buttonTitles)
    {
        JLActionButton* currentActionButton = [JLActionButton buttonWithStyle:currentStlye andTitle:currentButtonTitle isCancel:NO];
        currentActionButton.tag             = currentButtonTag++;
        
        [currentActionButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [currentActionButton setFrame:CGRectMake(0, currentButtonTop, CGRectGetWidth(buttonParentView.bounds), buttonHeight)];
        [buttonParentView addSubview:currentActionButton];
        
        currentButtonTop -= buttonHeight;
    }
    
    [buttonParentView setAutoresizingMask:(UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth)];
    [buttonParentView.layer setShadowColor:[UIColor blackColor].CGColor];
    [buttonParentView.layer setShadowOffset:CGSizeMake(0, -3.0f)];
    [buttonParentView.layer setShadowOpacity:.3f];
    [buttonParentView.layer setShadowRadius:4.0f];
    CGPathRef path = [UIBezierPath bezierPathWithRect:buttonParentView.bounds].CGPath;
    [buttonParentView.layer setShadowPath:path];
    return buttonParentView;
}

/*
 Repsonsible for presenting the JLActionSheet from the parentview specified
 Must first make sure that the sizing and origin of the JLActionSheet is correct
 PARAMETERS:
 parentView -> The view that the JLActionSheet is being presented on
 */
- (void) showInView:(UIView *)parentView
{
    UIView* viewToAddTo = [UIApplication sharedApplication].keyWindow.subviews[0];
    [self setFrame:viewToAddTo.bounds];
    
    // Create the parent UIView that houses the JLActionButtons
    UIView* buttonsParentView   = [self layoutButtons];
    buttonsParentView.tag       = buttonParentsViewTag;
    CGPoint originalCenter      = buttonsParentView.center;
    [buttonsParentView setCenter:CGPointMake(buttonsParentView.center.x, (CGRectGetHeight(self.bounds) + (CGRectGetHeight(buttonsParentView.bounds) / 2)))];
    [self addSubview:buttonsParentView];
    
    [self setAlpha:0.0f];
    [viewToAddTo addSubview:self];
    [UIView animateWithDuration:kBGFadeDuration delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        [self setAlpha:1.0f];
        [buttonsParentView setCenter:originalCenter];
    }completion:nil];
}

/*
 Convienence method for displaying on the view of a UIViewController
 Calls showInView: with the view controllers main view
 PARAMETERS:
 parentViewController -> The ViewController that the JLActionSheet will be presented on
 */
- (void) showOnViewController:(UIViewController *)parentViewController { [self showInView:parentViewController.view]; }


- (void) showFromBarItem:(UIBarButtonItem *)barButton onView:(UIView *)parentView
{
    
    // Only show from bar button item in a popover if coming from iPad
    if (UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPad)
        [self showInView:parentView];
    else
    {
        UIView* buttonsParentView       = [self layoutButtons];
        
        NSLog(@"FRAME: %@", NSStringFromCGRect(buttonsParentView.frame));
        NSLog(@"BOUNDS: %@", NSStringFromCGRect(buttonsParentView.bounds));
        
        UIViewController* actionSheetVC = [[UIViewController alloc] init];
        actionSheetVC.view              = buttonsParentView;
        _popoverController = [[UIPopoverController alloc] initWithContentViewController:actionSheetVC];
        [_popoverController setPopoverContentSize:CGSizeMake(_popoverController.popoverContentSize.width, buttonsParentView.bounds.size.height)];
        [_popoverController presentPopoverFromBarButtonItem:barButton permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        NSLog(@"Content Size: %@", NSStringFromCGSize(_popoverController.popoverContentSize));
        
    }
}

- (void) showFromBarItem:(UIBarButtonItem *)barButton onViewController:(UIViewController *)parentViewController { [self showFromBarItem:barButton onView:parentViewController.view]; }

#pragma mark - 
#pragma mark - Dismissal Methods

/*
 Repsonsible for hiding the action sheet
 This is the final method that is called in the lifecycle of the JLAction sheet
 PARAMETERS:
 id -> The object that is triggering the closing of the JLActionsheet
 */
- (void) dismissActionSheet:(id) sender
{
    if (!_popoverController)
    {
        UIView* buttonsParentView = [self viewWithTag:buttonParentsViewTag];
        [UIView animateWithDuration:(kBGFadeDuration + .05) delay:0.175 options:UIViewAnimationOptionCurveLinear animations:^{
            [[self viewWithTag:tapBGViewTag] setAlpha:0.0f];
            [buttonsParentView setCenter:CGPointMake(buttonsParentView.center.x, (CGRectGetHeight(self.bounds) + (CGRectGetHeight(buttonsParentView.bounds) / 2)))];
        }completion:^(BOOL finished){
            [self removeFromSuperview];
            if ([sender isKindOfClass:[JLActionButton class]] && [_delegate respondsToSelector:@selector(actionSheet:didDismissButtonAtIndex:)])
                [_delegate actionSheet:self didDismissButtonAtIndex:((JLActionButton*)sender).tag];
        }];
    }
    else
    {
        [_popoverController dismissPopoverAnimated:YES];
        [_delegate actionSheet:self didDismissButtonAtIndex:((JLActionButton*)sender).tag];
    }
}

/*
 Responsible for reacting to when one of the JLActionButtons are clicked
 Calls the delegate method so the delegate can react and starts the dismissal process
 PARAMETERS:
 sender -> The JLActionButton that was clicked
 */
- (void) buttonClicked:(JLActionButton*) sender
{
    if ([_delegate respondsToSelector:@selector(actionSheet:clickedButtonAtIndex:)])
        [_delegate actionSheet:self clickedButtonAtIndex:sender.tag];
    [self dismissActionSheet:sender];
}

#pragma mark - 
#pragma mark - Accessor Methods

- (NSString*) titleAtIndex:(NSInteger)buttonIndex
{
    NSString* title;
    if (!_cancelTitle)
        title = _buttonTitles[buttonIndex];
    else
        title = (buttonIndex == _cancelButtonIndex) ? _cancelTitle : _buttonTitles[buttonIndex - 1];
    
    return title;
}

/*
 Responsible for determining if the JLActionsheet is currently being presented or not
 */
- (BOOL) isVisible
{
    if (_popoverController)
        return [_popoverController isPopoverVisible] ? YES : NO;
    
    return (self.superview == nil) ? NO : YES;
}

#pragma mark - 
#pragma mark - UI Mutator Methods

/*
 Responsible for configuring if the tap to dismiss is permitted on the background view
 PARAMETERS:
 allowTap -> The flag that determines if the tap to dismiss is allowed or not
 */
- (void) allowTapToDismiss:(BOOL)allowTap
{
    UIView* tapBGView = [self viewWithTag:tapBGViewTag];
    tapBGView.gestureRecognizers = @[];
    
    if (allowTap)
    {
        UITapGestureRecognizer* tapGesture  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissActionSheet:)];
        [tapBGView addGestureRecognizer:tapGesture];        
    }
}

@end
