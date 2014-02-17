//
//  MiCounterCountsViewController.m
//  MiCounter
//
//  Created by Derek Maurer on 2/8/14.
//
//

#import "MiCounterCountsViewController.h"
#import "MiCounterCountInfoViewController.h"

@interface MiCounterCountsViewController ()
@property (nonatomic, strong) NSMutableArray *counts;
@end

@implementation MiCounterCountsViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO];
    [self.navigationItem setTitle:@"Counts"];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"counts"])
    {
        self.counts = [[NSMutableArray alloc] initWithArray:[defaults objectForKey:@"counts"]];
    }
    else
    {
        self.counts = [[NSMutableArray alloc] init];
    }
    
    [self.tableView reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    [[cell textLabel] setText:[[self.counts objectAtIndex:indexPath.row] objectForKey:@"name"]];
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.counts.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self performSegueWithIdentifier:@"ShowCountInfo" sender:indexPath];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *indexPath = (NSIndexPath *)sender;
    if ([[segue identifier] isEqualToString:@"ShowCountInfo"])
    {
        MiCounterCountInfoViewController *info = (MiCounterCountInfoViewController*)[segue destinationViewController];
        [info setCountName:[[self.counts objectAtIndex:indexPath.row] objectForKey:@"name"]];
        [info setCount:[[[self.counts objectAtIndex:indexPath.row] objectForKey:@"count"] stringValue]];
    }
}

@end
