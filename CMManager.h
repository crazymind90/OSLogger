// By @CrazyMind90

#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
#pragma clang diagnostic ignored "-Wnullability-completeness"
#pragma GCC diagnostic ignored "-Wunused-variable"
#pragma GCC diagnostic ignored "-Wprotocol"
#pragma GCC diagnostic ignored "-Wmacro-redefined"
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
#pragma GCC diagnostic ignored "-Wincomplete-implementation"
#pragma GCC diagnostic ignored "-Wunguarded-availability-new"

#import <UIKit/UIKit.h>
#include <sys/types.h>
#include <sys/sysctl.h>
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
#include <spawn.h>
#include <CommonCrypto/CommonDigest.h>
#include <CoreFoundation/CoreFoundation.h>
#include <stdint.h>
#include <stdio.h>
// #import "NSStrings.h"


#define rgbValue
#define UIColorFromHEX(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


#define SCREEN_WIDTH UIScreen.mainScreen.bounds.size.width

#define SCREEN_HEIGHT UIScreen.mainScreen.bounds.size.height





@interface CMManager : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, strong) NSString *ImageFullPath;

+(UIMenu *) InitMenuOnButton:(UIButton *)Button MenuTitles:(NSArray *)MenuTitles ActionsTitles:(NSArray *)ActionsTitles ImagesNames:(NSArray *)ImagesNames Target:(id)Target Action:(SEL)Action handler:(void(^_Nullable)(NSString *ButtonTitle))handler;

+(NSString *) RunCMDWithLog:(NSString *)RunCMDWithLog;

+(void) InitAlertWithTitle:(NSString *_Nullable)Title Message:(NSString *_Nullable)Message Buttons:(NSArray *_Nullable)Buttons CancelButtonTitle:(NSString *_Nullable)CancelButtonTitle AlertStyle:(UIAlertControllerStyle)AlertStyle handler:(void(^_Nullable)(NSString * _Nullable ButtonTitle, NSUInteger index))handler;

+(NSArray *_Nullable) InitLabelImage:(UIImage *_Nullable)image InView:(UIView *_Nullable)View LabelName:(NSString *)Name;

+(NSArray *) InitButtonLabelWithName:(NSString *)Name InView:(UIView *)View Target:(id)Target Action:(SEL)Action;

+(NSArray *_Nullable) InitButtonImage:(UIImage *_Nullable)image InView:(UIView *_Nullable)View Target:(id)Target Action:(SEL)Action;

+(UISegmentedControl *) InitSegamentWithSections:(NSArray *)Sections Target:(id)Target Action:(SEL)Action InView:(UIView *)View;

+(void) AlertWithTitle:(NSString *)Title Message:(NSString *)Message ButtonTitle:(NSString *)ButtonTitle;

+(void) ForLoop:(NSMutableArray *)Array Handler:(void (^_Nullable) (NSUInteger Counter) )handler;

+(void) ActivateThisCodeForTimes:(NSUInteger)Times handler:(void (^_Nullable) (void) )handler;

+(void) ActiveThisCodeOneTime:(void (^_Nullable) (void)  ) handler;

+(void) SendGETtoPHP:(NSString *_Nullable)SendGETtoPHP handler:(void(^_Nullable)(NSString *Res))handler;

+(NSMutableAttributedString *) OriginalText:(NSString *)OriginalText ChangeColorOfText:(NSArray *)Text ToColor:(NSArray *)Color;

+(id) GeneratorTwos:(NSUInteger)Num;

+(void) RemoveALLItemsInDirectory:(NSString *)Dir;

+(NSString *) RemoveAllNumbersFromString:(NSString *)String;

+(NSString *) RemoveAllLettersFromString:(NSString *)String;

+(NSDictionary *) GetJSONFromURL:(NSString *)URL;

+(UIImage *_Nullable) GenerateThumbImageFromPath:(NSString *_Nullable)Path;

+(UIView *) InitNewViewInView:(UIView *)InView Frame:(CGRect)Frame;

+(NSString *) SelfBundle;

+(AVPlayer *) PlayVideoWithoutCotrollersInView:(UIView *)InView Frame:(CGRect)Frame CornerRadius:(float)CornerRadius VideoPath:(NSString *)VideoPath addObserver:(UIViewController *)Observer Action:(SEL)Action handler:(void(^_Nullable)(id _Nullable PrintThisNote))handler;

+(BOOL) DownloadLink:(NSString *_Nullable)DownloadLink ToPath:(NSString *_Nullable)ToPath;

+(void) UploadFile:(NSString *_Nullable)UploadFile PHPLink:(NSString *_Nullable)PHPLink PHPNameValue:(NSString *_Nullable)PHPNameValue;

+(BOOL) CreateFileAtPath:(NSString *_Nullable)CreateDirectoryAtPath;

+(BOOL) CreateDirectoryAtPath:(NSString *_Nullable)CreateDirectoryAtPath;

+(BOOL) MoveItemAtPath:(NSString *_Nullable)CopyItemAtPath ToPath:(NSString *_Nullable)ToPath;

+(BOOL) CopyItemAtPath:(NSString *_Nullable)CopyItemAtPath ToPath:(NSString *_Nullable)ToPath;

+(BOOL) RemoveItemAtPath:(NSString *_Nullable)RemoveItemAtPath;

+(BOOL) FileExistsAtPath:(NSString *_Nullable)FileExistsAtPath;

+(BOOL) CreatePlistAtPath:(NSString *_Nullable)CreatePlistAtPath NameWithoutExtension:(NSString *_Nullable)NameWithoutExtension;

+(id _Nullable) Generator:(NSUInteger)Num;

+(NSString *_Nullable) PlistPath:(NSString *_Nullable)PlistPath ObjectForKey:(NSString *_Nullable)ObjectForKey;

+(BOOL) PlistPath:(NSString *_Nullable)PlistPath SetValue:(id _Nullable )SetValue ForKey:(id _Nullable)ForKey;

+(void) SendGETtoPHP:(NSString *_Nullable)SendGETtoPHP;

+(id _Nullable ) DataPathWithFileOrDir:(NSString *_Nullable)DataPathWithFileOrDir;

+(id _Nullable ) BundlePathWithFileOrDir:(NSString *_Nullable)BundlePathWithFileOrDir;

+(BOOL) PlistPath:(NSString *_Nullable)PlistPath RemoveObjectForKey:(id _Nullable )RemoveObjectForKey;

+(NSArray *_Nullable) ContentOfDir:(NSString *_Nullable)ContentOfDir;

+(NSString *_Nullable) SizeOfFolder:(NSString *_Nullable)sizeOfFolder;

+(NSString *_Nullable)SizeOfFile:(NSString *_Nullable)SizeOfFile;

+(NSString *_Nullable) GetUDID;

+(UIButton *_Nullable) InitButtonWithName:(NSString *_Nullable)BuName Frame:(CGRect)frame InView:(UIView *_Nullable)View Target:(id _Nullable )Target Action:(SEL _Nullable )Action;

+(UIButton *_Nullable) InitButtonWithName:(NSString *_Nullable)BuName LeftRight:(float)LeftRight UpDown:(float)UpDown Width:(float)Width Height:(float)Height InView:(UIView *_Nullable)View Target:(id _Nullable)Target Action:(SEL _Nullable )Action;

+(UIView *_Nullable) InitViewWithBGColor:(UIColor *_Nullable)BGColor Frame:(CGRect)Frame Blur:(BOOL)Blur BackgroundImage:(UIImage *_Nullable)BackgroundImage InView:(UIView *_Nullable)InView;

+(UIView *_Nullable) InitViewWithBGColor:(UIColor *_Nullable)BGColor Frame:(CGRect)Frame BackgroundImage:(UIImage *_Nullable)BackgroundImage  InView:(UIView *_Nullable)InView;

+(UILabel *_Nullable) InitLabelWithName:(NSString *_Nullable)Name TextAlignment:(NSTextAlignment)TextAlignment LeftRight:(float)LeftRight UpDown:(float)UpDown Width:(float)Width Height:(float)Height InView:(UIView *_Nullable)InView;

+(UILabel *_Nullable) InitLabelWithName:(NSString *_Nullable)Name Frame:(CGRect)frame InView:(UIView *_Nullable)InView;

+(UILabel *_Nullable) InitLabelInsideViewWithName:(NSString *_Nullable)Name TextAlignment:(NSTextAlignment)TextAlignment TextColor:(UIColor *_Nullable)TextColor LeftRight:(float)LeftRight UpDown:(float)UpDown Width:(float)Width Height:(float)Height InView:(UIView *_Nullable)InView;

+(UIButton *_Nullable) InitButtonInsideViewWithName:(NSString *_Nullable)BuName LeftRight:(float)LeftRight UpDown:(float)UpDown Width:(float)Width Height:(float)Height InView:(UIView *_Nullable)View Target:(id _Nullable)Target Action:(SEL _Nullable )Action;


//+(void) InitAlertWithTitle:(NSString *_Nullable)Title Message:(NSString *_Nullable)Message Buttons:(NSArray *_Nullable)Buttons CancelButtonTitle:(NSString *_Nullable)CancelButtonTitle AlertStyle:(UIAlertControllerStyle)AlertStyle handler:(void(^_Nullable)(NSString * _Nullable ButtonTitle))handler;


+(UIImage *)RoundedImage:(UIImage *) image radius:(float)radius;


+(void) InitAlertWithTitle:(NSString *_Nullable)Title TitleColor:(UIColor *_Nullable)TitleColor TitleImage:(UIImage *)TitleImage TitleImageFrame:(CGRect)TitleImageFrame Message:(NSString *_Nullable)Message MessageColor:(UIColor *_Nullable)MessageColor Buttons:(NSArray *_Nullable)Buttons CancelButtonTitle:(NSString *_Nullable)CancelButtonTitle ButtonsColor:(UIColor *_Nullable)ButtonsColor ButtonsImage:(UIImage *_Nullable)ButtonsImage BackgroundColor:(UIColor *_Nullable)BackgroundColor AlertStyle:(UIAlertControllerStyle)AlertStyle handler:(void(^_Nullable)(NSString * _Nullable ButtonTitle))handler;



+(void) InitAlertInKeyWindowWithTitle:(NSString *_Nullable)Title Message:(NSString *_Nullable)Message Buttons:(NSArray *_Nullable)Buttons CancelButtonTitle:(NSString *_Nullable)CancelButtonTitle AlertStyle:(UIAlertControllerStyle)AlertStyle handler:(void(^_Nullable)(NSString * _Nullable ButtonTitle))handler;


+(void) InitTextFieldAlertInKeyWindowWithTitle:(NSString *_Nullable)Title Message:(NSString *_Nullable)Message Buttons:(NSArray *_Nullable)Buttons CancelButtonTitle:(NSString *_Nullable)CancelButtonTitle handler:(void(^_Nullable)(NSString * _Nullable ButtonTitle, NSString * _Nullable Text))handler;


+(UIImageView *_Nullable) InitImage:(UIImage *_Nullable)image LeftRight:(float)LeftRight UpDown:(float)UpDown Width:(float)Width Height:(float)Height InView:(UIView *_Nullable)InView;

+(UIImageView *_Nullable) InitImage:(UIImage *_Nullable)image Frame:(CGRect)Frame InView:(UIView *_Nullable)InView;


+(UIImage *_Nullable) BlureImage:(UIImage *_Nullable)image BlureLevel:(float)BlureLevel InView:(UIView *_Nullable)InView;


+(UISwitch *_Nonnull) InitSwitchInsideViewWithAction:(SEL _Nullable )Action LeftRight:(float)LeftRight UpDown:(float)UpDown Width:(float)Width Height:(float)Height InView:(UIView *_Nullable)InView Target:(id _Nullable )Target;


+(UIVisualEffectView *) BlurView:(UIView *_Nullable)View;


+(NSString *_Nonnull) CheckDeviceType;


+(BOOL) isIPhone_XS_MAX_XR_Screen;


+(BOOL) isIPhone_X_XS_Screen;


+(BOOL) isIPadScreen_12_9_inch;


+(BOOL) isIPadScreen_Small;


+(BOOL) isIPhone_7p_8p_Screen;


+(BOOL) isIPhone_7_8_Screen;


+(BOOL) isIPhone5Screen;



+(void)ViewToBeAnimated:(UIView *_Nullable)views delegate:(id _Nullable)delegate Duration:(float)Duration StartAnimationFrom:(CATransitionSubtype _Nullable)StartAnimationFrom;


+(UIScrollView *_Nullable) InitScrollViewWithBGColor:(UIColor *_Nullable)BGColor LeftRight:(float)LeftRight UpDown:(float)UpDown Width:(float)Width Height:(float)Height Delegate:(id _Nullable )Delegate InView:(UIView *_Nullable)InView;


+(UIScrollView *_Nullable) InitScrollViewWithFrame:(CGRect)Frame BGColor:(UIColor *_Nullable)BGColor Delegate:(id _Nullable )Delegate InView:(UIView *_Nullable)InView;


+(BOOL) isDirectory:(NSString *_Nullable)Path;


+(UITextView *_Nullable) InitTextViewWithFrame:(CGRect)Frame BackgroundColor:(UIColor *_Nullable)BGColor TextColor:(UIColor *_Nullable)TextColor InView:(UIView *_Nullable)InView;


+(UITextView *_Nullable) InitTextViewWithBGColor:(UIColor *_Nullable)BGColor TextColor:(UIColor *_Nullable)TextColor LeftRight:(float)LeftRight UpDown:(float)UpDown Width:(float)Width Height:(float)Height InView:(UIView *_Nullable)InView;




+(void) InitTextFieldAlertWithTitle:(NSString *)Title Message:(NSString *)Message Buttons:(NSArray *)Buttons CancelButtonTitle:(NSString *)CancelButtonTitle handler:(void(^_Nullable)(NSString *ButtonTitle, NSString *Text, UITextField *TextField))handler;


+(void) InitTextFieldAlertWithTitle:(NSString *_Nullable)Title TitleColor:(UIColor *_Nullable)TitleColor Message:(NSString *_Nullable)Message MessageColor:(UIColor *_Nullable)MessageColor Buttons:(NSArray *_Nullable)Buttons ButtonsColor:(UIColor *_Nullable)ButtonsColor ButtonsImage:(UIImage *_Nullable)ButtonsImage BackgroundColor:(UIColor *_Nullable)BackgroundColor TextFieldBGColor:(UIColor *_Nullable)TextFieldBGColor TextFieldTextColor:(UIColor *_Nullable)TextFieldTextColor CancelButtonTitle:(NSString *_Nullable)CancelButtonTitle handler:(void(^_Nullable)(NSString * _Nullable ButtonTitle, NSString * _Nullable Text))handler;


+(CGRect) AboveTabBarDownNavigationBar;


+(CGRect) AboveTabBarDownNavigationController;

+(CGRect) InMiddleOfView:(UIView *_Nullable)View;


+(NSString *)TakeStringFromLeft:(NSString *)TakeStringFromLeft HowMuch:(NSUInteger)HowMuch;

+(UINavigationController *_Nullable) InitNavigationControllerWithTitle:(NSString *_Nullable)Title TitleColor:(UIColor *_Nullable)TitleColor RightButtonTitle:(NSString *_Nullable)RightButtonTitle RightButtonAction:(SEL _Nullable )RightButtonAction LeftButtonImage:(NSString *_Nullable)LeftButtonImage LeftButtonAction:(SEL _Nullable)LeftButtonAction ButtonsColor:(UIColor *_Nullable)ButtonsColor BackgroundColor:(UIColor *_Nullable)BackgroundColor Target:(id _Nullable)Target InView:(UIView *_Nullable)InView;

+(UINavigationController *_Nullable) InitNavigationControllerWithTitle:(NSString *_Nullable)Title TitleColor:(UIColor *_Nullable)TitleColor RightButtonTitle:(NSString *_Nullable)RightButtonTitle RightButtonAction:(SEL _Nullable )RightButtonAction LeftButtonImage:(NSString *_Nullable)LeftButtonImage LeftButtonAction:(SEL _Nullable)LeftButtonAction EditButtonTitle:(NSString *_Nullable)EditButtonTitle EditButtonAction:(SEL)EditButtonAction ButtonsColor:(UIColor *_Nullable)ButtonsColor BackgroundColor:(UIColor *_Nullable)BackgroundColor Target:(id _Nullable)Target InView:(UIView *_Nullable)InView;


+(UITextField *_Nullable) InitTextFieldWithFrame:(CGRect)Frame TextColor:(UIColor *_Nullable)TextColor BackgroundColor:(UIColor *_Nullable)BackgroundColor InView:(UIView *_Nullable)InView;



+(void) ResizeLayoutView:(UIView *_Nullable)View InView:(UIView *_Nullable)InView AnchorDirection:(id _Nullable)AnchorDirection Constant:(float)Constant;


+(void) ResizeLayoutView:(UIView *_Nullable)View InView:(UIView *_Nullable)InView LeftAnchor:(id _Nullable)LeftAnchor LeftAnchorConstant:(float)LeftAnchorConstant RightAnchor:(id _Nullable)RightAnchor RightAnchorConstant:(float)RightAnchorConstant TopAnchor:(id _Nullable)TopAnchor TopAnchorConstant:(float)TopAnchorConstant BottomAnchor:(id _Nullable)BottomAnchor BottomAnchorConstant:(float)BottomAnchorConstant;


+(UIActivityViewController *_Nullable) ShareItemAtPath:(NSString *_Nullable)Path InViewController:(UIViewController *_Nullable)InViewController;



+(void) ActivateTheFollowingCodeAfter:(float)Sleep handler:(void(^_Nullable)(void))handler;


+(void) StartDispatch:(void(^_Nullable)(void))StartDispatch EndDispath:(void(^_Nullable)(void))EndDispath;

+(void) StartDispatch:(void(^_Nullable)(void))StartDispatch;

+(void) AnimatedDismissView:(UIView *_Nullable)View Duration:(float)Duration Y:(float)DirectionY X:(float)DirectionX handler:(void(^_Nullable)(void))handler;



+(void) Start_Main_Thread_Dispatch:(void(^_Nullable)(void))StartDispatch;

+(UIPasteboard *_Nullable) CopyToClipboard:(id _Nullable)Copy;


+(NSString *_Nullable) PasteFromClipboard;


+(UIWindow *_Nullable) NewWindowWithView:(UIView *_Nullable)View;


+(void) DismissView:(id _Nullable)View;


+(UIMenuController *_Nullable) InitMenuItemWithTitle:(NSString *_Nullable)Title InView:(UIView *_Nullable)InView Action:(SEL)Action;


+(NSString *_Nullable) ShortenURL:(NSString *_Nullable)URL;



+(void) RenameItemAtPath:(NSString *_Nullable)Path NewName:(NSString *_Nullable)NewName;




+(AVPlayer *) PlayVideoAtPath:(NSURL *_Nullable)Path InViewController:(id _Nullable)ViewController;


+(UISwitch *_Nonnull) InitSwitchAction:(SEL _Nullable )Action Frame:(CGRect)Frame InView:(UIView *_Nullable)InView Target:(id _Nullable )Target;


+(void) PlayAudioAtPath:(NSString *_Nullable)Path;


+(UIWindow *) InitWindowWithFrame:(CGRect)Frame;


+(void) PlayAudioFromURL:(NSString *_Nullable)URL;



+(CGRect) AboveTabBar;




+(UIToolbar *) AddButtonOnKeyboardWithStyle:(UIBarButtonSystemItem)Style ShowOnTextField:(UITextField *)ShowOnTextField Target:(id)Target Action:(SEL)Action;




+(UIViewController *) NewViewControllerInView:(UIView *)InView;


+(BOOL) isDataPath:(NSString *)Path;



+(UITapGestureRecognizer *) InitTapGestureRecognizerInView:(UIView *)InView NumberOfTapsRequired:(NSUInteger)TapsRequired NumberOfTouchesRequired:(NSUInteger)TouchesRequired Target:(id)Target Actions:(SEL)Action;


+(UILongPressGestureRecognizer *) InitLongPressGestureRecognizerInView:(UIView *)InView PressDuration:(float)PressDuration NumberOfTouchesRequired:(NSUInteger)TouchesRequired Target:(id)Target Actions:(SEL)Action;


+(UISwipeGestureRecognizer *) InitSwipeGestureRecognizerInView:(UIView *)InView setDirection:(UISwipeGestureRecognizerDirection)Direction NumberOfTouchesRequired:(NSUInteger)TouchesRequired Target:(id)Target Actions:(SEL)Action;


+(NSString *) GetDataPathForBundleID:(NSString *)Bundle;


+(NSString *) GetBundlePathForBundleID:(NSString *)Bundle;


+(void) MoveableViewInView:(UIView *)InView Sender:(UIPanGestureRecognizer *)Sender Delegate:(id)Delegate;


+(UIPanGestureRecognizer *) InitPanGestureRecognizerOnObject:(id)Object Target:(id)Target Action:(SEL)Action;


+(void) AnimatedDismissView:(UIView *_Nullable)View StartAnimationFrom:(CATransitionSubtype _Nullable)StartAnimationFrom Duration:(float)Duration handler:(void(^_Nullable)(void))handler;



+(UIView *_Nullable) InitViewWithFrame:(CGRect)Frame InView:(UIView *_Nullable)InView;

 @end



static UIViewController *_topMostController(UIViewController *cont) {
    UIViewController *topController = cont;
    while (topController.presentedViewController) {
        topController = topController.presentedViewController;
    }
    if ([topController isKindOfClass:[UINavigationController class]]) {
        UIViewController *visible = ((UINavigationController *)topController).visibleViewController;
        if (visible) {
            topController = visible;
        }
    }
    return (topController != cont ? topController : nil);
}
static UIViewController *topMostController() {
    UIViewController *topController = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *next = nil;
    while ((next = _topMostController(topController)) != nil) {
        topController = next;
    }
    return topController;
}


  