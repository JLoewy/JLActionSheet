//
//  JLViewController.m
//  JLActionSheet
//
//  Created by Jason Loewy on 1/31/13.
//  Copyright (c) 2013 Jason Loewy. All rights reserved.
//

#import "JLViewController.h"

#import "JLActionSheet.h"

@interface JLViewController () <JLActionSheetDelegate>

@property (nonatomic, strong) JLActionSheet* actionSheet;

@property (weak, nonatomic) IBOutlet UISegmentedControl *itemCountSegmentController;
@property (weak, nonatomic) IBOutlet UISegmentedControl *styleSegmentedController;
@property (weak, nonatomic) IBOutlet UISwitch *showCancelButton;
@property (weak, nonatomic) IBOutlet UISwitch *allowTapSwitch;

@property (weak, nonatomic) IBOutlet UILabel *selectedLabel;
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;

@end

@implementation JLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

#pragma mark - 
#pragma mark - Demo Convenience Methods 

- (IBAction) keyboardDonePressed:(id) sender
{
    [_titleTextField resignFirstResponder];
}

- (JLStyle) getSelectedStyle
{
    JLStyle selectedStyle;
    // Determine which style to be used
    if (_styleSegmentedController.selectedSegmentIndex == 1)
        selectedStyle = JLSTYLE_SUPERCLEAN;
    else if (_styleSegmentedController.selectedSegmentIndex == 2)
        selectedStyle = JLSTYLE_FERRARI;
    else if (_styleSegmentedController.selectedSegmentIndex == 3)
        selectedStyle = JLSTYLE_CLEANBLUE;
    else
        selectedStyle = JLSTYLE_STEEL;
    
    return selectedStyle;
}

- (NSMutableArray*) getButtonTitles
{
    NSMutableArray* buttonTitles = [[NSMutableArray alloc] initWithCapacity:4];
    for (NSInteger i = 0; i < (_itemCountSegmentController.selectedSegmentIndex + 1); i++)
    {
        switch (i) {
            case 0:
                buttonTitles[0] = @"One";
                break;
            case 1:
                buttonTitles[1] = @"Two";
                break;
            case 2:
                buttonTitles[2] = @"Three";
                break;
            case 3:
                buttonTitles[3] = @"Four";
                break;
            default:
                break;
        }
    }
    return buttonTitles;
}

#pragma mark - 
#pragma mark - Presentation Methods

- (IBAction)presentInView:(id)sender
{
    [_titleTextField resignFirstResponder];
    
    NSMutableArray* buttonTitles = [self getButtonTitles];
    NSString* cancelTitle        = [_showCancelButton isOn] ? @"Cancel" : nil;
    NSString* sheetTitle         = (_titleTextField.text.length > 0) ? _titleTextField.text : nil;
    
    _actionSheet                 = [JLActionSheet sheetWithTitle:sheetTitle delegate:self cancelButtonTitle:cancelTitle otherButtonTitles:buttonTitles];
    [_actionSheet allowTapToDismiss:[_allowTapSwitch isOn]];
    [_actionSheet setStyle:[self getSelectedStyle]];
    [_actionSheet showOnViewController:self];
}

- (IBAction)presentFromNavBar:(UIBarButtonItem *)sender
{
    [_titleTextField resignFirstResponder];
    
    NSMutableArray* buttonTitles = [self getButtonTitles];
    NSString* cancelTitle        = [_showCancelButton isOn] ? @"Cancel" : nil;
    NSString* sheetTitle         = (_titleTextField.text.length > 0) ? _titleTextField.text : nil;
    
    _actionSheet                 = [JLActionSheet sheetWithTitle:sheetTitle delegate:self cancelButtonTitle:cancelTitle otherButtonTitles:buttonTitles];    
    [_actionSheet allowTapToDismiss:[_allowTapSwitch isOn]];
    [_actionSheet setStyle:[self getSelectedStyle]];
    [_actionSheet showFromBarItem:sender onViewController:self];
}

/*
 Shows how to use blocks with JLActionSheet
 Setting blocks make them take priority over delegate usage
 */
- (void) addExampleBlocks
{
    [_actionSheet setClickedButtonBlock:^(JLActionSheet* actionSheet, NSInteger buttonIndex){
        NSLog(@"Call Back");
        NSLog(@"Clicked button title: %@", [actionSheet titleAtIndex:buttonIndex]);
    }];
    
    [_actionSheet setDidDismissBlock:^(JLActionSheet* actionSheet, NSInteger buttonIndex){
        NSLog(@"Did Dismiss Block");
    }];
}

#pragma mark - 
#pragma mark - JLActionSheet Delegate

// Called when the action button is initially clicked
- (void) actionSheet:(JLActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"Clicked Button: %d Title: %@", buttonIndex, [actionSheet titleAtIndex:buttonIndex]);
    [_selectedLabel setText:[actionSheet titleAtIndex:buttonIndex]];
    if (buttonIndex == actionSheet.cancelButtonIndex)
        NSLog(@"Is cancel button");
}

// Called when the action button fully disappears from view
- (void) actionSheet:(JLActionSheet *)actionSheet didDismissButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"Did dismiss");
}

@end
