Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  s.name         = "Dashlane-Extension"
  s.version      = "1.0.3"
  s.summary      = "An iOS 8 action extension to provide user data on demande (e.g login to an app)"

  s.description  = <<-DESC
                   iOS 8 has an incredible feature called [App Extensions](https://developer.apple.com/library/ios/documentation/General/Conceptual/ExtensibilityPG/index.html). At Dashlane, we built a powerful and easy-to-implement App Extension for use in your apps. By using the Dashlane App Extension featured in the video above, you will enhance user experience and increase app engagement by eliminating manual data entry in three key areas:

                  1. **Login** – How many times have you opened an app only to close it because you didn’t remember the password? Dashlane users manage over 50 million passwords, so you could reduce the number of lost interactions
                  2. **Checkout** – Are your users putting items in their cart, but not checking out? Let Dashlane assist with checkout by autofilling user information. Dashlane has already facilitated over $1B in transactions.
                  3. **Sign-up** – Need users to sign up to use your app? Dashlane has millions of users ready to use your app with the ease of Dashlane registration (coming soon).

                   DESC

  s.homepage     = "https://github.com/Dashlane/Dashlane-iOS-Extension"

  s.license      = { :type => "GNU GPL v2.0", :file => "LICENSE.md" }

  s.author             = { "Dashlane" => "ios8@dashlane.com" }
  s.social_media_url   = "http://twitter.com/Dashlane"

  s.platform     = :ios, "7.1"

  s.source       = { :git => "https://github.com/Dashlane/Dashlane-iOS-Extension.git", :tag => "1.0.3" }

  s.source_files  = "*.{h,m}"

  s.requires_arc = false

end
