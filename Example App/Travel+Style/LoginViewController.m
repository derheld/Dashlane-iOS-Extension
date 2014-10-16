//
//  LoginViewController.m
//  Travel+Style
//
//  Created by Dashlane.
//  Copyright (c) 2014 Dashlane Inc. All rights reserved.
//

#import "LoginViewController.h"
#import "DashlaneExtensionRequestHelper.h"

@interface LoginViewController ()

@property (nonatomic, strong) NSString *login;
@property (nonatomic, strong) NSString *password;


@end

@implementation LoginViewController

@synthesize login = _login;
@synthesize password = _password;

@synthesize loginField = _loginField;
@synthesize passwordField = _passwordField;
@synthesize loginButton = _loginButton;
@synthesize loginWithDashlaneButton = _loginWithDashlaneButton;
@synthesize spinner = _spinner;
@synthesize maskView = _maskView;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.spinner setHidden:YES];
    [self.maskView setHidden:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//
// IBActions
//

- (IBAction)getCredentialsFromDashlane:(id)sender {
    
    DashlaneExtensionRequestHelper *helper = [[DashlaneExtensionRequestHelper alloc] initWithAppName:@"travelplusstyle"];
    [helper requestLoginAndPasswordWithCompletionBlock:^(NSDictionary *response, NSError *error) {
        
        NSDictionary *dict = [response objectForKey:DASHLANE_EXTENSION_REQUEST_LOGIN];
        self.login = [dict objectForKey:DASHLANE_EXTENSION_REQUEST_REPLY_LOGIN_KEY];
        self.password = [dict objectForKey:DASHLANE_EXTENSION_REQUEST_REPLY_PASSWORD_KEY];
        
//        [self performSelector:@selector(startLoading) withObject:nil afterDelay:0.5f];
        if (self.login && self.password)
            [self startLoading];
    }];
}

-(IBAction)login:(id)sender {
//    [self startLoading];
}

- (void) startLoading {
    [self.spinner setAlpha:0.f];
    [self.maskView setAlpha:0.f];

    [self.spinner setHidden:NO];
    [self.maskView setHidden:NO];
    
    [UIView animateWithDuration:0.5f animations:^{
        [self.maskView setAlpha:0.5f];
    } completion:^(BOOL finished) {
        [self.spinner setAlpha:1.f];
        [self.spinner startAnimating];
        
        [self performSelector:@selector(endLoading) withObject:nil afterDelay:0.5f];
    }];
}

- (void) endLoading {
    [self.spinner stopAnimating];
    [self.maskView setHidden:YES];
    [self.spinner setHidden:YES];
    
    [self.passwordField setTextColor:[UIColor blackColor]];
    [self.loginField setTextColor:[UIColor blackColor]];
    
    [self.passwordField setSecureTextEntry:YES];
    [self.loginField setText:self.login];
    [self.passwordField setText:self.password];
    [self performSelector:@selector(showProfile) withObject:nil afterDelay:0.5f];
}

- (void) showProfile {
    [self performSegueWithIdentifier:@"showProfile" sender:self];
}

@end
