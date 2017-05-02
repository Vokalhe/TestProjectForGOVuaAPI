//
//  EVAAllDeclarationViewController.m
//  ProjectAPI.GOV.UA
//
//  Created by Admin on 28.04.17.
//  Copyright © 2017 Ehlakov Victor. All rights reserved.
//

#import "EVAAllDeclarationViewController.h"
#import "AFNetworking.h"

#import "EVADeclaration.h"
#import "EVAServerManager.h"
#import "EVAAllDeclarationCell.h"

#import "EVAPDFViewController.h"
#import "Reachability.h"

#import "EVADataManager.h"
#import "DeclarationCoreData.h"
#import <CoreData/CoreData.h>

@interface EVAAllDeclarationViewController () <UITableViewDataSource, UITableViewDelegate, UIWebViewDelegate, UITextFieldDelegate, NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSMutableArray *arrayOfDeclaration;
@property (strong, nonatomic) NSString *searchString;
@property (strong, nonatomic) NSManagedObjectContext* managedObjectContext;
@property (assign, nonatomic) BOOL isAddedToFavorites;

@end

@implementation EVAAllDeclarationViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.arrayOfDeclaration = [NSMutableArray array];
    self.searchString = @"";
    [self.ibSearchTextField becomeFirstResponder];
    [self setup];
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    [self checkForNetwork];


}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.ibTableView reloadData];

}


- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

#pragma mark - Private Method 
-(void) setup{
    
    if (!self.managedObjectContext) {
        self.managedObjectContext = [[EVADataManager sharedManager] managedObjectContext];
    }

}
- (void)checkForNetwork
{
    Reachability *myNetwork = [Reachability reachabilityWithHostname:@"google.com"];
    NetworkStatus myStatus = [myNetwork currentReachabilityStatus];
    
    switch (myStatus) {
        case NotReachable:
            [self showAlertTitle:@"Is the Internet connected?" andMessage:@"There's no internet connection at all. Display error message now."];
            break;
            
        case ReachableViaWWAN:
            //[self showAlertTitle:@"Is the Internet connected?" andMessage:@"You have a 3G connection"];
            break;
            
        case ReachableViaWiFi:
            //[self showAlertTitle:@"Is the Internet connected?" andMessage:@"You have WiFi."];
            break;
            
        default:
            break;
    }
 
}

-(void) showAlertTitle:(NSString*) title andMessage:(NSString*) message{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [self presentViewController:alert animated:YES completion:^{
        double delayInSeconds = 2.0;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self dismissViewControllerAnimated:YES completion:nil];
        });
    }];
    
}

#pragma mark - API
-(void) searchDeclaration{
   
    if (![self.ibSearchTextField.text isEqualToString:self.searchString]){
        
        [[EVAServerManager sharedManager] getDeclarationsGroupWithSearchText:self.ibSearchTextField.text onSuccess:^(NSArray *arrayOfDeclarations) {
            
            if (arrayOfDeclarations) {
                
                [self.arrayOfDeclaration removeAllObjects];
                [self.arrayOfDeclaration addObjectsFromArray:arrayOfDeclarations];
                [self.ibTableView reloadData];
                
            }
            if ([arrayOfDeclarations count] == 0) {
                [self showAlertTitle:@"Помилка!" andMessage:@"Декларацій не знайдено"];
            }
            
        } onFailure:^(NSError *error, NSInteger statusCode) {
            
            NSLog(@"%@, %ld", [error localizedDescription], statusCode);
            [self showAlertTitle:@"Помилка!" andMessage:@"Декларацій не отримано"];

        }];
        
    }else{
        
        [self showAlertTitle:@"Помилка!" andMessage:@"Введіть інші дані"];

    }
    self.searchString = self.ibSearchTextField.text;
    self.ibSearchTextField.text = @"";
    [self.view endEditing:YES];

}
#pragma mark - Actions

- (void)addFavoritesAction:(UIButton*)button{
    
    self.isAddedToFavorites = NO;
    UITableViewCell *cell = (UITableViewCell *)button.superview.superview;
    NSIndexPath *indexPath = [self.ibTableView indexPathForCell:cell];
    EVADeclaration *declaration = [self.arrayOfDeclaration objectAtIndex:indexPath.row];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"DeclarationCoreData"];
    NSError *requestError = nil;
    NSArray *arrayDeclarations = [self.managedObjectContext executeFetchRequest:fetchRequest error:&requestError];
    
    if ([arrayDeclarations count] > 0) {
        for (DeclarationCoreData *thisDeclaration in arrayDeclarations){
           
            if ([declaration.nameString isEqualToString:thisDeclaration.name] && [declaration.positionString isEqualToString:thisDeclaration.position] && [declaration.placeOfWorkString isEqualToString:thisDeclaration.placeOfWork]) {
                
                UIAlertController * alertController = [UIAlertController alertControllerWithTitle: @"Ця людина вже в favorites:" message: @"Бажаете видалити?" preferredStyle:UIAlertControllerStyleAlert];
                
                [alertController addAction:[UIAlertAction actionWithTitle:@"Видалити" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    
                    declaration.isFavorites = NO;
                    self.isAddedToFavorites = YES;
                    NSLog(@"aaaaa%d", declaration.isFavorites);
                    [self.managedObjectContext deleteObject:thisDeclaration];
                    
                    // Save the context
                    NSError *error = nil;
                    if ([self.managedObjectContext hasChanges] && ![self.managedObjectContext save:&error]) {
                        NSLog(@"Save Failed! %@ %@", error, [error localizedDescription]);
                    }

                    [self.ibTableView reloadData];


                    [alertController dismissViewControllerAnimated:YES completion:nil];
                    
                }]];
                
                [alertController addAction:[UIAlertAction actionWithTitle:@"Скасувати" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    
                    [alertController dismissViewControllerAnimated:YES completion:nil];
                    
                }]];
                
                [self presentViewController:alertController animated:YES completion:nil];
                NSLog(@"aaaaa%d", declaration.isFavorites);

                declaration.isFavorites = NO;
                self.isAddedToFavorites = YES;
                 
                [self.ibTableView reloadData];

                // Save the context
                NSError *error = nil;
                if ([self.managedObjectContext hasChanges] && ![self.managedObjectContext save:&error]) {
                    NSLog(@"Save Failed! %@ %@", error, [error localizedDescription]);
                }

                break;

            }
        }
    }
    
    if ([arrayDeclarations count] == 0 || !self.isAddedToFavorites ) {
        
        self.isAddedToFavorites = YES;
        DeclarationCoreData *addDeclaration = [NSEntityDescription insertNewObjectForEntityForName:@"DeclarationCoreData" inManagedObjectContext:self.managedObjectContext];
        
        [addDeclaration setValue:declaration.nameString forKey:@"name"];
        [addDeclaration setValue:declaration.positionString forKey:@"position"];
        [addDeclaration setValue:declaration.placeOfWorkString forKey:@"placeOfWork"];
        
        // Save the context
        NSError *error = nil;
        if ([self.managedObjectContext hasChanges] && ![self.managedObjectContext save:&error]) {
            NSLog(@"Save Failed! %@ %@", error, [error localizedDescription]);
        }
        declaration.isFavorites = YES;
        [self.ibTableView reloadData];
        
    }
}

- (void)openPDFAction:(UIButton*)button{
    
    UITableViewCell *cell = (UITableViewCell *)button.superview.superview;
    NSIndexPath *indexPath = [self.ibTableView indexPathForCell:cell];
    EVADeclaration *declaration = [self.arrayOfDeclaration objectAtIndex:indexPath.row];

    if (declaration.pdfURL) {
        
        EVAPDFViewController *pdfController = [self.storyboard instantiateViewControllerWithIdentifier:@"EVAPDFViewController"];
        pdfController.declaration = declaration;
        [self presentViewController:pdfController animated:YES completion:nil];

    }else{
        
        [self showAlertTitle:@"Помилка!" andMessage:@"PDF декларації не існує"];

    }
    
}
- (IBAction)searchAction:(id)sender{
    [self searchDeclaration];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.arrayOfDeclaration count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    EVADeclaration *declaration = [self.arrayOfDeclaration objectAtIndex:indexPath.row];
    
    static NSString *identifier = @"EVAAllDeclarationCell";
    
    EVAAllDeclarationCell *declarationCell = [tableView dequeueReusableCellWithIdentifier:identifier];

    if (!declarationCell) {
        declarationCell = [[EVAAllDeclarationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    [declarationCell configureCellDeclaration:declaration viewController:self];
    
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"DeclarationCoreData"];
    NSError *requestError = nil;
    NSArray *arrayDeclarations = [self.managedObjectContext executeFetchRequest:fetchRequest error:&requestError];
    
    if([arrayDeclarations count] > 0){
        
        for (DeclarationCoreData *thisDeclaration in arrayDeclarations){
            
            if ([declaration.nameString isEqualToString:thisDeclaration.name] && [declaration.positionString isEqualToString:thisDeclaration.position] && [declaration.placeOfWorkString isEqualToString:thisDeclaration.placeOfWork]) {
                
                declaration.isFavorites = YES;
                break;
                
            }
            
        }
        
    }else{
        declaration.isFavorites = NO;
    }
    
    if (declaration.isFavorites) {
        [declarationCell.favoritiesButton setImage:[UIImage imageNamed:@"Favorites.png"] forState:UIControlStateNormal];
    } else {
        [declarationCell.favoritiesButton setImage:[UIImage imageNamed:@"NotFavorites.png"] forState:UIControlStateNormal];
    }

    [declarationCell.favoritiesButton addTarget:self action:@selector(addFavoritesAction:) forControlEvents:UIControlEventTouchUpInside];
    
    

    [declarationCell.pdfButton addTarget:self action:@selector(openPDFAction:) forControlEvents:UIControlEventTouchUpInside];
    if (declaration.pdfURL) {
        [declarationCell.pdfButton setImage:[UIImage imageNamed:@"Book.png"] forState:UIControlStateNormal];
    }else{
        [declarationCell.pdfButton setImage:[UIImage imageNamed:@"NotBook.png"] forState:UIControlStateNormal];
    }
    
    
    declarationCell.nameLabel.text = [NSString stringWithFormat:@"ПІБ: %@", declaration.nameString];
    declarationCell.placeOfWorkLabel.text = [NSString stringWithFormat:@"Місце роботи: %@",declaration.placeOfWorkString];
    declarationCell.positionLabel.text = [NSString stringWithFormat:@"Посада: %@",declaration.positionString];
    
    return declarationCell;

}

#pragma mark - UITableViewDelegate

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    EVADeclaration* declaration = [self.arrayOfDeclaration objectAtIndex:indexPath.row];
    return [EVAAllDeclarationCell heightForDeclaration:declaration viewController:self];
    
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.view endEditing:YES];

    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    NSMutableString *stringOfBadLetterBig = [[NSMutableString alloc] initWithString:@"ЙЦУКЕНГШЩЗХФВАПРОЛДЖЯЧСМИТЬБЮҐЇІЄйцукенгшщзхфвапролджячсмитьбюґєії"];
    NSCharacterSet *setOfValidLetterBig = [[NSCharacterSet characterSetWithCharactersInString:stringOfBadLetterBig] invertedSet];
    NSArray *arrayLetterBig = [string componentsSeparatedByCharactersInSet:setOfValidLetterBig];
    if ([arrayLetterBig count] > 1) {
        return NO;
    }
    return YES;
    
}
@end
