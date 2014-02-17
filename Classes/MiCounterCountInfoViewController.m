//
//  MiCounterCountInfoViewController.m
//  MiCounter
//
//  Created by Derek Maurer on 2/8/14.
//
//

#import "MiCounterCountInfoViewController.h"
#import <Social/Social.h>
#import <MessageUI/MessageUI.h>
#import "SPAlertView.h"

@interface MiCounterCountInfoViewController () <UIActionSheetDelegate, MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate>

@end

@implementation MiCounterCountInfoViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.deleteButton setBackgroundColor:[UIColor colorWithRed:0.702 green:0 blue:0 alpha:0.8]];
    [self.shareButton setBackgroundColor:[UIColor colorWithRed:0.063 green:0.486 blue:0.965 alpha:1.0]];
    
    [self.countLabel setText:self.count];
    [self.countNameLabel setText:self.countName];
}

- (IBAction)shareButtonPressed:(id)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Share" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"SMS",@"Email",@"Facebook", @"Twitter", nil];
    [actionSheet showInView:self.view];
}

- (IBAction)deleteButtonPressed:(id)sender
{
    SPAlertView *alert = [[SPAlertView alloc] initWithTitle:@"Delete" message:@"Are you sure you want to delete this count?\n\n\n" buttons:@[@"Yes"] cancelButton:@"No" andFinishedBlock:^(SPAlertView *alert, int buttonPressed){
        [alert dismiss];
        
        if (buttonPressed == 0)
        {
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            
            if ([defaults objectForKey:@"counts"])
            {
                NSMutableArray *counts = [[NSMutableArray alloc] initWithArray:[defaults objectForKey:@"counts"]];
                
                for (NSDictionary *count in counts)
                {
                    if ([[count objectForKey:@"name"] isEqualToString:self.countName])
                    {
                        [counts removeObject:count];
                        [defaults setObject:counts forKey:@"counts"];
                        break;
                    }
                }
            }
            
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
    [alert show];
}

#pragma mark Delegation
#pragma mark Delegation - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) //SMS
    {
        MFMessageComposeViewController *message = [[MFMessageComposeViewController alloc] init];
        [message setMessageComposeDelegate:self];
        [message setBody:[NSString stringWithFormat:@"MiCounter count: %@",self.count]];
        [self presentViewController:message animated:YES completion:nil];
    }
    else if (buttonIndex == 1) //Email
    {
        MFMailComposeViewController *message = [[MFMailComposeViewController alloc] init];
        [message setMailComposeDelegate:self];
        [message setMessageBody:[NSString stringWithFormat:@"MiCounter count: %@",self.count] isHTML:NO];
        [self presentViewController:message animated:YES completion:nil];
    }
    else if (buttonIndex == 2) //Facebook
    {
        SLComposeViewController *facebook = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        [facebook setInitialText:[NSString stringWithFormat:@"MiCounter count: %@",self.count]];
        [self presentViewController:facebook animated:YES completion:nil];
    }
    else if (buttonIndex == 3) //twitter
    {
        SLComposeViewController *twitter = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        [twitter setInitialText:[NSString stringWithFormat:@"MiCounter count: %@",self.count]];
        [self presentViewController:twitter animated:YES completion:nil];
    }
}

#pragma mark Delegation - MFMessageDelegate

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [controller dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark Delegation - MFMailDelegate

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [controller dismissViewControllerAnimated:YES completion:nil];
}

@end
