//
//  DetailViewController.h
//  Travel+Style
//
//  Created by Samir on 02/09/14.
//  Copyright (c) 2014 Dashlane Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

