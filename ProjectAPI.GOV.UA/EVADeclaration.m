//
//  EVADeclaration.m
//  ProjectAPI.GOV.UA
//
//  Created by Admin on 28.04.17.
//  Copyright © 2017 Ehlakov Victor. All rights reserved.
//

#import "EVADeclaration.h"

@implementation EVADeclaration
-(id)initWithServerResponse:(NSDictionary *)responseObject{
    if(self){
        
        self.nameString = [NSString stringWithFormat:@"%@ %@",[responseObject objectForKey:@"lastname"], [responseObject objectForKey:@"firstname"]];
        self.lastNameString = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"lastname"]];

        self.placeOfWorkString = [responseObject objectForKey:@"placeOfWork"];
        self.positionString = [responseObject objectForKey:@"position"];
        
        NSString *urlString = [responseObject objectForKey:@"linkPDF"];
        self.pdfURL = [NSURL URLWithString:urlString];
        
        self.isFavorites = NO;
    }
    return self;
}

@end
