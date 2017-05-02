//
//  EVADeclaration.h
//  ProjectAPI.GOV.UA
//
//  Created by Admin on 28.04.17.
//  Copyright © 2017 Ehlakov Victor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EVADeclaration : NSObject
@property (strong, nonatomic) NSString *nameString;
@property (strong, nonatomic) NSString *lastNameString;

@property (strong, nonatomic) NSString *placeOfWorkString;
@property (strong, nonatomic) NSString *positionString;
@property (strong, nonatomic) NSURL *pdfURL;

@property (strong, nonatomic) NSString *commentString;
@property (assign, nonatomic) BOOL isFavorites;

-(id)initWithServerResponse:(NSDictionary *)responseObject;

@end
