//
//  CheckoutViewController.h
//  Travel+Style
//
//  Created by Dashlane.
//  Copyright (c) 2014 Dashlane Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CheckoutViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIButton *actionButton;
@property (strong, nonatomic) IBOutlet UILabel *numberLabel;
@property (strong, nonatomic) IBOutlet UILabel *monthLabel;
@property (strong, nonatomic) IBOutlet UILabel *yearLabel;
@property (strong, nonatomic) IBOutlet UILabel *codeLabel;

@property (nonatomic, strong) IBOutlet UIActivityIndicatorView *spinner;
@property (nonatomic, strong) IBOutlet UIView *maskView;

@end
