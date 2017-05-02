//
//  EVAFavoritesDeclarationTableViewController.m
//  ProjectAPI.GOV.UA
//
//  Created by Admin on 30.04.17.
//  Copyright © 2017 Ehlakov Victor. All rights reserved.
//

#import "EVAFavoritesDeclarationTableViewController.h"
#import "EVAFavoritesCell.h"
#import "EVADeclaration.h"

#import "EVADataManager.h"
#import "DeclarationCoreData.h"
#import <CoreData/CoreData.h>

@implementation EVAFavoritesDeclarationTableViewController
@synthesize fetchedResultsController = _fetchedResultsController;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView setContentInset:UIEdgeInsetsMake(20, 0, 50, 0)];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest* fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription* description =
    [NSEntityDescription entityForName:@"DeclarationCoreData"
                inManagedObjectContext:self.managedObjectContext];
    
    [fetchRequest setEntity:description];
    
    NSSortDescriptor* nameDescription =
    [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    
    [fetchRequest setSortDescriptors:@[nameDescription]];
    
    
    NSFetchedResultsController *aFetchedResultsController =
    [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                        managedObjectContext:self.managedObjectContext
                                          sectionNameKeyPath:nil
                                                   cacheName:@"Master"];
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
    NSError *error = nil;
    if (![self.fetchedResultsController performFetch:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _fetchedResultsController;
}

#pragma mark - UITableViewDataSource

- (void)configureCell:(EVAFavoritesCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    DeclarationCoreData *coreDataDeclaration = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    [cell configureCellDeclaration:coreDataDeclaration viewController:self];

    cell.nameFavoritesLabel.text = [NSString stringWithFormat:@"ПІБ: %@",coreDataDeclaration.name];
    cell.positionFavoritesLabel.text = [NSString stringWithFormat:@"Посада: %@",coreDataDeclaration.position ];
    cell.placeOfWorkFavoritesLabel.text = [NSString stringWithFormat:@"Місце роботи: %@",coreDataDeclaration.placeOfWork ];
    cell.commentFavoritesLabel.text = coreDataDeclaration.comment;

    [cell.addCommentButton setImage:[UIImage imageNamed:@"Comment.png"] forState:UIControlStateNormal];
    [cell.addCommentButton addTarget:self action:@selector(addCommentAction:) forControlEvents:UIControlEventTouchUpInside];


}

#pragma mark - UITableViewDelegate
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DeclarationCoreData *coreDataDeclaration = [self.fetchedResultsController objectAtIndexPath:indexPath];
    return [EVAFavoritesCell heightForDeclaration:coreDataDeclaration viewController:self];
    
}

#pragma mark - Actions
-(void) addCommentAction:(UIButton*) button{
    
    UITableViewCell *cell = (UITableViewCell *)button.superview.superview;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    DeclarationCoreData *coreDataDeclaration = [self.fetchedResultsController objectAtIndexPath:indexPath];

    UIAlertController * alertController = [UIAlertController alertControllerWithTitle: @"Коментар:"
                                                                              message: @"напишіть свій коментар"
                                                                       preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Коментар";
        textField.textColor = [UIColor blueColor];
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.borderStyle = UITextBorderStyleRoundedRect;
    }];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Відмінити" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        [alertController dismissViewControllerAnimated:YES completion:nil];
        
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Видалити" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [coreDataDeclaration setValue:@"" forKey:@"comment"];
        NSError *error = nil;
        if ([self.managedObjectContext hasChanges] && ![self.managedObjectContext save:&error]) {
            NSLog(@"Save Failed! %@ %@", error, [error localizedDescription]);
        }
        [self.tableView reloadData];

        [alertController dismissViewControllerAnimated:YES completion:nil];
        
    }]];

    [alertController addAction:[UIAlertAction actionWithTitle:@"Зберегти" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSArray * textfields = alertController.textFields;
        UITextField *commentField = textfields[0];
        
        [coreDataDeclaration setValue:[NSString stringWithFormat:@"Коментар: %@", commentField.text] forKey:@"comment"];
        NSError *error = nil;
        if ([self.managedObjectContext hasChanges] && ![self.managedObjectContext save:&error]) {
            NSLog(@"Save Failed! %@ %@", error, [error localizedDescription]);
        }
        [self.tableView reloadData];
        NSLog(@"%@",commentField.text);
        [alertController dismissViewControllerAnimated:YES completion:nil];

    }]];
    [self presentViewController:alertController animated:YES completion:nil];
    
}
@end
