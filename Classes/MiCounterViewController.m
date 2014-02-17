//
//  MiCounterViewController.m
//  MiCounter
//
//  Created by Derek on 6/22/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "MiCounterViewController.h"
#import "MiCounterSaveViewController.h"
#import "SPAlertView.h"

@interface MiCounterViewController ()
@property (nonatomic, assign) NSInteger count;
@end

@implementation MiCounterViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"currentcount"])
    {
        self.count = [[defaults objectForKey:@"currentcount"] integerValue];
    }
    else
    {
        self.count = 0;
    }
    
    [self.countLabel setText:[NSString stringWithFormat:@"%i",self.count]];
    
    if ([[UIScreen mainScreen] scale] >= 2.0)
    {
        [self.buttonSep setFrame:CGRectMake(self.buttonSep.frame.origin.x, self.buttonSep.frame.origin.y, 0.5, self.buttonSep.frame.size.height)];
    }
    else
    {
        [self.buttonSep setFrame:CGRectMake(self.buttonSep.frame.origin.x, self.buttonSep.frame.origin.y, 1.0, self.buttonSep.frame.size.height)];
    }
}

- (IBAction)plusButtonPressed:(id)sender
{
    self.count++;
    [self.countLabel setText:[NSString stringWithFormat:@"%i",self.count]];
    [self saveCurrentCount];
}

- (IBAction)minusButtonPressed:(id)sender
{
    self.count--;
    [self.countLabel setText:[NSString stringWithFormat:@"%i",self.count]];
    [self saveCurrentCount];
}

- (IBAction)saveButtonPressed:(id)sender
{
    
}

- (IBAction)countsButtonPressed:(id)sender
{
    
}

- (IBAction)resetButtonPressed:(id)sender
{
    SPAlertView *alert = [[SPAlertView alloc] initWithTitle:@"Reset" message:@"Are you sure you want to reset the count?\n\n" buttons:@[@"Yes"] cancelButton:@"No" andFinishedBlock:^(SPAlertView *alert, int buttonPressed){
        if (buttonPressed == 0)
        {
            self.count = 0;
            [self.countLabel setText:[NSString stringWithFormat:@"%i",self.count]];
            [self saveCurrentCount];
        }
        [alert dismiss];
    }];
    
    [alert show];
    
}

- (void)saveCurrentCount
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[NSNumber numberWithInt:self.count] forKey:@"currentcount"];
    [defaults synchronize];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"saveSegue"]) {
        MiCounterSaveViewController *controller = (MiCounterSaveViewController *)segue.destinationViewController;
        controller.count = self.count;
    }
}

@end
