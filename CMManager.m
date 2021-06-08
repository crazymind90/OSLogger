// By @CrazyMind90

#pragma GCC diagnostic ignored "-Wunused-variable"
#pragma GCC diagnostic ignored "-Wprotocol"
#pragma GCC diagnostic ignored "-Wmacro-redefined"
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
#pragma GCC diagnostic ignored "-Wincomplete-implementation"

#import "CMManager.h"



@implementation CMManager


+(UIMenu *) InitMenuOnButton:(UIButton *)Button MenuTitles:(NSArray *)MenuTitles ActionsTitles:(NSArray *)ActionsTitles ImagesNames:(NSArray *)ImagesNames Target:(id)Target Action:(SEL)Action handler:(void(^_Nullable)(NSString *ButtonTitle))handler {
        
    UIMenu *Menu = [UIMenu alloc];
    NSMutableArray *Obj = [[NSMutableArray alloc] init];
    
    for (CFIndex iCounter = 0; iCounter < ActionsTitles.count; iCounter ++) {

    for (NSString *EachImageName in ImagesNames) {
        
    UIAction *Action0 = [UIAction actionWithTitle:[ActionsTitles objectAtIndex:iCounter] image:[UIImage imageNamed:EachImageName] identifier:[ActionsTitles objectAtIndex:iCounter] handler:^(__kindof UIAction * _Nonnull action) {

           handler(action.title);
    }];
        
    [Obj addObject:Action0];
        
    }

    }
    
    for  (NSString *EachMenuTitle in MenuTitles) {
        
    Menu = [UIMenu menuWithTitle:EachMenuTitle children:[NSArray arrayWithArray:Obj]];
    
    Button.menu = Menu;
    Button.showsMenuAsPrimaryAction = YES;
    [Button addTarget:Target action:Action forControlEvents:UIControlEventAllEvents];

    return Menu;
    }
    
    return Menu;
}
 

+(void) InitAlertWithTitle:(NSString *_Nullable)Title Message:(NSString *_Nullable)Message Buttons:(NSArray *_Nullable)Buttons CancelButtonTitle:(NSString *_Nullable)CancelButtonTitle AlertStyle:(UIAlertControllerStyle)AlertStyle handler:(void(^_Nullable)(NSString * _Nullable ButtonTitle, NSUInteger index))handler {



  UIAlertController *alert = [UIAlertController alertControllerWithTitle:Title message:Message preferredStyle:AlertStyle];

    NSUInteger Counter  = 0;
      for (NSString *EachButton in Buttons) {

     UIAlertAction *action = [UIAlertAction actionWithTitle:EachButton style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {

         handler(action.title,Counter);



                }];


     [alert addAction:action];
     Counter ++;

 }


 if (!(CancelButtonTitle == NULL)) {

 UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:CancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {


 }];

 //CancelColor
  [cancelAction setValue:UIColor.redColor forKey:@"titleTextColor"];
  [alert addAction:cancelAction];

 }

 [topMostController() presentViewController:alert animated:true completion:nil];


}


+(void) ActiveThisCodeOneTime:(void (^_Nullable) (void)  ) handler {


    static BOOL DidActive = NO;

    if (!DidActive) {

        handler();

         DidActive = YES;

    }

}


+(void) ActivateThisCodeForTimes:(NSUInteger)Times handler:(void (^_Nullable) (void) )handler {

    Times -= 1;
    [CMManager ActiveThisCodeOneTime:^{



    for (NSUInteger Counter = 0; Counter <= Times; Counter ++) {

        handler();

    }


    }];
}


+(void) ForLoop:(NSMutableArray *)Array Handler:(void (^_Nullable) (NSUInteger Counter) )handler {



    for (NSUInteger Co = 0; Co < Array.count; Co ++) {

        handler(Co);


    }

}


+(void) AlertWithTitle:(NSString *)Title Message:(NSString *)Message ButtonTitle:(NSString *)ButtonTitle {

    UIAlertController *alert = [UIAlertController alertControllerWithTitle:Title message:Message preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction *action = [UIAlertAction actionWithTitle:ButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {

     }];

    [alert addAction:action];

    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:true completion:nil];


}

+(NSMutableAttributedString *) OriginalText:(NSString *)OriginalText ChangeColorOfText:(NSArray *)Text ToColor:(NSArray *)Color {


    NSMutableAttributedString *mutableAttributedString;

    NSString *text = OriginalText;

    if (OriginalText != nil) {

    mutableAttributedString = [[NSMutableAttributedString alloc] initWithString:OriginalText];

    for (NSUInteger Counter = 0; Counter < Color.count; Counter ++) {

    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:[NSString stringWithFormat:@"(%@)",[Text objectAtIndex:Counter]] options:kNilOptions error:nil];

    NSRange range = NSMakeRange(0 ,text.length);

    [regex enumerateMatchesInString:text options:kNilOptions range:range usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {

        NSRange subStringRange = [result rangeAtIndex:0];

        [mutableAttributedString addAttribute:NSForegroundColorAttributeName value:[Color objectAtIndex:Counter] range:subStringRange];

    }];


    }
}


    return mutableAttributedString;
}


+(NSString *) GetDataPathForBundleID:(NSString *)Bundle {

        NSString *BundleID;


        NSString *Applications = @"/var/mobile/Containers/Data/Application";
        NSArray *Content = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:Applications error:nil];

        for (NSString *EachApp in Content) {

        NSString *Plist = [NSString stringWithFormat:@"%@/%@/.com.apple.mobile_container_manager.metadata.plist",Applications,EachApp];

        NSMutableDictionary *MutDic = [[NSMutableDictionary alloc] initWithContentsOfFile:Plist];

        NSString *Object = [MutDic objectForKey:@"MCMMetadataIdentifier"];

        if ([Object isEqual:Bundle]) {

        BundleID = [NSString stringWithFormat:@"%@/%@",Applications,EachApp];

        }

    }

    return BundleID;
}





+(NSString *) GetBundlePathForBundleID:(NSString *)Bundle {

        NSString *AppPath;

        NSString *Applications = @"/var/containers/Bundle/Application";
        NSArray *Content = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:Applications error:nil];

        for (NSString *EachApp in Content) {

        NSString *Plist = [NSString stringWithFormat:@"%@/%@/.com.apple.mobile_container_manager.metadata.plist",Applications,EachApp];

        NSMutableDictionary *MutDic = [[NSMutableDictionary alloc] initWithContentsOfFile:Plist];

        NSString *Object = [MutDic objectForKey:@"MCMMetadataIdentifier"];

        if ([Object isEqual:Bundle]) {

        NSString *BundleID = [NSString stringWithFormat:@"%@/%@",Applications,EachApp];



        for (NSString *Dot_App in [CMManager ContentOfDir:BundleID]) {

            NSString *InfoPath = [NSString stringWithFormat:@"%@/%@/Info.plist",BundleID,Dot_App];

            NSString *Bundle = [CMManager PlistPath:InfoPath ObjectForKey:@"CFBundleIdentifier"];

            if ([Bundle isEqual:Bundle])
                AppPath = [InfoPath stringByDeletingLastPathComponent];
        }


        }

    }

    return AppPath;
}





AVPlayer *Player;



+(UIPanGestureRecognizer *) InitPanGestureRecognizerOnObject:(id)Object Target:(id)Target Action:(SEL)Action {

    UIPanGestureRecognizer *Pan = [[UIPanGestureRecognizer alloc] initWithTarget:Target action:Action];

    [Object addGestureRecognizer:Pan];

    return Pan;
}


+(void) MoveableViewInView:(UIView *)InView Sender:(UIPanGestureRecognizer *)Sender Delegate:(id)Delegate {

     [InView bringSubviewToFront:Sender.view];
    CGPoint translatedPoint = [Sender translationInView:Sender.view.superview];

    CGFloat firstX = 0;
    CGFloat firstY = 0;
    if (Sender.state == UIGestureRecognizerStateBegan) {
        firstX = Sender.view.center.x;
        firstY = Sender.view.center.y;
    }


    translatedPoint = CGPointMake(Sender.view.center.x+translatedPoint.x, Sender.view.center.y+translatedPoint.y);

    [Sender.view setCenter:translatedPoint];
    [Sender setTranslation:CGPointZero inView:Sender.view];

    if (Sender.state == UIGestureRecognizerStateEnded) {
        CGFloat velocityX = (0.2*[Sender velocityInView:InView].x);
        CGFloat velocityY = (0.2*[Sender velocityInView:InView].y);

        CGFloat finalX = translatedPoint.x + velocityX;
        CGFloat finalY = translatedPoint.y + velocityY;// translatedPoint.y + (.35*[(UIPanGestureRecognizer*)sender velocityInView:self.view].y);

        if (finalX < 0) {
            finalX = 0;
        } else if (finalX > InView.frame.size.width) {
            finalX = InView.frame.size.width;
        }

        if (finalY < 50) { // to avoid status bar
            finalY = 50;
        } else if (finalY > InView.frame.size.height) {
            finalY = InView.frame.size.height;
        }

        CGFloat animationDuration = (ABS(velocityX)*.0002)+.2;

        //NSLog(@"the duration is: %f", animationDuration);

        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:animationDuration];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        [UIView setAnimationDelegate:self];
//        [UIView setAnimationDidStopSelector:@selector(animationDidFinish)];
        [[Sender view] setCenter:CGPointMake(finalX, finalY)];
        [UIView commitAnimations];
    }

}

+(UIImage *_Nullable) GenerateThumbImageFromPath:(NSString *_Nullable)Path {

    NSURL *url = [NSURL fileURLWithPath:Path];

    AVAsset *asset = [AVAsset assetWithURL:url];
    AVAssetImageGenerator *imageGenerator = [[AVAssetImageGenerator alloc]initWithAsset:asset];
    imageGenerator.appliesPreferredTrackTransform = YES;
    CMTime time = [asset duration];
    time.value = 1000;
    CGImageRef imageRef = [imageGenerator copyCGImageAtTime:time actualTime:NULL error:NULL];
    UIImage *thumbnail = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);

    return thumbnail;
}


+(UISwipeGestureRecognizer *) InitSwipeGestureRecognizerInView:(UIView *)InView setDirection:(UISwipeGestureRecognizerDirection)Direction NumberOfTouchesRequired:(NSUInteger)TouchesRequired Target:(id)Target Actions:(SEL)Action {

    UISwipeGestureRecognizer *Swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:Target action:Action];

    [Swipe setDirection:Direction];

    [InView addGestureRecognizer:Swipe];
    [Swipe setNumberOfTouchesRequired:1];


    return Swipe;



//    -(void) SwipGes:(UISwipeGestureRecognizer *)Sender {
//
//    if (Sender.state == UIGestureRecognizerStateEnded)
//        //NSLog(@"UIGestureRecognizerStateEnded");
//}


}


+(UILongPressGestureRecognizer *) InitLongPressGestureRecognizerInView:(UIView *)InView PressDuration:(float)PressDuration NumberOfTouchesRequired:(NSUInteger)TouchesRequired Target:(id)Target Actions:(SEL)Action {

    UILongPressGestureRecognizer *LongPress = [[UILongPressGestureRecognizer alloc] initWithTarget:Target action:Action];

    LongPress.numberOfTouchesRequired = TouchesRequired;
    LongPress.minimumPressDuration = PressDuration;
    [InView addGestureRecognizer:LongPress];


    return LongPress;

}


+(UITapGestureRecognizer *) InitTapGestureRecognizerInView:(UIView *)InView NumberOfTapsRequired:(NSUInteger)TapsRequired NumberOfTouchesRequired:(NSUInteger)TouchesRequired Target:(id)Target Actions:(SEL)Action {

    UITapGestureRecognizer *Tap = [[UITapGestureRecognizer alloc] initWithTarget:Target action:Action];

    Tap.numberOfTapsRequired = TapsRequired;
    Tap.numberOfTouchesRequired = TouchesRequired;

    Tap.delegate = Target;

    [InView addGestureRecognizer:Tap];


    return Tap;

}



+(BOOL) isDataPath:(NSString *)Path {

    BOOL isData = NO;


    BOOL Documents = [CMManager FileExistsAtPath:[NSString stringWithFormat:@"%@Documents",Path]];
    BOOL Library = [CMManager FileExistsAtPath:[NSString stringWithFormat:@"%@Library",Path]];


    if (Documents && Library)
        isData = YES;


    return isData;

}

+(void) AnimatedDismissView:(UIView *_Nullable)View StartAnimationFrom:(CATransitionSubtype _Nullable)StartAnimationFrom Duration:(float)Duration handler:(void(^_Nullable)(void))handler {

    CATransition *animation = [CATransition animation];
    animation.type = kCATransitionPush;
    animation.subtype = StartAnimationFrom;
    animation.duration = Duration;
    [View.layer addAnimation:animation forKey:nil];

    View.hidden = YES;


    [CMManager ActivateTheFollowingCodeAfter:Duration handler:^{

    [View removeFromSuperview];
    handler();



    }];

}


UIWindow *WindowSeconds;
UIWindow *Window;
UIView *NView;
+(UIWindow *) InitWindowWithFrame:(CGRect)Frame {


    Window = [[UIWindow alloc] initWithFrame:Frame];
    WindowSeconds = Window;

    NView = [[UIView alloc] init];

    NView.frame = Frame;


    [Window makeKeyAndVisible];
    [Window addSubview:NView];


    return Window;
}

+(void) Start_Main_Thread_Dispatch:(void(^_Nullable)(void))StartDispatch {

    dispatch_async(dispatch_get_main_queue(), ^{

        StartDispatch();
    });

}

+(UIViewController *) NewViewControllerInView:(UIView *)InView {

    UIViewController *ViewController = [[UIViewController alloc] init];

    ViewController.view = InView;

    return ViewController;
}

+(UIView *) InitNewViewInView:(UIView *)InView Frame:(CGRect)Frame {

    UIView *View = [[UIView alloc] initWithFrame:Frame];

    [InView addSubview:View];

    return View;
}

+(AVPlayer *) PlayVideoWithoutCotrollersInView:(UIView *)InView Frame:(CGRect)Frame CornerRadius:(float)CornerRadius VideoPath:(NSString *)VideoPath addObserver:(UIViewController *)Observer Action:(SEL)Action handler:(void(^_Nullable)(id _Nullable PrintThisNote))handler {


    NSURL *VideoPathURL = [NSURL fileURLWithPath:VideoPath];
    Player = [AVPlayer playerWithURL:VideoPathURL];
    Player.actionAtItemEnd = AVPlayerActionAtItemEndNone;

    AVPlayerLayer *VideoLayer = [AVPlayerLayer playerLayerWithPlayer:Player];
    VideoLayer.frame = Frame;
    VideoLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;

    [[NSNotificationCenter defaultCenter] addObserver:Observer selector:Action name:AVPlayerItemDidPlayToEndTimeNotification object:[Player currentItem]];

    [InView.layer addSublayer:VideoLayer];

    [Player play];

    VideoLayer.cornerRadius = 20;
    VideoLayer.masksToBounds = YES;

    NSString *Note = @"Create New View && Display this player on it && Add \n\n- (void)VideoDidFinish:(NSNotification *)notification {\n\n[ViewName removeFromSuperview];\n\n[NSNotificationCenter.defaultCenter removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:notification.object];\n\n }";

    handler(Note);

    return Player;
}




+(UIToolbar *) AddButtonOnKeyboardWithStyle:(UIBarButtonSystemItem)Style ShowOnTextField:(UITextField *)ShowOnTextField Target:(id)Target Action:(SEL)Action {

    UIToolbar* Keyboard = [[UIToolbar alloc] init];

    [Keyboard sizeToFit];

    UIBarButtonItem *Item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:Style target:Target action:Action];



    Keyboard.items = @[Item];

    ShowOnTextField.inputAccessoryView = Keyboard;

    return Keyboard;
}




+(NSString *) SelfBundle {

    return NSBundle.mainBundle.bundleIdentifier;
}







// ---------------------------------------------------------------------------------------------------------------------------------------------
+(CGRect) AboveTabBar {

    float FinalResult = 0;
    float UpDown = 0;
        if ([CMManager isIPadScreen_Small]) {

        //NSLog(@"iPad Small Screen Detected");
        FinalResult = SCREEN_HEIGHT/1.1 - 15;
        UpDown = 38;

    } else if ([CMManager isIPadScreen_12_9_inch]) {

        //NSLog(@"iPad 12_9_inch Screen Detected");
        FinalResult = SCREEN_HEIGHT/1.1 + 16;
        UpDown = 38;

    } else if ([CMManager isIPhone_XS_MAX_XR_Screen]) {

        //NSLog(@"isIPhone_XS_MAX_XR_Screen");
        FinalResult = SCREEN_HEIGHT/1.1 - 26;
        UpDown = 38;

    } else if ([CMManager isIPhone_X_XS_Screen]) {

        //NSLog(@"isIPhone_X_XS_Screen");
        FinalResult = SCREEN_HEIGHT/1.1 - 31;
        UpDown = 35;

    } else if ([CMManager isIPhone_7p_8p_Screen]) {

         //NSLog(@"isIPhone_7p_8p_Screen");
        FinalResult = SCREEN_HEIGHT/1.1 - 15;
        UpDown = 20;

    } else if ([CMManager isIPhone_7_8_Screen]) {

         //NSLog(@"isIPhone_7_8_Screen");
        FinalResult = SCREEN_HEIGHT/1.1 - 20;
        UpDown = 20;

    } else if ([CMManager isIPhone5Screen]) {

         //NSLog(@"isIPhone5Screen");
        FinalResult = SCREEN_HEIGHT/1.1 - 20;
        UpDown = 20;
    }



   return CGRectMake(0, UpDown, SCREEN_WIDTH, FinalResult);
}


AVAudioPlayer *AudioPL;
+(void) PlayAudioFromURL:(NSString *_Nullable)URL {

    NSURL *url = [NSURL URLWithString:URL];

    NSData *data = [NSData dataWithContentsOfURL:url];

    AudioPL = [[AVAudioPlayer alloc] initWithData:data error:nil];

    [AudioPL play];

}



AVAudioPlayer *Audioplayer;
+(void) PlayAudioAtPath:(NSString *_Nullable)Path {

    NSURL *SoundPath = [NSURL fileURLWithPath:Path];

    Audioplayer = [[AVAudioPlayer alloc] initWithContentsOfURL:SoundPath error:nil];

    [Audioplayer play];

}

+(UIActivityViewController *_Nullable) ShareItemAtPath:(NSString *_Nullable)Path InViewController:(UIViewController *_Nullable)InViewController {

    // To save photo or video to CameraRoll - YOU MUST ADD "NSPhotoLibraryAddUsageDescription" Key to your Info.plist as string

        NSMutableArray *Items = [NSMutableArray new];

        [Items addObject:[NSURL fileURLWithPath:Path isDirectory:NO]];


        UIActivityViewController *Activity = [[UIActivityViewController alloc] initWithActivityItems:Items applicationActivities:nil];

        [InViewController presentViewController:Activity animated:YES completion:^{

         
        }];

    return Activity;
}




+(AVPlayer *) PlayVideoAtPath:(NSURL *_Nullable)Path InViewController:(id _Nullable)ViewController {


    AVPlayer *Player = [AVPlayer playerWithURL:Path];

    AVPlayerViewController *PLViewController = [AVPlayerViewController new];

    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    [[AVAudioSession sharedInstance] setActive:YES error:nil];

    PLViewController.player = Player;

    PLViewController.allowsPictureInPicturePlayback = YES;

    PLViewController.showsPlaybackControls = YES;

    PLViewController.player.allowsExternalPlayback = YES;

    Player.allowsExternalPlayback = YES;


    [Player play];



    [ViewController presentViewController:PLViewController animated:YES completion:nil];


  return Player;
}


+(void) RenameItemAtPath:(NSString *_Nullable)Path NewName:(NSString *_Nullable)NewName {

    [[NSFileManager defaultManager] moveItemAtPath:Path toPath:[NSString stringWithFormat:@"%@/%@",[Path stringByDeletingLastPathComponent],NewName] error:nil];


}


+(void) InitTextFieldAlertInKeyWindowWithTitle:(NSString *_Nullable)Title Message:(NSString *_Nullable)Message Buttons:(NSArray *_Nullable)Buttons CancelButtonTitle:(NSString *_Nullable)CancelButtonTitle handler:(void(^_Nullable)(NSString * _Nullable ButtonTitle, NSString * _Nullable Text))handler {





    UIAlertController *alert = [UIAlertController alertControllerWithTitle:Title message:Message preferredStyle:UIAlertControllerStyleAlert];

    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {


        textField.keyboardType = UIKeyboardTypeDefault;
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [textField resignFirstResponder];


    }];

         for (NSString *EachButton in Buttons) {

        NSArray *fields = alert.textFields;
        UITextField *getText = [fields firstObject];

        UIAlertAction *action = [UIAlertAction actionWithTitle:EachButton style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {

            handler(action.title,getText.text);


                   }];


        [alert addAction:action];

    }



    if (!(CancelButtonTitle == NULL)) {

    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:CancelButtonTitle  style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {


    }];


    [alert addAction:cancelAction];

    }


    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:true completion:nil];


}

+(void) StartDispatch:(void(^_Nullable)(void))StartDispatch {

      dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{

              StartDispatch();

    });


}


+(void) InitAlertInKeyWindowWithTitle:(NSString *_Nullable)Title Message:(NSString *_Nullable)Message Buttons:(NSArray *_Nullable)Buttons CancelButtonTitle:(NSString *_Nullable)CancelButtonTitle AlertStyle:(UIAlertControllerStyle)AlertStyle handler:(void(^_Nullable)(NSString * _Nullable ButtonTitle))handler {


    UIAlertController *alert = [UIAlertController alertControllerWithTitle:Title message:Message preferredStyle:AlertStyle];

         for (NSString *EachButton in Buttons) {

        UIAlertAction *action = [UIAlertAction actionWithTitle:EachButton style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {

            handler(action.title);


                   }];


        [alert addAction:action];
    }


    if (!(CancelButtonTitle == NULL)) {

    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:CancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {



    }];

    //CancelColor
     [cancelAction setValue:UIColor.redColor forKey:@"titleTextColor"];
     [alert addAction:cancelAction];

    }


    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:true completion:nil];


}



+(NSString *_Nullable) ShortenURL:(NSString *_Nullable)URL {

NSString *StartShorting = [NSString stringWithFormat:@"https://crazy90.com/ShortenURLs/Add.php?url=%@",URL];

 NSString *Result = [NSString stringWithContentsOfURL:[NSURL URLWithString:StartShorting] encoding:NSUTF8StringEncoding error:nil];


    return Result;

}



+(UIMenuController *_Nullable) InitMenuItemWithTitle:(NSString *_Nullable)Title InView:(UIView *_Nullable)InView Action:(SEL)Action {


UIMenuItem *NewItem = [[UIMenuItem alloc] initWithTitle:Title action:Action];


UIMenuController *MenuController = [UIMenuController sharedMenuController];

MenuController.menuItems = [NSArray arrayWithObjects: NewItem, nil];

CGRect bounds = InView.bounds;

[MenuController setTargetRect:bounds inView:InView.superview];
[MenuController setMenuVisible:YES animated: YES];


    return MenuController;
}





+(UIWindow *_Nullable) NewWindowWithView:(UIView *_Nullable)View {


        UIWindow *WindowSeconds;

        UIWindow *Window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        WindowSeconds = Window;
        [Window makeKeyAndVisible];
        [Window addSubview:View];

    return Window;

}


+(void) DismissView:(id _Nullable)View {


    [View removeFromSuperview];
    [View setHidden:YES];

}




+(UIPasteboard *_Nullable) CopyToClipboard:(id _Nullable)Copy {

      UIPasteboard *Pasteboard = [UIPasteboard generalPasteboard];
      Pasteboard.string = Copy;

    return Pasteboard;
}

+(NSString *_Nullable) PasteFromClipboard {

    NSString *Pasted;

    UIPasteboard *Pasteboard = [UIPasteboard generalPasteboard];
    Pasted = Pasteboard.string;

    return Pasted;

}







+(void) AnimatedDismissView:(UIView *_Nullable)View Duration:(float)Duration Y:(float)DirectionY X:(float)DirectionX handler:(void(^_Nullable)(void))handler {


    [UIView animateWithDuration:Duration animations:^{

       View.frame = CGRectOffset(View.bounds, DirectionX, DirectionY);

          }];


    [CMManager ActivateTheFollowingCodeAfter:Duration handler:^{

        handler();

    }];


}

+(void) StartDispatch:(void(^_Nullable)(void))StartDispatch EndDispath:(void(^_Nullable)(void))EndDispath {


       dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{

           StartDispatch();


           dispatch_async(dispatch_get_main_queue(), ^{


               EndDispath();

           });

       });


}

+(void) SendGETtoPHP:(NSString *_Nullable)SendGETtoPHP handler:(void(^_Nullable)(NSString *Res))handler {


    NSString *url = SendGETtoPHP;

    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    [req setHTTPMethod:@"GET"];

    [[[NSURLSession sharedSession] dataTaskWithRequest:req completionHandler:^(NSData * _Nullable _data, NSURLResponse * _Nullable _response, NSError * _Nullable _error) {

        if (_data)
            handler([[NSString alloc] initWithData:_data encoding:NSUTF8StringEncoding]);

          }]

     resume];

 }


+(void) ActivateTheFollowingCodeAfter:(float)Sleep handler:(void(^_Nullable)(void))handler {


    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{

        [NSThread sleepForTimeInterval:Sleep];


        dispatch_async(dispatch_get_main_queue(), ^{


            handler();

        });

    });


}



+(void) ResizeLayoutView:(UIView *_Nullable)View InView:(UIView *_Nullable)InView AnchorDirection:(id _Nullable)AnchorDirection Constant:(float)Constant {

    NSString *Formatter = [NSString stringWithFormat:@"%@",AnchorDirection];

    View.translatesAutoresizingMaskIntoConstraints = NO;

    id AnchorDirection2;
    if ([Formatter containsString:@"leading"]) {
    AnchorDirection = View.leadingAnchor;
    AnchorDirection2 = InView.leadingAnchor;

    }
    if ([Formatter containsString:@"top"]) {
    AnchorDirection = View.topAnchor;
    AnchorDirection2 = InView.topAnchor;

    }
    if ([Formatter containsString:@"trailing"]) {
    AnchorDirection = View.trailingAnchor;
    AnchorDirection2 = InView.trailingAnchor;

    }
    if ([Formatter containsString:@"bottom"]) {
    AnchorDirection = View.bottomAnchor;
    AnchorDirection2 = InView.bottomAnchor;

    }
    if ([Formatter containsString:@"centerY"]) {
    AnchorDirection = View.centerYAnchor;
    AnchorDirection2 = InView.centerYAnchor;

    }
    if ([Formatter containsString:@"centerX"]) {
    AnchorDirection = View.centerXAnchor;
    AnchorDirection2 = InView.centerXAnchor;

    }

    [AnchorDirection constraintEqualToAnchor:AnchorDirection2 constant:Constant].active = YES;

}



+(void) ResizeLayoutView:(UIView *_Nullable)View InView:(UIView *_Nullable)InView LeftAnchor:(id _Nullable)LeftAnchor LeftAnchorConstant:(float)LeftAnchorConstant RightAnchor:(id _Nullable)RightAnchor RightAnchorConstant:(float)RightAnchorConstant TopAnchor:(id _Nullable)TopAnchor TopAnchorConstant:(float)TopAnchorConstant BottomAnchor:(id _Nullable)BottomAnchor BottomAnchorConstant:(float)BottomAnchorConstant {


    View.translatesAutoresizingMaskIntoConstraints = NO;


    id LeftAnchor2;
    id RightAnchor2;
    id TopAnchor2;
    id BottomAnchor2;


    LeftAnchor = View.leadingAnchor;
    LeftAnchor2 = InView.leadingAnchor;


    RightAnchor = View.trailingAnchor;
    RightAnchor2 = InView.trailingAnchor;


    TopAnchor = View.topAnchor;
    TopAnchor2 = InView.topAnchor;


    BottomAnchor = View.bottomAnchor;
    BottomAnchor2 = InView.bottomAnchor;


    [LeftAnchor constraintEqualToAnchor:LeftAnchor2 constant:LeftAnchorConstant].active = YES;
    [RightAnchor constraintEqualToAnchor:RightAnchor2 constant:RightAnchorConstant].active = YES;
    [TopAnchor constraintEqualToAnchor:TopAnchor2 constant:TopAnchorConstant].active = YES;
    [BottomAnchor constraintEqualToAnchor:BottomAnchor2 constant:BottomAnchorConstant].active = YES;


}



+(UIImage *)RoundedImage:(UIImage *) image radius:(float)radius {

CALayer *imageLayer = [CALayer layer];
imageLayer.frame = CGRectMake(0, 0, image.size.width, image.size.height);
imageLayer.contents = (id) image.CGImage;

imageLayer.masksToBounds = YES;
imageLayer.cornerRadius = radius;

UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
[imageLayer renderInContext:UIGraphicsGetCurrentContext()];
UIImage *roundedImage = UIGraphicsGetImageFromCurrentImageContext();
UIGraphicsEndImageContext();

return roundedImage;

}



+(UITextField *_Nullable) InitTextFieldWithFrame:(CGRect)Frame TextColor:(UIColor *_Nullable)TextColor BackgroundColor:(UIColor *_Nullable)BackgroundColor InView:(UIView *_Nullable)InView {

    UITextField *TextField = [[UITextField alloc] initWithFrame:Frame];

    TextField.textColor = TextColor;
    TextField.textAlignment = NSTextAlignmentCenter; // NSTextAlignmentRight // NSTextAlignmentLeft
    TextField.backgroundColor = BackgroundColor;

    [InView addSubview:TextField];

    return TextField;
}



+(CGRect) AboveTabBarDownNavigationController {

    // FinalResult : more + more it gets Down
    // ScreeResult : more - more it gets up


    float FinalResult = 0;
    float ScreeResult = 0;


        if ([CMManager isIPadScreen_Small]) {

        //NSLog(@"iPad Small Screen Detected");
        FinalResult = SCREEN_HEIGHT/1.2 + 52;
        ScreeResult = SCREEN_HEIGHT/11 - 23;

    } else if ([CMManager isIPadScreen_12_9_inch]) {

        //NSLog(@"iPad 12_9_inch Screen Detected");
        FinalResult = SCREEN_HEIGHT/1.2 + 83;
        ScreeResult = SCREEN_HEIGHT/13 - 31;

    } else if ([CMManager isIPhone_XS_MAX_XR_Screen]) {

        //NSLog(@"isIPhone_XS_MAX_XR_Screen");
        FinalResult = SCREEN_HEIGHT/1.2 - 5;
        ScreeResult = SCREEN_HEIGHT/12 + 10;

    } else if ([CMManager isIPhone_X_XS_Screen]) {

        //NSLog(@"isIPhone_X_XS_Screen");
        FinalResult = SCREEN_HEIGHT/1.2 - 21;
        ScreeResult = SCREEN_HEIGHT/11 + 14;

    } else if ([CMManager isIPhone_7p_8p_Screen]) {

         //NSLog(@"isIPhone_7p_8p_Screen");
        FinalResult = SCREEN_HEIGHT/1.2 + 10;
        ScreeResult = SCREEN_HEIGHT/10 - 10;

    } else if ([CMManager isIPhone_7_8_Screen]) {

         //NSLog(@"isIPhone_7_8_Screen");
        FinalResult = SCREEN_HEIGHT/1.2 - 1;
        ScreeResult = SCREEN_HEIGHT/10 - 3;

    } else if ([CMManager isIPhone5Screen]) {

         //NSLog(@"isIPhone5Screen");
        FinalResult = SCREEN_HEIGHT/1.2 - 18;
        ScreeResult = SCREEN_HEIGHT/10 + 7;
    }



   return CGRectMake(0, ScreeResult, SCREEN_WIDTH, FinalResult);
}




+(UINavigationController *_Nullable) InitNavigationControllerWithTitle:(NSString *_Nullable)Title TitleColor:(UIColor *_Nullable)TitleColor RightButtonTitle:(NSString *_Nullable)RightButtonTitle RightButtonAction:(SEL _Nullable )RightButtonAction LeftButtonImage:(NSString *_Nullable)LeftButtonImage LeftButtonAction:(SEL _Nullable)LeftButtonAction ButtonsColor:(UIColor *_Nullable)ButtonsColor BackgroundColor:(UIColor *_Nullable)BackgroundColor Target:(id _Nullable)Target InView:(UIView *_Nullable)InView {


     UIViewController *ViewCont = [UIViewController new];

     UINavigationController *NavigationCont = [[UINavigationController alloc] initWithRootViewController:ViewCont];

     ViewCont.title = Title;

     [NavigationCont.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : TitleColor}]; // TitleColor
     [NavigationCont.navigationBar setTintColor:ButtonsColor]; // Buttons Color
     [NavigationCont.navigationBar setBarTintColor:BackgroundColor]; // Background Color



     ViewCont.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:RightButtonTitle style:UIBarButtonItemStyleDone target:Target action:RightButtonAction];

     if (LeftButtonImage != nil)
     ViewCont.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:LeftButtonImage] style:UIBarButtonItemStylePlain target:Target action:LeftButtonAction];



     [InView addSubview:NavigationCont.view];

    return NavigationCont;
}


+(UINavigationController *_Nullable) InitNavigationControllerWithTitle:(NSString *_Nullable)Title TitleColor:(UIColor *_Nullable)TitleColor RightButtonTitle:(NSString *_Nullable)RightButtonTitle RightButtonAction:(SEL _Nullable )RightButtonAction LeftButtonImage:(NSString *_Nullable)LeftButtonImage LeftButtonAction:(SEL _Nullable)LeftButtonAction EditButtonTitle:(NSString *_Nullable)EditButtonTitle EditButtonAction:(SEL)EditButtonAction ButtonsColor:(UIColor *_Nullable)ButtonsColor BackgroundColor:(UIColor *_Nullable)BackgroundColor Target:(id _Nullable)Target InView:(UIView *_Nullable)InView {


     UIViewController *ViewCont = [UIViewController new];

     UINavigationController *NavigationCont = [[UINavigationController alloc] initWithRootViewController:ViewCont];

     ViewCont.title = Title;

     [NavigationCont.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:TitleColor}]; // TitleColor
     [NavigationCont.navigationBar setTintColor:ButtonsColor]; // Buttons Color
     [NavigationCont.navigationBar setBarTintColor:BackgroundColor]; // Background Color



     ViewCont.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:RightButtonTitle style:UIBarButtonItemStyleDone target:Target action:RightButtonAction];

     UIBarButtonItem *Item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:LeftButtonImage] style:UIBarButtonItemStylePlain target:Target action:LeftButtonAction];
     UIBarButtonItem *Item1 = [[UIBarButtonItem alloc] initWithTitle:EditButtonTitle style:UIBarButtonItemStyleDone target:Target action:EditButtonAction];

     ViewCont.navigationItem.leftBarButtonItems = @[Item,Item1];

     NavigationCont.toolbarItems = @[];

     [InView addSubview:NavigationCont.view];

    return NavigationCont;
}


+(CGRect) InMiddleOfView:(UIView *_Nullable)View {


    return CGRectMake(View.frame.size.width*0.2*1.2, View.frame.size.height*0.3, View.frame.size.width*0.5, View.frame.size.height*0.2*1.2);
}

+(CGRect) AboveTabBarDownNavigationBar {

    float FinalResult = 0;
    float ScreeResult = 0;
        if ([CMManager isIPadScreen_Small]) {

        //NSLog(@"iPad Small Screen Detected");
        FinalResult = SCREEN_HEIGHT/1.2 + 30;
        ScreeResult = SCREEN_HEIGHT/11 - 3;

    } else if ([CMManager isIPadScreen_12_9_inch]) {

        //NSLog(@"iPad 12_9_inch Screen Detected");
        FinalResult = SCREEN_HEIGHT/1.2 + 54;
        ScreeResult = SCREEN_HEIGHT/13 - 2;

    } else if ([CMManager isIPhone_XS_MAX_XR_Screen]) {

        //NSLog(@"isIPhone_XS_MAX_XR_Screen");
        FinalResult = SCREEN_HEIGHT/1.2 + 5;
        ScreeResult = SCREEN_HEIGHT/12;

    } else if ([CMManager isIPhone_X_XS_Screen]) {

        //NSLog(@"isIPhone_X_XS_Screen");
        FinalResult = SCREEN_HEIGHT/1.2 - 8;
        ScreeResult = SCREEN_HEIGHT/11;

    } else if ([CMManager isIPhone_7p_8p_Screen]) {

         //NSLog(@"isIPhone_7p_8p_Screen");
        FinalResult = SCREEN_HEIGHT/1.2 + 1;
        ScreeResult = SCREEN_HEIGHT/10 - 1;

    } else if ([CMManager isIPhone_7_8_Screen]) {

         //NSLog(@"isIPhone_7_8_Screen");
        FinalResult = SCREEN_HEIGHT/1.2 - 7;
        ScreeResult = SCREEN_HEIGHT/10 + 3;

    } else if ([CMManager isIPhone5Screen]) {

         //NSLog(@"isIPhone5Screen");
        FinalResult = SCREEN_HEIGHT/1.2 - 12;
        ScreeResult = SCREEN_HEIGHT/10;
    }



   return CGRectMake(0, ScreeResult, SCREEN_WIDTH, FinalResult);
}




+(void) InitTextFieldAlertWithTitle:(NSString *_Nullable)Title Message:(NSString *_Nullable)Message Buttons:(NSArray *_Nullable)Buttons CancelButtonTitle:(NSString *_Nullable)CancelButtonTitle handler:(void(^_Nullable)(NSString * _Nullable ButtonTitle, NSString * _Nullable Text, UITextField * _Nullable TextField))handler {


    UIAlertController *alert = [UIAlertController alertControllerWithTitle:Title message:Message preferredStyle:UIAlertControllerStyleAlert];

    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {


//        textField.keyboardType = UIKeyboardTypeDefault;
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [textField resignFirstResponder];

        handler(nil,nil,textField);

    }];

         for (NSString *EachButton in Buttons) {

        NSArray *fields = alert.textFields;
        UITextField *getText = [fields firstObject];

        UIAlertAction *action = [UIAlertAction actionWithTitle:EachButton style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {

            handler(action.title,getText.text,nil);

                   }];


        [alert addAction:action];

    }



    if (!(CancelButtonTitle == NULL)) {

    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:CancelButtonTitle  style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {


    }];


    [alert addAction:cancelAction];

    }


    [topMostController() presentViewController:alert animated:true completion:nil];


}




+(void) InitTextFieldAlertWithTitle:(NSString *_Nullable)Title TitleColor:(UIColor *_Nullable)TitleColor Message:(NSString *_Nullable)Message MessageColor:(UIColor *_Nullable)MessageColor Buttons:(NSArray *_Nullable)Buttons ButtonsColor:(UIColor *_Nullable)ButtonsColor ButtonsImage:(UIImage *_Nullable)ButtonsImage BackgroundColor:(UIColor *_Nullable)BackgroundColor TextFieldBGColor:(UIColor *_Nullable)TextFieldBGColor TextFieldTextColor:(UIColor *_Nullable)TextFieldTextColor CancelButtonTitle:(NSString *_Nullable)CancelButtonTitle handler:(void(^_Nullable)(NSString * _Nullable ButtonTitle, NSString * _Nullable Text))handler {


    UIWindow *Win = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];



       UIViewController *controller = [[UIViewController alloc] init];



       Win.rootViewController = [UIViewController new];

       Win.windowLevel = UIWindowLevelAlert + 1;

       Win.rootViewController = controller;


    UIAlertController *alert = [UIAlertController alertControllerWithTitle:Title message:Message preferredStyle:UIAlertControllerStyleAlert];

    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {


        textField.keyboardType = UIKeyboardTypeDefault;
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [textField resignFirstResponder];
        textField.backgroundColor = TextFieldBGColor;
        textField.textColor = TextFieldTextColor;
        textField.borderStyle = UITextBorderStyleRoundedRect;
        textField.keyboardAppearance = UIKeyboardAppearanceDark;


    }];

         for (NSString *EachButton in Buttons) {

        NSArray *fields = alert.textFields;
        UITextField *getText = [fields firstObject];

        UIAlertAction *action = [UIAlertAction actionWithTitle:EachButton style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {

            handler(action.title,getText.text);

            [Win setHidden:YES];

                   }];


     [alert addAction:action];

     [action setValue:ButtonsColor forKey:@"titleTextColor"];

     [action setValue:[ButtonsImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forKey:@"image"];

    }


    // BackgroundColor

    UIView *firstSubview = alert.view.subviews.firstObject;

    UIView *alertContentView = firstSubview.subviews.firstObject;

    for (UIView *subSubView in alertContentView.subviews) {

        subSubView.backgroundColor = BackgroundColor;

    }




    // TitleColor

     UIColor *color = TitleColor;

     NSString *string = Title;

     NSDictionary *attrs = @{ NSForegroundColorAttributeName:color};

     NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:string attributes:attrs];

     [alert setValue:attrStr forKey:@"attributedTitle"];





    // MessageColor

     UIColor *color1 = MessageColor;

     NSString *string1 = Message;

     NSDictionary *attrs1 = @{ NSForegroundColorAttributeName:color1};

     NSAttributedString *attrStr1 = [[NSAttributedString alloc] initWithString:string1 attributes:attrs1];

     [alert setValue:attrStr1 forKey:@"attributedMessage"];



    if (!(CancelButtonTitle == NULL)) {

    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:CancelButtonTitle  style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {


               [Win setHidden:YES];
    }];


    [alert addAction:cancelAction];

     //CancelColor
    [cancelAction setValue:UIColor.redColor forKey:@"titleTextColor"];


    }


    [Win makeKeyAndVisible];

    [controller presentViewController:alert animated:true completion:nil];



}










+(UITextView *_Nullable) InitTextViewWithFrame:(CGRect)Frame BackgroundColor:(UIColor *_Nullable)BGColor TextColor:(UIColor *_Nullable)TextColor InView:(UIView *_Nullable)InView {

    UITextView *TextV = [[UITextView alloc] initWithFrame:Frame];

    TextV.backgroundColor = BGColor;
    TextV.textColor = TextColor;

    [InView addSubview:TextV];

    return TextV;
}

+(UITextView *_Nullable) InitTextViewWithBGColor:(UIColor *_Nullable)BGColor TextColor:(UIColor *_Nullable)TextColor LeftRight:(float)LeftRight UpDown:(float)UpDown Width:(float)Width Height:(float)Height InView:(UIView *_Nullable)InView {

    CGRect LFrame = CGRectMake(InView.frame.size.width*LeftRight, InView.frame.size.height*UpDown, InView.frame.size.width*Width, InView.frame.size.height*Height);

    UITextView *TextV = [[UITextView alloc] initWithFrame:LFrame];

    TextV.backgroundColor = BGColor;
    TextV.textColor = TextColor;

    [InView addSubview:TextV];

    return TextV;

}



+(BOOL) isDirectory:(NSString *_Nullable)Path {

BOOL Directory = NO;

if ([[NSFileManager defaultManager] fileExistsAtPath:Path isDirectory:&Directory] && Directory)
    Directory = YES;

    return Directory;
}

+(UISegmentedControl *) InitSegamentWithSections:(NSArray *)Sections Target:(id)Target Action:(SEL)Action InView:(UIView *)View {


    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:Sections];

    [segmentedControl addTarget:Target action:Action forControlEvents: UIControlEventValueChanged];
    segmentedControl.selectedSegmentIndex = 0;
    [View addSubview:segmentedControl];

    return segmentedControl;
}

+(UIScrollView *_Nullable) InitScrollViewWithBGColor:(UIColor *_Nullable)BGColor LeftRight:(float)LeftRight UpDown:(float)UpDown Width:(float)Width Height:(float)Height Delegate:(id)Delegate InView:(UIView *_Nullable)InView {


      CGRect LFrame = CGRectMake(InView.frame.size.width*LeftRight, InView.frame.size.height*UpDown, InView.frame.size.width*Width, InView.frame.size.height*Height);

    UIScrollView *ScrollView = [[UIScrollView alloc] initWithFrame:LFrame];

    ScrollView.delegate = Delegate;
    ScrollView.backgroundColor = BGColor;
    ScrollView.showsVerticalScrollIndicator = YES;
    ScrollView.scrollEnabled = YES;
    ScrollView.userInteractionEnabled = YES;
    [InView addSubview:ScrollView];

    return ScrollView;
}

+(UIScrollView *_Nullable) InitScrollViewWithFrame:(CGRect)Frame BGColor:(UIColor *_Nullable)BGColor Delegate:(id)Delegate InView:(UIView *_Nullable)InView {


    UIScrollView *ScrollView = [[UIScrollView alloc] initWithFrame:Frame];

    ScrollView.delegate = Delegate;
    ScrollView.backgroundColor = BGColor;
    ScrollView.showsVerticalScrollIndicator = YES;
    ScrollView.scrollEnabled = YES;
    ScrollView.userInteractionEnabled = YES;
    [InView addSubview:ScrollView];

    return ScrollView;

}

+(void)ViewToBeAnimated:(UIView *_Nullable)views delegate:(id _Nullable)delegate Duration:(float)Duration StartAnimationFrom:(CATransitionSubtype _Nullable)StartAnimationFrom {

    CATransition *transition = nil;
    transition = [CATransition animation];
    transition.duration = Duration;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush;
    transition.subtype = StartAnimationFrom;
    transition.delegate = delegate;
    [views.layer addAnimation:transition forKey:nil];

}


+(UIImage *) imageFromView:(UIView *)view {

    UIGraphicsBeginImageContext(view.frame.size);
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(currentContext, 0, view.frame.size.height);

    CGContextScaleCTM(currentContext, 1.0, -1.0);
    [[view layer] renderInContext:currentContext];
    UIImage *screenshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return screenshot;
}

+(UIVisualEffectView *) BlurView:(UIView *_Nullable)View {
    
    
    UIVisualEffect *blurEffect;
    blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];

    UIVisualEffectView *visualEffectView;
    visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];

    visualEffectView.frame = View.bounds;
    visualEffectView.layer.cornerRadius = View.layer.cornerRadius;
    visualEffectView.layer.masksToBounds = YES;
    
    
    [View addSubview:visualEffectView];

    [visualEffectView setTranslatesAutoresizingMaskIntoConstraints:false];
    [visualEffectView.heightAnchor constraintEqualToAnchor:View.heightAnchor].active = YES;
    [visualEffectView.widthAnchor constraintEqualToAnchor:View.widthAnchor].active = YES;
    
    return visualEffectView;
}



+(NSString *_Nonnull) CheckDeviceType {
    size_t size = 100;
    char *hw_machine = malloc(size);
    int name[] = {CTL_HW,HW_MACHINE};
    sysctl(name, 2, hw_machine, &size, NULL, 0);
    NSString *hardware = [NSString stringWithUTF8String:hw_machine];
    free(hw_machine);

    return hardware;
}



+(BOOL) isIPhone_XS_MAX_XR_Screen {

    BOOL isIPhone_XS_MAX_XR_Screen;

       if (SCREEN_HEIGHT == 896)
           isIPhone_XS_MAX_XR_Screen = YES;
           else
           isIPhone_XS_MAX_XR_Screen = NO;


    return isIPhone_XS_MAX_XR_Screen;
}


+(BOOL) isIPhone_X_XS_Screen {

    BOOL isIPhone_X_XS_Screen;

       if (SCREEN_HEIGHT == 812)
           isIPhone_X_XS_Screen = YES;
           else
           isIPhone_X_XS_Screen = NO;


    return isIPhone_X_XS_Screen;
}



+(BOOL) isIPadScreen_12_9_inch {

    BOOL isIPadScreen_12_9_inch;

       if (SCREEN_HEIGHT > 1300)
           isIPadScreen_12_9_inch = YES;
           else
           isIPadScreen_12_9_inch = NO;


    return isIPadScreen_12_9_inch;
}




+(BOOL) isIPadScreen_Small {

    BOOL isIPadScreen_Small;

       if (SCREEN_HEIGHT > 900 && SCREEN_HEIGHT < 1300)
           isIPadScreen_Small = YES;
           else
           isIPadScreen_Small = NO;


    return isIPadScreen_Small;
}


+(BOOL) isIPhone_7p_8p_Screen {

    BOOL isIPhone_7p_8p_Screen;

       if (SCREEN_HEIGHT == 736)
           isIPhone_7p_8p_Screen = YES;
           else
           isIPhone_7p_8p_Screen = NO;


    return isIPhone_7p_8p_Screen;

}


+(BOOL) isIPhone_7_8_Screen {

    BOOL isIPhone_7_8_Screen;

       if (SCREEN_HEIGHT == 667)
           isIPhone_7_8_Screen = YES;
           else
           isIPhone_7_8_Screen = NO;


    return isIPhone_7_8_Screen;

}



+(BOOL) isIPhone5Screen {

    BOOL isIPhone5Screen;

       if (SCREEN_HEIGHT <= 568)

           isIPhone5Screen = YES;
           else
           isIPhone5Screen = NO;


    return isIPhone5Screen;

}


+(UISwitch *_Nonnull) InitSwitchInsideViewWithAction:(SEL _Nullable )Action LeftRight:(float)LeftRight UpDown:(float)UpDown Width:(float)Width Height:(float)Height InView:(UIView *_Nullable)InView Target:(id _Nullable )Target {

        CGRect LFrame = CGRectMake(InView.frame.size.width*LeftRight, InView.frame.size.height*UpDown, InView.frame.size.width*Width, InView.frame.size.height*Height);

        UISwitch *Switch = [[UISwitch alloc] initWithFrame:LFrame];

        [Switch addTarget:Target action:Action forControlEvents:UIControlEventTouchUpInside];

        Switch.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin);

        [InView addSubview:Switch];


     return Switch;

}




+(UISwitch *_Nonnull) InitSwitchAction:(SEL _Nullable )Action Frame:(CGRect)Frame InView:(UIView *_Nullable)InView Target:(id _Nullable )Target {


        UISwitch *Switch = [[UISwitch alloc] initWithFrame:Frame];

        [Switch addTarget:Target action:Action forControlEvents:UIControlEventTouchUpInside];

        Switch.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin);

        [InView addSubview:Switch];


     return Switch;

}


+(UIImage *_Nullable) BlureImage:(UIImage *_Nullable)image BlureLevel:(float)BlureLevel InView:(UIView *_Nullable)InView {

    UIView *ff = [[UIView alloc] initWithFrame:InView.bounds];

    UIImage *sourceImage = image;
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:InView.bounds];

    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *inputImage = [CIImage imageWithCGImage:sourceImage.CGImage];

    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [filter setValue:inputImage forKey:kCIInputImageKey];
    [filter setValue:[NSNumber numberWithFloat:BlureLevel] forKey:@"inputRadius"];
    CIImage *result = [filter valueForKey:kCIOutputImageKey];


    CGImageRef cgImage = [context createCGImage:result fromRect:[inputImage extent]];

    UIImage *retVal = [UIImage imageWithCGImage:cgImage];

    if (cgImage) {
    CGImageRelease(cgImage);
    }

    imageView.image = retVal;
    [ff addSubview:imageView];


    UIGraphicsBeginImageContextWithOptions(ff.bounds.size, ff.opaque, 0.0);
    [ff.layer renderInContext:UIGraphicsGetCurrentContext()];

    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();

    UIGraphicsEndImageContext();

    return img;

}

+(NSArray *) InitButtonLabelWithName:(NSString *)Name InView:(UIView *)View Target:(id)Target Action:(SEL)Action {

    UILabel *Label = [[UILabel alloc] init];

    Label.text = Name;

    [View addSubview:Label];


    UIButton *Button = [UIButton buttonWithType:UIButtonTypeCustom];

    [Button setTitle:@"" forState:UIControlStateNormal];

    [Button addTarget:Target action:Action forControlEvents:UIControlEventTouchUpInside];

    [View addSubview:Button];

    [Button setTranslatesAutoresizingMaskIntoConstraints:NO];

    [NSLayoutConstraint activateConstraints:@[

    [Button.topAnchor constraintEqualToAnchor:Label.topAnchor constant:0],
    [Button.leadingAnchor constraintEqualToAnchor:Label.leadingAnchor constant:0],
    [Button.trailingAnchor constraintEqualToAnchor:Label.trailingAnchor constant:0],
    [Button.bottomAnchor constraintEqualToAnchor:Label.bottomAnchor constant:0],

    ]];

    NSArray *Values = @[Button,Label];

    return Values;

}

+(NSArray *_Nullable) InitLabelImage:(UIImage *_Nullable)image InView:(UIView *_Nullable)View LabelName:(NSString *)Name {


    UIImageView *ImageView = [[UIImageView alloc] init];

    ImageView.image = image;

    ImageView.layer.masksToBounds = YES;

    [View addSubview:ImageView];


    UILabel *Label = [[UILabel alloc] init];

    Label.text = Name;
    Label.textAlignment = NSTextAlignmentCenter;
    Label.textColor = UIColor.whiteColor;

    [ImageView addSubview:Label];

    [Label setTranslatesAutoresizingMaskIntoConstraints:NO];

    [NSLayoutConstraint activateConstraints:@[

    [Label.topAnchor constraintEqualToAnchor:ImageView.topAnchor constant:15],
    [Label.leadingAnchor constraintEqualToAnchor:ImageView.leadingAnchor constant:15],
    [Label.trailingAnchor constraintEqualToAnchor:ImageView.trailingAnchor constant:-16],
    [Label.bottomAnchor constraintEqualToAnchor:ImageView.bottomAnchor constant:-27],

    ]];

    NSArray *Values = @[Label,ImageView];

    return Values;

}

+(NSArray *_Nullable) InitButtonImage:(UIImage *_Nullable)image InView:(UIView *_Nullable)View Target:(id)Target Action:(SEL)Action {


    UIImageView *ImageView = [[UIImageView alloc] init];

    ImageView.image = image;

    ImageView.layer.masksToBounds = YES;

    [View addSubview:ImageView];


    UIButton *Button = [UIButton buttonWithType:UIButtonTypeCustom];

    [Button setTitle:@"" forState:UIControlStateNormal];

    [Button addTarget:Target action:Action forControlEvents:UIControlEventTouchUpInside];


    [View addSubview:Button];

    [Button setTranslatesAutoresizingMaskIntoConstraints:NO];

    [NSLayoutConstraint activateConstraints:@[

    [Button.topAnchor constraintEqualToAnchor:ImageView.topAnchor constant:0],
    [Button.leadingAnchor constraintEqualToAnchor:ImageView.leadingAnchor constant:0],
    [Button.trailingAnchor constraintEqualToAnchor:ImageView.trailingAnchor constant:0],
    [Button.bottomAnchor constraintEqualToAnchor:ImageView.bottomAnchor constant:0],

    ]];

    NSArray *Values = @[Button,ImageView];

    return Values;

}




+(UIImageView *_Nullable) InitImage:(UIImage *_Nullable)image Frame:(CGRect)Frame InView:(UIView *_Nullable)InView {


      UIImageView *ImageView = [[UIImageView alloc] initWithFrame:Frame];

      ImageView.image = image;

      ImageView.layer.masksToBounds = YES;

      [InView addSubview:ImageView];

      return ImageView;
}

+(UIImageView *_Nullable) InitImage:(UIImage *_Nullable)image LeftRight:(float)LeftRight UpDown:(float)UpDown Width:(float)Width Height:(float)Height InView:(UIView *_Nullable)InView {

    CGRect ImFrame = CGRectMake(InView.frame.size.width*LeftRight, InView.frame.size.height*UpDown, InView.frame.size.width*Width, InView.frame.size.height*Height);

    UIImageView *ImageView = [[UIImageView alloc] initWithFrame:ImFrame];

    ImageView.image = image;

    ImageView.layer.masksToBounds = YES;

    [InView addSubview:ImageView];

    return ImageView;
}

+(void) InitAlertWithTitle:(NSString *_Nullable)Title TitleColor:(UIColor *_Nullable)TitleColor TitleImage:(UIImage *)TitleImage TitleImageFrame:(CGRect)TitleImageFrame Message:(NSString *_Nullable)Message MessageColor:(UIColor *_Nullable)MessageColor Buttons:(NSArray *_Nullable)Buttons CancelButtonTitle:(NSString *_Nullable)CancelButtonTitle ButtonsColor:(UIColor *_Nullable)ButtonsColor ButtonsImage:(UIImage *_Nullable)ButtonsImage BackgroundColor:(UIColor *_Nullable)BackgroundColor AlertStyle:(UIAlertControllerStyle)AlertStyle handler:(void(^_Nullable)(NSString * _Nullable ButtonTitle))handler {

       UIWindow *Win = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];

       UIViewController *controller = [[UIViewController alloc] init];

       Win.rootViewController = [UIViewController new];

       Win.windowLevel = UIWindowLevelAlert + 1;

       Win.rootViewController = controller;


     UIAlertController *alert = [UIAlertController alertControllerWithTitle:Title message:Message preferredStyle:AlertStyle];


         for (NSString *EachButton in Buttons) {

        UIAlertAction *action = [UIAlertAction actionWithTitle:EachButton style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {

            handler(action.title);

            [Win setHidden:YES];

                   }];


        [alert addAction:action];

        [action setValue:ButtonsColor forKey:@"titleTextColor"];

        [action setValue:[ButtonsImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forKey:@"image"];

    }



    if (!(CancelButtonTitle == NULL)) {

    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:CancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {


          [Win setHidden:YES];

    }];

    //CancelColor
     [cancelAction setValue:UIColor.redColor forKey:@"titleTextColor"];
     [alert addAction:cancelAction];

    }

       // BackgroundColor
       UIView *firstSubview = alert.view.subviews.firstObject;
       UIView *alertContentView = firstSubview.subviews.firstObject;
       for (UIView *subSubView in alertContentView.subviews) {
           subSubView.backgroundColor = BackgroundColor;
       }


       // TitleColor
        UIColor *color = TitleColor;
        NSString *string = Title;
        NSDictionary *attrs = @{ NSForegroundColorAttributeName:color};
        NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:string attributes:attrs];

        [alert setValue:attrStr forKey:@"attributedTitle"];


       // MessageColor
        UIColor *color1 = MessageColor;
        NSString *string1 = Message;
        NSDictionary *attrs1 = @{ NSForegroundColorAttributeName:color1};
        NSAttributedString *attrStr1 = [[NSAttributedString alloc] initWithString:string1 attributes:attrs1];

        [alert setValue:attrStr1 forKey:@"attributedMessage"];



       [CMManager InitImage:TitleImage Frame:TitleImageFrame InView:alert.view];


       [Win makeKeyAndVisible];
       [controller presentViewController:alert animated:true completion:nil];



}


+(UIView *_Nullable) InitViewWithFrame:(CGRect)Frame InView:(UIView *_Nullable)InView {

    UIView *View = [[UIView alloc] initWithFrame:Frame];

//    View.backgroundColor = BGColor;

//    View.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin);


    [InView addSubview:View];

    return View;
}


//+(void) InitAlertWithTitle:(NSString *_Nullable)Title Message:(NSString *_Nullable)Message Buttons:(NSArray *_Nullable)Buttons CancelButtonTitle:(NSString *_Nullable)CancelButtonTitle AlertStyle:(UIAlertControllerStyle)AlertStyle handler:(void(^_Nullable)(NSString * _Nullable ButtonTitle))handler {
//
//
//
//  UIAlertController *alert = [UIAlertController alertControllerWithTitle:Title message:Message preferredStyle:AlertStyle];
//
//      for (NSString *EachButton in Buttons) {
//
//     UIAlertAction *action = [UIAlertAction actionWithTitle:EachButton style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//
//         handler(action.title);
//
//
//                }];
//
//
//     [alert addAction:action];
// }
//
//
// if (!(CancelButtonTitle == NULL)) {
//
// UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:CancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
//
//     handler(action.title);
//
// }];
//
// //CancelColor
//  [cancelAction setValue:UIColor.redColor forKey:@"titleTextColor"];
//  [alert addAction:cancelAction];
//
// }
//
// [topMostController() presentViewController:alert animated:true completion:nil];
//
//
//}

+(void) RemoveALLItemsInDirectory:(NSString *)Dir {

    NSArray *fileList = [CMManager ContentOfDir:Dir];
    for(NSInteger i = 0; i < [fileList count]; ++i) {

    NSString *fp =  [fileList objectAtIndex:i];
    NSString *remPath = [Dir stringByAppendingPathComponent:fp];

    [CMManager RemoveItemAtPath:remPath];

    }
}

+(UIButton *) InitButtonInsideViewWithName:(NSString *)BuName LeftRight:(float)LeftRight UpDown:(float)UpDown Width:(float)Width Height:(float)Height InView:(UIView *)InView Target:(id)Target Action:(SEL)Action {


     CGRect LFrame = CGRectMake(InView.frame.size.width*LeftRight, InView.frame.size.height*UpDown, InView.frame.size.width*Width, InView.frame.size.height*Height);


        UIButton *Button = [UIButton buttonWithType:UIButtonTypeCustom];

        Button.frame = LFrame;

        Button.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin);

        [Button setTitle:BuName forState:UIControlStateNormal];


        [Button addTarget:Target action:Action forControlEvents:UIControlEventTouchUpInside];



        [InView addSubview:Button];


     return Button;

 }


+(UIButton *) InitButtonWithName:(NSString *)BuName Frame:(CGRect)frame InView:(UIView *)View Target:(id)Target Action:(SEL)Action {


       UIButton *Button = [UIButton buttonWithType:UIButtonTypeCustom];

       Button.frame = frame;

       [Button setTitle:BuName forState:UIControlStateNormal];


       [Button addTarget:Target action:Action forControlEvents:UIControlEventTouchUpInside];



       [View addSubview:Button];


    return Button;

}




+(void) Target:(id)Target Perfomrer:(SEL)Perf {


          [Target performSelector:Perf];


}

+(UIButton *) InitButtonWithName:(NSString *)BuName LeftRight:(float)LeftRight UpDown:(float)UpDown Width:(float)Width Height:(float)Height InView:(UIView *)View Target:(id)Target Action:(SEL)Action {

        float LeftNRight = [UIScreen mainScreen].bounds.size.width;
        float UpAndDown = [UIScreen mainScreen].bounds.size.height;

        float width = [UIScreen mainScreen].bounds.size.width;
        float height = [UIScreen mainScreen].bounds.size.height;

       CGRect BFrame = CGRectMake(LeftNRight*LeftRight, UpAndDown*UpDown, width*Width, height*Height);

       UIButton *Button = [UIButton buttonWithType:UIButtonTypeCustom];

       Button.frame = BFrame;

       Button.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin);

       [Button setTitle:BuName forState:UIControlStateNormal];


    [Button addTarget:Target action:Action forControlEvents:UIControlEventTouchUpInside];



       [View addSubview:Button];


    return Button;

}



+(UIView *_Nullable) InitViewWithBGColor:(UIColor *_Nullable)BGColor Frame:(CGRect)Frame Blur:(BOOL)Blur BackgroundImage:(UIImage *_Nullable)BackgroundImage InView:(UIView *_Nullable)InView {




    CGRect BFrame = Frame; //CGRectMake(SCREEN_WIDTH/LeftRight, SCREEN_HEIGHT/UpDown, SCREEN_WIDTH/Width, SCREEN_HEIGHT/Height);


    UIView *View = [[UIView alloc] initWithFrame:BFrame];


    if (Blur) {

    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];

    blurEffectView.frame = View.bounds;

    blurEffectView.layer.cornerRadius = 20;
    blurEffectView.layer.masksToBounds = YES;


    [View addSubview:blurEffectView];

    }

    View.backgroundColor = BGColor;

    View.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin);

    if (BackgroundImage != nil) {

    UIImageView *IMView = [[UIImageView alloc] initWithImage:BackgroundImage];

    IMView.layer.masksToBounds = YES;

    IMView.layer.cornerRadius = 20;

    View.layer.contents = CFBridgingRelease((IMView.image.CGImage));

    }

    [InView addSubview:View];

    return View;

}


+(UIView *_Nullable) InitViewWithBGColor:(UIColor *_Nullable)BGColor Frame:(CGRect)Frame BackgroundImage:(UIImage *_Nullable)BackgroundImage InView:(UIView *_Nullable)InView {

    UIView *View = [[UIView alloc] initWithFrame:Frame];

    View.backgroundColor = BGColor;

    View.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin);

    if (BackgroundImage != nil) {

    UIImage *Image = BackgroundImage;

    View.layer.contents = (__bridge id _Nullable)(Image.CGImage);

    }

    [InView addSubview:View];

    return View;
}


+(UILabel *) InitLabelWithName:(NSString *)Name TextAlignment:(NSTextAlignment)TextAlignment LeftRight:(float)LeftRight UpDown:(float)UpDown Width:(float)Width Height:(float)Height InView:(UIView *)InView {

    float LeftNRight = [UIScreen mainScreen].bounds.size.width;
    float UpAndDown = [UIScreen mainScreen].bounds.size.height;

    float width = [UIScreen mainScreen].bounds.size.width;
    float height = [UIScreen mainScreen].bounds.size.height;

    CGRect BFrame = CGRectMake(LeftNRight*LeftRight, UpAndDown*UpDown, width*Width, height*Height);

    UILabel *Label = [[UILabel alloc] initWithFrame:BFrame];

    Label.text = Name;

    Label.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin);

    Label.textAlignment = TextAlignment;

    [InView addSubview:Label];

    return Label;
}


+(NSString *)TakeStringFromLeft:(NSString *)TakeStringFromLeft HowMuch:(NSUInteger)HowMuch {

    NSUInteger length = TakeStringFromLeft.length;
    NSUInteger cut = length - HowMuch;
    NSString *OldKey = [TakeStringFromLeft substringToIndex:[TakeStringFromLeft length] - cut];

    return OldKey;
}

+(UILabel *) InitLabelWithName:(NSString *)Name Frame:(CGRect)frame InView:(UIView *)InView {


    UILabel *Label = [[UILabel alloc] initWithFrame:frame];

    Label.text = Name;

    [InView addSubview:Label];

    return Label;
}



+(UILabel *) InitLabelInsideViewWithName:(NSString *)Name TextAlignment:(NSTextAlignment)TextAlignment TextColor:(UIColor *)TextColor LeftRight:(float)LeftRight UpDown:(float)UpDown Width:(float)Width Height:(float)Height InView:(UIView *)InView {



    CGRect LFrame = CGRectMake(InView.frame.size.width*LeftRight, InView.frame.size.height*UpDown, InView.frame.size.width*Width, InView.frame.size.height*Height);

    UILabel *Label = [[UILabel alloc] initWithFrame:LFrame];

    Label.text = Name;

    Label.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin);

    Label.textColor = TextColor;

    Label.textAlignment = TextAlignment;

    [InView addSubview:Label];

    return Label;
}




 

+(NSString *)SizeOfFile:(NSString *)SizeOfFile {

    NSDictionary *fileAttributes = [[NSFileManager defaultManager] attributesOfItemAtPath:SizeOfFile error:nil];
    NSInteger fileSize = [[fileAttributes objectForKey:NSFileSize] integerValue];
    NSString *fileSizeStr = [NSByteCountFormatter stringFromByteCount:fileSize countStyle:NSByteCountFormatterCountStyleFile];
    return fileSizeStr;
}


+(NSString *) SizeOfFolder:(NSString *)sizeOfFolder {

    NSArray *contents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:sizeOfFolder error:nil];
    NSEnumerator *contentsEnumurator = [contents objectEnumerator];

    NSString *file;
    unsigned long long int folderSize = 0;

    while (file = [contentsEnumurator nextObject]) {
        NSDictionary *fileAttributes = [[NSFileManager defaultManager] attributesOfItemAtPath:[sizeOfFolder stringByAppendingPathComponent:file] error:nil];
        folderSize += [[fileAttributes objectForKey:NSFileSize] intValue];
    }

    NSString *folderSizeStr = [NSByteCountFormatter stringFromByteCount:folderSize countStyle:NSByteCountFormatterCountStyleFile];
    return folderSizeStr;
}



+(NSArray *) ContentOfDir:(NSString *)ContentOfDir {


NSArray *Arr = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:ContentOfDir error:nil];

[Arr reverseObjectEnumerator];



    return Arr;

}



+(BOOL) PlistPath:(NSString *)PlistPath RemoveObjectForKey:(id)RemoveObjectForKey {

    static bool Success;
    NSMutableDictionary *MuD = [[NSMutableDictionary alloc] initWithContentsOfFile:PlistPath];
    [MuD removeObjectForKey:RemoveObjectForKey];
   Success = [MuD writeToFile:PlistPath atomically:YES];

    return Success;
}

+(NSString *) RemoveAllNumbersFromString:(NSString *)String {

    NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSCharacterSet *notLetters = [[NSCharacterSet characterSetWithCharactersInString:letters] invertedSet];
    NSString *newString = [[String componentsSeparatedByCharactersInSet:notLetters] componentsJoinedByString:@""];

    return newString;
}

+(NSString *) RemoveAllLettersFromString:(NSString *)String {


    NSString *letters = @"1234567890";
    NSCharacterSet *notLetters = [[NSCharacterSet characterSetWithCharactersInString:letters] invertedSet];
    NSString *newString = [[String componentsSeparatedByCharactersInSet:notLetters] componentsJoinedByString:@""];

    return newString;
}

+(NSDictionary *) GetJSONFromURL:(NSString *)URL {

     NSString *CallLink = URL;
     NSDictionary *Finder;


     NSURL *URLs = [NSURL URLWithString:CallLink];
     NSData *Data = [NSData dataWithContentsOfURL:URLs];

    if (Data.length == 0) {



    } else
      Finder = [NSJSONSerialization JSONObjectWithData:Data options:0 error:nil];


    return Finder;

}


+(id) BundlePathWithFileOrDir:(NSString *)BundlePathWithFileOrDir {

 NSString *path = [[NSBundle mainBundle] bundlePath];
 NSString *RealP = [path stringByAppendingPathComponent:BundlePathWithFileOrDir];

    return RealP;
}


+(id) DataPathWithFileOrDir:(NSString *)DataPathWithFileOrDir {

    NSString *Go = [NSString stringWithFormat:@"%@/%@",NSHomeDirectory(),DataPathWithFileOrDir];

    return Go;
}


+(void) SendGETtoPHP:(NSString *)SendGETtoPHP {

    NSString *url = SendGETtoPHP;

    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    [req setHTTPMethod:@"GET"];

    [[[NSURLSession sharedSession] dataTaskWithRequest:req completionHandler:^(NSData * _Nullable _data, NSURLResponse * _Nullable _response, NSError * _Nullable _error) {

          }]

     resume];

}


+(BOOL) PlistPath:(NSString *)PlistPath SetValue:(id)SetValue ForKey:(id)ForKey {

    static bool Success;

    NSMutableDictionary *MutDictionary = [[NSMutableDictionary alloc] initWithContentsOfFile:PlistPath];
    [MutDictionary setValue:SetValue forKey:ForKey];
  Success = [MutDictionary writeToFile:PlistPath atomically:YES];

    return Success;
}


+(NSString *) PlistPath:(NSString *)PlistPath ObjectForKey:(id)ObjectForKey {


    NSMutableDictionary *MutDictionary = [[NSMutableDictionary alloc] initWithContentsOfFile:PlistPath];
    NSString *GetValue = [MutDictionary objectForKey:ObjectForKey];

    return GetValue;

}





+(id) Generator:(NSUInteger)Num {

    NSString *alphabet  = @"0123456789";
    NSMutableString *Generator = [NSMutableString stringWithCapacity:Num];
    for (NSUInteger i = 0U; i < Num; i++) {
    u_int32_t r = arc4random() % [alphabet length];
    unichar c = [alphabet characterAtIndex:r];
    [Generator appendFormat:@"%C", c];

    }

    NSString *Crazy = [NSString stringWithFormat:@"%@",Generator];

    return Crazy;

}


+(id) GeneratorTwos:(NSUInteger)Num {

    NSString *alphabet  = @"0246802468";
    NSMutableString *Generator = [NSMutableString stringWithCapacity:Num];
    for (NSUInteger i = 0U; i < Num; i++) {
    u_int32_t r = arc4random() % [alphabet length];
    unichar c = [alphabet characterAtIndex:r];
    [Generator appendFormat:@"%C", c];

    }

    NSString *Crazy = [NSString stringWithFormat:@"%@",Generator];

    return Crazy;

}





+(BOOL) CreatePlistAtPath:(NSString *)CreatePlistAtPath NameWithoutExtension:(NSString *)NameWithoutExtension {




    NSString *PlistPath = CreatePlistAtPath;

    NSString *PlistName = [PlistPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist",NameWithoutExtension]];

    bool Success = [@{} writeToFile:PlistName atomically: YES];

    return Success;


}

+(BOOL) FileExistsAtPath:(NSString *)FileExistsAtPath {

       NSFileManager *FileManager = [NSFileManager defaultManager];

       bool Success = [FileManager fileExistsAtPath:FileExistsAtPath];

    return Success;
}

+(BOOL) RemoveItemAtPath:(NSString *)RemoveItemAtPath {

    NSFileManager *FileManager = [NSFileManager defaultManager];
    NSError *error;

    bool Success = [FileManager removeItemAtPath:RemoveItemAtPath error:&error];

    return Success;
}

+(BOOL) CopyItemAtPath:(NSString *)CopyItemAtPath ToPath:(NSString *)ToPath {

    NSFileManager *FileManager = [NSFileManager defaultManager];


    bool Success = [FileManager copyItemAtPath:CopyItemAtPath toPath:ToPath error:nil];

    return Success;

}


+(BOOL) MoveItemAtPath:(NSString *)MoveItemAtPath ToPath:(NSString *)ToPath {

    NSFileManager *FileManager = [NSFileManager defaultManager];


    bool Success = [FileManager moveItemAtPath:MoveItemAtPath toPath:ToPath error:nil];

    return Success;

}

+(BOOL) CreateDirectoryAtPath:(NSString *)CreateDirectoryAtPath {

    NSFileManager *FileManager = [NSFileManager defaultManager];
    NSError *error;


    bool Success = [FileManager createDirectoryAtPath:CreateDirectoryAtPath withIntermediateDirectories:YES attributes:nil error:&error];

    return Success;

}

+(BOOL) CreateFileAtPath:(NSString *)CreateFileAtPath {

    NSFileManager *FileManager = [NSFileManager defaultManager];

    bool Success = [FileManager createFileAtPath:CreateFileAtPath contents:nil attributes:nil];

    return Success;

}

+(BOOL) DownloadLink:(NSString *)DownloadLink ToPath:(NSString *)ToPath {

      NSString *stringURL = DownloadLink;
      NSURL  *url = [NSURL URLWithString:stringURL];
      NSData *urlData = [NSData dataWithContentsOfURL:url];

    static bool Success;

      if (urlData) {

          NSString *DownName = [DownloadLink lastPathComponent];
          NSString *Download = [ToPath stringByAppendingPathComponent:DownName];

          NSString  *filePath = [NSString stringWithFormat:@"%@",Download];
          Success = [urlData writeToFile:filePath atomically:YES];

          //NSLog(@"filePath ===== %@",filePath);

    }

    return Success;
}


+(void) UploadFile:(NSString *)UploadFile PHPLink:(NSString *)PHPLink PHPNameValue:(NSString *)PHPNameValue {



        NSString *LastP = [UploadFile lastPathComponent];

        NSData *Data = [[NSData alloc] initWithContentsOfFile:UploadFile];



        NSString *urlString = PHPLink;

        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:[NSURL URLWithString:urlString]];
        [request setHTTPMethod:@"POST"];
        request.timeoutInterval = 60;
        request.HTTPShouldHandleCookies = false;


        NSString *boundary = @"---------------------------14737809831466499882746641449";
        NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
        [request addValue:contentType forHTTPHeaderField: @"Content-Type"];

        NSMutableData *body = [NSMutableData data];
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithString:[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n",PHPNameValue,LastP]] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[NSData dataWithData:Data]];
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];

        [request setHTTPBody:body];


        [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable _data, NSURLResponse * _Nullable _response, NSError * _Nullable _error) {



        }]

        resume];





 }






@end
