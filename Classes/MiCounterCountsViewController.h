//
//  MiCounterCountsViewController.h
//  MiCounter
//
//  Created by Derek Maurer on 2/8/14.
//
//

#import <UIKit/UIKit.h>

@interface MiCounterCountsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, retain) IBOutlet UITableView *tableView;
@end
