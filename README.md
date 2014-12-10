Dashlane App Extension for iOS 8
======================
<a href="https://d38muu3h4xeqr1.cloudfront.net/Dashlane-iOS8.mp4" target="_blank"><img src="https://www.dashlane.com/images/ios8-partners.png" width="640" height="360"></a>

iOS 8 has an incredible feature called [App Extensions](https://developer.apple.com/library/ios/documentation/General/Conceptual/ExtensibilityPG/index.html). At Dashlane, we built a powerful and easy-to-implement App Extension for use in your apps. By using the Dashlane App Extension featured in the video above, you will enhance user experience and increase app engagement by eliminating manual data entry in three key areas:

1. **Login** – How many times have you opened an app only to close it because you didn’t remember the password? Dashlane users manage over 50 million passwords, so you could reduce the number of lost interactions
2. **Checkout** – Are your users putting items in their cart, but not checking out? Let Dashlane assist with checkout by autofilling user information. Dashlane has already facilitated over $1B in transactions.
3. **Sign-up** – Need users to sign up to use your app? Dashlane has millions of users ready to use your app with the ease of Dashlane registration (coming soon).

What data can be requested
======================
* Login and password
* Address
* Credit Card
* Phone number
* Passport info

Getting started with setup
======================
Supporting the Dashlane Extension is similar to general iOS 8 Extension support. A UI element (e.g. a UIButton) needs to be added to trigger a UIActivityViewController instance which is going to present the iOS 8 extension selection UI components. Also, the Dashlane Extension uses NSItemProvider to build the request before passing it to the instance of UIActivityViewController via NSExtensionItem attachments.

DashlaneExtensionRequestHelper is a utility class that can be used to quickly support the Dashlane Extension. It takes care of creating the proper data structure of the request and presenting a UIActivityViewController view on the root view controller of the application key window.

Detect the Dashlane app
======================
You may want to detect if your app user has Dashlane installed on their iOS device. Using the following code you'll be able to check if an extension ready version of Dashlane is installed:

```objective-c
if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"dashlane-ext://"]) { 
  // You can attempt to use the Dashlane Extension
}
```

App Name
======================
A request must include a non-empty app name parameter. It is the argument "appName" that needs to be passed to the designated initializer:

```objective-c
- (instancetype)initWithAppName:(NSString *)appName
```

Without a non-empty app name, the extension will return an error.

Sending a request
======================
A request includes the following steps:

1. Starting a new request by calling

```objective-c
- (void)startNewRequest
```

2. Adding at least one request identifier by calling:

```objective-c
- (void)addRequest:(NSString *)requestIdentifier matchingString:(NSString *)stringToMatch
```

Request identifiers are constants defined by Dashlane to recognize requested data types. To learn more, check DashlaneExtensionConstants.

stringToMatch is used to filter what the extension UI is going to present to the user. Pass nil if you don’t need it.

Multiple data types can be requested using the same request by calling the top methods multiple times for each data type.

3. Finally sending the request by calling

```objective-c
- (void)sendRequestWithCompletionBlock:(RequestCompletionBlock)completionBlock
```

The completion block is the callback that’s going to be called once the extension is dismissed.

A completionBlock is defined as:

```objective-c
typedef void (^RequestCompletionBlock)(NSDictionary *returnedItems, NSError *error);
```

Structure of the returned items
======================
When the extension is dismissed, the (RequestCompletionBlock) completion block is called with a dictionary representing the answer from the Dashlane Extension. This dictionary contains, for each requested data type (i.e. requestIdentifier), a dictionary representation of a returned user data item. The keys for the dictionary representations of returned user data items can be found in [DashlaneExtensionConstants](https://raw.githubusercontent.com/Dashlane/Dashlane-iOS-Extension/master/DashlaneExtensionConstants.h).

Example of a returnedItems dictionary:

```objective-c
{
DASHLANE_EXTENSION_REQUEST_ADDRESS      : {DASHLANE_EXTENSION_REQUEST_REPLY_LOGIN_KEY: @“a login”, DASHLANE_EXTENSION_REQUEST_REPLY_PASSWORD_KEY : @“a password"},
DASHLANE_EXTENSION_REQUEST_PHONE_NUMBER : {DASHLANE_EXTENSION_REQUEST_REPLY_PHONE_NUMBER_KEY: @“a phone number"}
}
```

Webview forms
======================
Filling webview forms starts by requesting the data from Dashlane. Then by running a simple Javascript code, you can pass the requested information into to the webview:

```objective-c
NSString *javascript = [NSString stringWithFormat:@"!!function(e,t){var l=document.querySelectorAll('input[type=\"text\"],input[type=\"email\"]'),u=document.querySelectorAll('input[type=\"password\"]'),n=document.querySelectorAll('input[type=\"submit\"],button[type=\"submit\"]');return u&&u.length&&l&&l.length?(l[0].value=e,u[0].value=t,n.length&&n[0].click(),!0):!1}(\"%@\",\"%@\");", myLogin, myPassword];
[webView stringByEvaluatingJavaScriptFromString:javascript];
```

Dashlane-Extension CocoaPod
======================
If you use CocoaPods to manage your third party libraries. You can add " pod 'Dashlane-Extension' " to your Podfile, run pod install from your project directory and you're ready to go.

Contact Us
======================
We hope you’ve found everything you need to get started. If you're interested or have any questions, please email us at ios8@dashlane.com.
