//
//  DashlaneExtensionRequestHelper.m
//  DashlanePhoneFinal
//
//  Created by Samir on 06/08/14.
//  Copyright (c) 2014 Dashlane. All rights reserved.
//

#import "DashlaneExtensionRequestHelper.h"

@interface DashlaneExtensionRequestHelper()

@property (nonatomic, strong) NSString       *appName;
@property (nonatomic, strong) NSMutableArray *currentRequestItems;
@property (nonatomic) UIViewController *presentFromViewController;

- (UIActivityViewController *)_activityViewControllerWithExtensionItem:(NSExtensionItem *)extensionItem;
- (NSExtensionItem *)_extensionItemForCurrentItemProviders;
- (void)_processRequestReturnedItems:(NSArray *)returnedItems withCompletionBlock:(RequestCompletionBlock)completionBlock;

@end

@implementation DashlaneExtensionRequestHelper

#pragma mark - Init

- (instancetype)initWithAppName:(NSString *)appName presentFrom:(UIViewController *)vc
{
    self = [super init];
    
    if (self){
        self.appName = appName;
		self.presentFromViewController = vc;
    }
    
    return self;
}


#pragma mark - Getters/Setters

- (NSMutableArray *)currentRequestItems
{
    if (!_currentRequestItems){
        self.currentRequestItems = [NSMutableArray array];
    }
    
    return _currentRequestItems;
}


- (void)startNewRequest
{
    self.currentRequestItems = nil;
}

- (void)addRequest:(NSString *)requestIdentifier matchingString:(NSString *)stringToMatch
{
    NSItemProvider *requestItemProvider = [[NSItemProvider alloc] initWithItem:stringToMatch ? @{DASHLANE_EXTENSION_REQUEST_STRING_TO_MATCH_KEY : stringToMatch} : @{} typeIdentifier:requestIdentifier];
    
    [self.currentRequestItems addObject:requestItemProvider];;
}

- (void)sendRequestWithCompletionBlock:(RequestCompletionBlock)completionBlock
{
    NSExtensionItem *extensionItem = [self _extensionItemForCurrentItemProviders];
    
    if (extensionItem){
        UIActivityViewController *activityController = [self _activityViewControllerWithExtensionItem:extensionItem];
        
        [activityController setCompletionWithItemsHandler:^(NSString *activityType, BOOL completed, NSArray *returnedItems, NSError *activityError) {
            if (!completed){
                completionBlock(nil, activityError ? activityError : [NSError errorWithDomain:DASHLANE_EXTENSION_ERROR code:DashlaneExtensionErrorUserCancelled userInfo:@{NSLocalizedDescriptionKey : @"User has canceled the extension"}]);
            }if (activityError){
                completionBlock(nil, activityError);
            }else{
                [self _processRequestReturnedItems:returnedItems withCompletionBlock:completionBlock];
            }
        }];
        
        [self.presentFromViewController presentViewController:activityController animated:YES completion:nil];
    }
}

- (void)requestLoginAndPasswordWithCompletionBlock:(RequestCompletionBlock)completionBlock
{
    [self startNewRequest];
    
    [self addRequest:DASHLANE_EXTENSION_REQUEST_LOGIN matchingString:nil];
    [self sendRequestWithCompletionBlock:completionBlock];
}

- (void)requestLoginAndPasswordForAService:(NSString *)serviceName withCompletionBlock:(RequestCompletionBlock)completionBlock;
{
    [self startNewRequest];
    
    [self addRequest:DASHLANE_EXTENSION_REQUEST_LOGIN matchingString:serviceName];
    [self sendRequestWithCompletionBlock:completionBlock];
}

- (void)requestCreditCardWithCompletionBlock:(RequestCompletionBlock)completionBlock
{
    [self startNewRequest];
    
    [self addRequest:DASHLANE_EXTENSION_REQUEST_CREDIT_CARD matchingString:nil];
    [self sendRequestWithCompletionBlock:completionBlock];
}

- (void)requestAddressWithCompletionBlock:(RequestCompletionBlock)completionBlock
{
    [self startNewRequest];
    
    [self addRequest:DASHLANE_EXTENSION_REQUEST_ADDRESS matchingString:nil];
    [self sendRequestWithCompletionBlock:completionBlock];
}

- (void)requestIdentityInfoWithCompletionBlock:(RequestCompletionBlock)completionBlock
{
    [self startNewRequest];
    
    [self addRequest:DASHLANE_EXTENSION_REQUEST_IDENTITY_INFO matchingString:nil];
    [self sendRequestWithCompletionBlock:completionBlock];
}

- (void)requestPhoneNumberWithCompletionBlock:(RequestCompletionBlock)completionBlock
{
    [self startNewRequest];
    
    [self addRequest:DASHLANE_EXTENSION_REQUEST_PHONE_NUMBER matchingString:nil];
    [self sendRequestWithCompletionBlock:completionBlock];
}

- (void)requestPassportInfoWithCompletionBlock:(RequestCompletionBlock)completionBlock
{
    [self startNewRequest];
    
    [self addRequest:DASHLANE_EXTENSION_REQUEST_PASSPORT_INFO matchingString:nil];
    [self sendRequestWithCompletionBlock:completionBlock];
}


#pragma mark - Utility methods

- (UIActivityViewController *)_activityViewControllerWithExtensionItem:(NSExtensionItem *)extensionItem
{
    UIActivityViewController *activityController = [[UIActivityViewController alloc] initWithActivityItems:@[extensionItem] applicationActivities:nil];
    
    activityController.excludedActivityTypes = @[ UIActivityTypeMail, UIActivityTypeAirDrop, UIActivityTypePostToFlickr, UIActivityTypeSaveToCameraRoll, UIActivityTypePostToTwitter, UIActivityTypeCopyToPasteboard, UIActivityTypeMessage, UIActivityTypePrint, UIActivityTypePostToFacebook, UIActivityTypeAddToReadingList, UIActivityTypePostToWeibo, UIActivityTypeAssignToContact, UIActivityTypePostToVimeo, UIActivityTypePostToTencentWeibo ];
    
    return activityController;
}

- (NSExtensionItem *)_extensionItemForCurrentItemProviders
{
    NSExtensionItem *extensionItem = [[NSExtensionItem alloc] init];
    extensionItem.userInfo = @{DASHLANE_EXTENSION_REQUEST_APP_NAME_KEY : self.appName};
    extensionItem.attachments = self.currentRequestItems;
    
    return extensionItem;
}

- (void)_processRequestReturnedItems:(NSArray *)returnedItems withCompletionBlock:(RequestCompletionBlock)completionBlock
{
    NSError *error = nil;
    
    NSExtensionItem *returnedItem = returnedItems.firstObject;
    
    if ([returnedItem isKindOfClass:[NSExtensionItem class]] && returnedItem.attachments && returnedItem.attachments.count > 0){
        NSDictionary *returnedData = returnedItem.attachments.firstObject;
        
        if (returnedData && returnedData.count > 0){
            
            completionBlock(returnedData, nil);
            
        }else{
            
        }
    }else{
        //error
    }
    
    if (error){
        //error
    }
}

@end
