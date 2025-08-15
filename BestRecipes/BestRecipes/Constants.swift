import UIKit

struct Constants {
    static let appName = "BestRecipes"
    
    struct Images {
        static let onboardingStartPage = "onboarding_start_page_image"
        static let onboardingFirstPage = "onboarding_first_page_image" 
        static let onboardingSecondPage = "onboarding_second_page_image"
        static let onboardingLastPage = "onboarding_last_page_image"
        static let homeButtonImageInactive = "navIntactive"
        static let homeButtonImageActive = "navActive"
        static let bookmarkButtonImageInactive = "bookMarkInactive"
        static let bookmarkButtonImageActive = "bookMarkActive"
        static let createButtonImage = "create"
        static let notificationButtonImageInactive = "notificationInactive"
        static let notificationButtonImageActive = "notificationActive"
        static let profileButtonImageInactive = "profileInactive"
        static let profileButtonImageActive = "profileActive"
        static let backgroundBarImage = "backGroundBar"
        static let arrowRightImage = "arrowRight"
        static let starIconImage = "star"
    }
    
    struct Icons {
        static let arrowLeft = "arrowLeft"
        static let arrowRight = "arrowRight"
        static let bookmark = "bookmark"
        static let bookMarkActive = "bookMarkActive"
        static let bookMarkInactive = "bookMarkInactive"
        static let clock = "clock"
        static let dotsHorizontal = "dotsHorizontal"
        static let dotsVertical = "dotsVertical"
        static let edit = "edit"
        static let homeActive = "homeActive"
        static let homeInactive = "homeInactive"
        static let location = "location"
        static let minusBorder = "minusBorder"
        static let notificationActive = "notificationActive"
        static let notificationInactive = "notificationInactive"
        static let play = "play"
        static let plusBorder = "plusBorder"
        static let profile = "profile"
        static let profileActive = "profileActive"
        static let profileInactive = "profileInactive"
        static let recipe = "recipe"
        static let search = "search"
        static let star = "star"
        static let tickCircleInactive = "tickCircleInactive"
        static let tickCircleActive = "tickCircleActive"
        static let xMark = "xMark"
    }
    
    struct NavbarIcons {
        static let backGroundBar = "backGroundBar"
        static let create = "create"
        static let navActive = "navActive"
        static let navIntactive = "navIntactive"

    }
    
    struct Fonts {
        static let poppinsBold = "Poppins-Bold"
        static let poppinsSemiBold = "Poppins-SemiBold"
        static let poppinsRegular = "Poppins-Regular"
        
    }
    
    struct Colors {
        struct Neutral {
            static let neutral100 = UIColor(named: "Neutral 100")
            static let neutral90 = UIColor(named: "Neutral 90")
            static let neutral80 = UIColor(named: "Neutral 80")
            static let neutral70 = UIColor(named: "Neutral 70")
            static let neutral60 = UIColor(named: "Neutral 60")
            static let neutral50 = UIColor(named: "Neutral 50")
            static let neutral40 = UIColor(named: "Neutral 40")
            static let neutral30 = UIColor(named: "Neutral 30")
            static let neutral20 = UIColor(named: "Neutral 20")
            static let neutral10 = UIColor(named: "Neutral 10")
            static let white0 = UIColor(named: "White 0")
        }
        
        struct Primary {
            static let primary100 = UIColor(named: "Primary 100")
            static let primary90 = UIColor(named: "Primary 90")
            static let primary80 = UIColor(named: "Primary 80")
            static let primary70 = UIColor(named: "Primary 70")
            static let primary60 = UIColor(named: "Primary 60")
            static let primary50 = UIColor(named: "Primary 50")
            static let primary40 = UIColor(named: "Primary 40")
            static let primary30 = UIColor(named: "Primary 30")
            static let primary20 = UIColor(named: "Primary 20")
            static let primary10 = UIColor(named: "Primary 10")
            static let primary0 = UIColor(named: "Primary 0")
        }
        
        struct Secondary {
            static let secondary100 = UIColor(named: "Secondary 100")
            static let secondary90 = UIColor(named: "Secondary 90")
            static let secondary80 = UIColor(named: "Secondary 80")
            static let secondary70 = UIColor(named: "Secondary 70")
            static let secondary60 = UIColor(named: "Secondary 60")
            static let secondary50 = UIColor(named: "Secondary 50")
            static let secondary40 = UIColor(named: "Secondary 40")
            static let secondary30 = UIColor(named: "Secondary 30")
            static let secondary20 = UIColor(named: "Secondary 20")
            static let secondary10 = UIColor(named: "Secondary 10")
            static let secondary0 = UIColor(named: "Secondary 0")
        }
        
        struct Rating {
            static let rating100 = UIColor(named: "Rating 100")
        }
        
        struct Error {
            static let error100 = UIColor(named: "Error 100")
            static let error10 = UIColor(named: "Error 10")
        }
        
        struct Green {
            static let success100 = UIColor(named: "Success 100")
            static let success10 = UIColor(named: "Success 10")
        }
    }
    
    static func attributedString(string text: String, font: UIFont, color: UIColor) -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: color,
            .paragraphStyle: paragraphStyle
        ]
        return NSAttributedString(string: text, attributes: attributes)
    }
    
    struct UDConstants {
        static let currentCategory = "currentCategory"
        static let savedRecentRecipes = "savedRecentRecipes"
        static let savedFavoriteRecipes = "savedFavoriteRecipes"
    }
}
