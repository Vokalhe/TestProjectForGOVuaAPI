//
//  EVAFavoritesDeclarationTableViewController.h
//  ProjectAPI.GOV.UA
//
//  Created by Admin on 30.04.17.
//  Copyright © 2017 Ehlakov Victor. All rights reserved.
//

#import "EVACoreDataTableViewController.h"

@class DeclarationCoreData;

@interface EVAFavoritesDeclarationTableViewController : EVACoreDataTableViewController 

@property (strong, nonatomic) DeclarationCoreData* coreDataDeclaration;

@end
