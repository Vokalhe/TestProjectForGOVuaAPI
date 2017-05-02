//
//  EVADataManager.h
//  ProjectAPI.GOV.UA
//
//  Created by Admin on 30.04.17.
//  Copyright © 2017 Ehlakov Victor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class DeclarationCoreData, EVADeclaration;

@interface EVADataManager : NSObject
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

+(EVADataManager*) sharedManager;
- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

-(DeclarationCoreData*)addDeclaration:(EVADeclaration*) declaration;
-(void) deleteAllObjects;

- (NSManagedObjectContext *)managedObjectContext;

@end
