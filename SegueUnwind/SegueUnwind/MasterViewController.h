//
//  MasterViewController.h
//  SegueUnwind
//
//  Created by Satoshi Ohki on 2014/02/02.
//  Copyright (c) 2014年 Satoshi Ohki. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <CoreData/CoreData.h>

@interface MasterViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
