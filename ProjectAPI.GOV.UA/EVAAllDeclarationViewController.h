//
//  EVAAllDeclarationViewController.h
//  ProjectAPI.GOV.UA
//
//  Created by Admin on 28.04.17.
//  Copyright © 2017 Ehlakov Victor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EVAAllDeclarationViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *ibSearchTextField;
@property (weak, nonatomic) IBOutlet UITableView *ibTableView;

- (IBAction)addFavoritesAction:(id)sender;
- (IBAction)openPDFAction:(id)sender;
- (IBAction)searchAction:(id)sender;

@end
