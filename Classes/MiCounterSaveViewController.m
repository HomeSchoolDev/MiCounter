//
//  MiCounterSaveViewController.m
//  MiCounter
//
//  Created by Derek Maurer on 2/8/14.
//
//

#import "MiCounterSaveViewController.h"
#import "SPAlertView.h"

@interface MiCounterSaveViewController ()

@end

@implementation MiCounterSaveViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO];
    [self.navigationItem setTitle:@"Counts"];
    
    [self.saveButton setBackgroundColor:[UIColor colorWithRed:0.063 green:0.486 blue:0.965 alpha:1.0]];
    [self.cancelButton setBackgroundColor:[UIColor colorWithRed:0.702 green:0 blue:0 alpha:0.8]];
}

- (IBAction)saveButtonPressed:(id)sender
{
    if ([[self.textField text] isEqualToString:@""])
    {
        SPAlertView *alert = [[SPAlertView alloc] initWithTitle:@"Error" message:@"You must provide a name for your count\n\n" buttons:nil cancelButton:@"OK" andFinishedBlock:^(SPAlertView *alert, int buttonPressed){
            [alert dismiss];
        }];
        [alert show];
    }
    else
    {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        NSMutableArray *counts = nil;
        
        if ([defaults objectForKey:@"counts"])
        {
            counts = [[NSMutableArray alloc] initWithArray:[defaults objectForKey:@"counts"]];
        }
        else {
            counts = [[NSMutableArray alloc] init];
        }
        
        BOOL duplicate = NO;
        
        for (NSDictionary *count in counts)
        {
            if ([[count objectForKey:@"name"] isEqualToString:self.textField.text])
            {
                duplicate = YES;
            }
        }
        
        if (duplicate)
        {
            [self.textField resignFirstResponder];
            
            SPAlertView *alert = [[SPAlertView alloc] initWithTitle:@"Error" message:@"Duplicate name. Please choose a different name.\n\n" buttons:nil cancelButton:@"OK" andFinishedBlock:^(SPAlertView *alert, int buttonPressed){
                [alert dismiss];
            }];
            [alert show];
        }
        else
        {
            [counts addObject:@{@"count" : [NSNumber numberWithInt:self.count], @"name" : self.textField.text}];
            
            [defaults setObject:counts forKey:@"counts"];
            [defaults synchronize];
            
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }
}

- (IBAction)cancelButtonPressed:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
