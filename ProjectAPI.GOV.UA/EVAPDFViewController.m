//
//  EVAPDFViewController.m
//  ProjectAPI.GOV.UA
//
//  Created by Admin on 30.04.17.
//  Copyright © 2017 Ehlakov Victor. All rights reserved.
//

#import "EVAPDFViewController.h"
#import "EVADeclaration.h"

@implementation EVAPDFViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    NSURLRequest *request = [NSURLRequest requestWithURL:self.declaration.pdfURL];
    [self.ibWebView loadRequest:request];
    self.ibTitleNavigationItem.title = [NSString stringWithFormat:@"%@ pdf", self.declaration.lastNameString];
    
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
}

- (IBAction)backAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    return YES;
}
@end
