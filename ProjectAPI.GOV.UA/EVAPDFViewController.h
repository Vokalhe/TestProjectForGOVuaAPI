//
//  EVAPDFViewController.h
//  ProjectAPI.GOV.UA
//
//  Created by Admin on 30.04.17.
//  Copyright © 2017 Ehlakov Victor. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EVADeclaration;

@interface EVAPDFViewController : UIViewController <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UINavigationItem *ibTitleNavigationItem;

@property (weak, nonatomic) IBOutlet UIWebView *ibWebView;

@property (strong, nonatomic) EVADeclaration *declaration;

- (IBAction)backAction:(id)sender;

@end
