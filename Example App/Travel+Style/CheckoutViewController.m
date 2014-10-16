//
//  CheckoutViewController.h
//  Travel+Style
//
//  Created by Dashlane.
//  Copyright (c) 2014 Dashlane. All rights reserved.
//

#import "CheckoutViewController.h"
#import "DashlaneExtensionRequestHelper.h"

@interface CheckoutViewController ()

@property (nonatomic, strong) NSString *number;
@property (nonatomic, strong) NSString *month;
@property (nonatomic, strong) NSString *year;
@property (nonatomic, strong) NSString *code;
@end

@implementation CheckoutViewController

@synthesize number = _number;
@synthesize month = _month;
@synthesize year = _year;
@synthesize code = _code;

@synthesize numberLabel = _numberLabel;
@synthesize monthLabel = _monthLabel;
@synthesize yearLabel = _yearLabel;
@synthesize codeLabel = _codeLabel;
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

-(IBAction)showActionView:(id)sender {
    DashlaneExtensionRequestHelper *helper = [[DashlaneExtensionRequestHelper alloc] initWithAppName:@"TravelStyle"];
    
    [helper requestCreditCardWithCompletionBlock:^(NSDictionary *response, NSError *error) {

        NSDictionary *dict = [response objectForKey:DASHLANE_EXTENSION_REQUEST_CREDIT_CARD];
        self.number = [dict objectForKey:DASHLANE_EXTENSION_REQUEST_REPLY_CREDIT_CARD_NUMBER_KEY];
        self.month = [dict objectForKey:DASHLANE_EXTENSION_REQUEST_REPLY_CREDIT_CARD_NUMBER_EXPIRATION_MONTH_KEY];
        self.year = [dict objectForKey:DASHLANE_EXTENSION_REQUEST_REPLY_CREDIT_CARD_NUMBER_EXPIRATION_YEAR_KEY];
        self.code = [dict objectForKey:DASHLANE_EXTENSION_REQUEST_REPLY_CREDIT_CARD_NUMBER_CCV_KEY];
        
        [self performSelector:@selector(startLoading) withObject:nil afterDelay:0.5f];
    }];

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
    
    [self.numberLabel setTextColor:[UIColor blackColor]];
    [self.monthLabel setTextColor:[UIColor blackColor]];
    [self.yearLabel setTextColor:[UIColor blackColor]];
    [self.codeLabel setTextColor:[UIColor blackColor]];
    
    [self.numberLabel setText:self.number];
    [self.monthLabel setText:self.month];
    [self.yearLabel setText:self.year];
    [self.codeLabel setText:self.code];
    
    [self.maskView setHidden:YES];
    [self.spinner setHidden:YES];
}


@end
