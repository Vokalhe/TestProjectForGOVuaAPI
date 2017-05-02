//
//  DeclarationCoreData+CoreDataProperties.h
//  ProjectAPI.GOV.UA
//
//  Created by Admin on 30.04.17.
//  Copyright © 2017 Ehlakov Victor. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "DeclarationCoreData.h"

NS_ASSUME_NONNULL_BEGIN

@interface DeclarationCoreData (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *position;
@property (nullable, nonatomic, retain) NSString *placeOfWork;
@property (nullable, nonatomic, retain) NSString *comment;

@end

NS_ASSUME_NONNULL_END
