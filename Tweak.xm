// By @CrazyMind90

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "CMManager.h"
#import <AppSupport/CPDistributedMessagingCenter.h>
#import <rocketbootstrap/rocketbootstrap.h>


#pragma GCC diagnostic ignored "-Wunused-variable"
#pragma GCC diagnostic ignored "-Wprotocol"
#pragma GCC diagnostic ignored "-Wmacro-redefined"
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
#pragma GCC diagnostic ignored "-Wincomplete-implementation"
#pragma GCC diagnostic ignored "-Wunknown-pragmas"
#pragma GCC diagnostic ignored "-Wformat"
#pragma GCC diagnostic ignored "-Wunknown-warning-option"
#pragma GCC diagnostic ignored "-Wincompatible-pointer-types"


  
 

@interface UIWindow (OSLogger)

-(void) BeOSLogger;
-(void) Movable_View:(UIPanGestureRecognizer *)Sender;
-(void) Button_Tapped;
-(void) InitOSLogger;
-(void) C;
-(void) DismissBaseView;
-(void) OSLoggerNotification:(NSNotification *)Notification;
-(void) Clear;
-(void) DisOSLogger;
@end

UILabel *NotificationsLabel;
UIImageView *ImageView;
UIViewController *ViewCont;
UITextView *TextView;
UIViewController *View_Controller;
UIView *BasicView;
NSString *TextHolder = nil;
BOOL isBaseViewPresented = NO;
BOOL isOSLoggerPresented = NO;
UIButton *RecordButton;
BOOL isRecording = YES;
 
%hookf(void , NSLog, NSString *_Nullable format, ...) {

if (isOSLoggerPresented && format) { 

    va_list ap;
    va_start(ap, format);

    NSString *iLogArgs = [[NSString alloc] initWithFormat:format arguments:ap];

    if (isRecording)
    [[NSNotificationCenter defaultCenter] postNotificationName:@"OSLoggerNotification" object:iLogArgs];

    va_end(ap);
  }
 
}


// %hookf(int , printf, const char *restricts, ...) {

// if (isOSLoggerPresented && restricts) { 

//     va_list arglist;
//     va_start( arglist, restricts );
//     char *target = strdup(restricts);
//     vsprintf( &target[0], restricts, arglist );
//     va_end( arglist );

//     NSLog(@"%@",@(target));
 
//  }

//   return %orig(restricts);
// }


%hook UIWindow 
%new 
- (void) OSLoggerNotification:(NSNotification *)Notification {

  if ([[Notification name] isEqual:@"OSLoggerNotification"]) { 
  
  dispatch_async(dispatch_get_main_queue(), ^{

  if (!isBaseViewPresented) { 
  NotificationsLabel.text = [NSString stringWithFormat:@"%li",(CFIndex)NotificationsLabel.text.integerValue + 1] ? : @"1";
  NotificationsLabel.hidden = NO;
  }

  TextHolder = [NSString stringWithFormat:@"%@\n%@",TextHolder ? : @"",[Notification object]];
  TextView.text = [NSString stringWithFormat:@"%@\n%@",TextView.text ? : TextHolder,[Notification object]];

  if (TextView.text.length > 0) {

    NSRange bottom = NSMakeRange(TextView.text.length -1, 1);
    [TextView scrollRangeToVisible:bottom];
  }

    });
  }
}

- (void)_resizeWindowToFullScreenIfNecessary {  

  %orig;
        
    [CMManager InitLongPressGestureRecognizerInView:self PressDuration:1.0 NumberOfTouchesRequired:2 Target:self Actions:@selector(BeOSLogger)];

}

%new
-(void) BeOSLogger {

if (!isOSLoggerPresented) { 

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(OSLoggerNotification:) name:@"OSLoggerNotification" object:nil];

    ViewCont = [[UIViewController alloc] init];
    ViewCont.view.frame = CGRectMake(10, 300, 77, 77);
    ViewCont.view.backgroundColor = UIColor.clearColor;
    [topMostController().view addSubview:ViewCont.view];

    NSArray *Obj = [CMManager InitButtonImage:[UIImage imageNamed:@"/Library/Application Support/OSLogger.bundle/OSL.png"] InView:ViewCont.view Target:self Action:@selector(Button_Tapped)];

    ImageView = [Obj objectAtIndex:1];
    ImageView.clipsToBounds = YES;
    ImageView.layer.cornerRadius = 31;
    ImageView.alpha = 0.5f;

    [ImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [NSLayoutConstraint activateConstraints:@[

    [ImageView.topAnchor constraintEqualToAnchor:ViewCont.view.topAnchor constant:7],
    [ImageView.leadingAnchor constraintEqualToAnchor:ViewCont.view.leadingAnchor constant:7],
    [ImageView.trailingAnchor constraintEqualToAnchor:ViewCont.view.trailingAnchor constant:-7],
    [ImageView.bottomAnchor constraintEqualToAnchor:ViewCont.view.bottomAnchor constant:-7],

    ]];

    NotificationsLabel = [CMManager InitLabelWithName:@"0" Frame:CGRectNull InView:ViewCont.view];
    NotificationsLabel.hidden = YES;
    NotificationsLabel.clipsToBounds = YES;
    NotificationsLabel.layer.cornerRadius = 12;
    NotificationsLabel.alpha = 0.6f;
    NotificationsLabel.layer.backgroundColor = UIColor.redColor.CGColor;
    NotificationsLabel.textAlignment = NSTextAlignmentCenter;
    NotificationsLabel.font = [UIFont systemFontOfSize:15];
    NotificationsLabel.numberOfLines = 1;
    NotificationsLabel.minimumScaleFactor = 0.01;
    NotificationsLabel.adjustsFontSizeToFitWidth = YES;


    [NotificationsLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [NSLayoutConstraint activateConstraints:@[

    [NotificationsLabel.topAnchor constraintEqualToAnchor:ViewCont.view.topAnchor constant:0],
    [NotificationsLabel.leadingAnchor constraintEqualToAnchor:ViewCont.view.leadingAnchor constant:0],
    [NotificationsLabel.trailingAnchor constraintEqualToAnchor:ViewCont.view.leadingAnchor constant:25],
    [NotificationsLabel.bottomAnchor constraintEqualToAnchor:ViewCont.view.topAnchor constant:25],

    ]];

    [CMManager InitLongPressGestureRecognizerInView:[Obj objectAtIndex:0] PressDuration:0.30 NumberOfTouchesRequired:1 Target:self Actions:@selector(DisOSLogger)];

    [CMManager InitPanGestureRecognizerOnObject:ViewCont.view Target:self Action:@selector(Movable_View:)];

    isOSLoggerPresented = YES;
    isRecording = YES;

  }
}

%new
-(void) DisOSLogger {

  [[NSNotificationCenter defaultCenter] removeObserver:self];

  [self DismissBaseView];

  [ViewCont.view setHidden:YES];
  [ViewCont.view removeFromSuperview];

  NotificationsLabel.text = @"";
  NotificationsLabel.hidden = YES;

  isOSLoggerPresented = NO;
    
}

%new
-(void) Movable_View:(UIPanGestureRecognizer *)Sender {

if (Sender.state == UIGestureRecognizerStateBegan) 
ImageView.alpha = 0.9f;

if (Sender.state == UIGestureRecognizerStateEnded)
ImageView.alpha = 0.5f;
  
[CMManager MoveableViewInView:topMostController().view Sender:Sender Delegate:self];

}

     
%new
-(void) Button_Tapped {
        
   NotificationsLabel.text = @"0";
   NotificationsLabel.hidden = YES;
    
   isBaseViewPresented ? [self DismissBaseView] : [self InitOSLogger];
 
}

%new
-(void) InitOSLogger {
        
    if (!isBaseViewPresented) { 
    BasicView = [CMManager InitViewWithBGColor:UIColor.clearColor Frame:CGRectNull BackgroundImage:nil InView:topMostController().view];
        
    BasicView.clipsToBounds = YES;
    BasicView.layer.cornerRadius = 31;
    BasicView.alpha = 0.9f;
    [BasicView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [NSLayoutConstraint activateConstraints:@[

    [BasicView.topAnchor constraintEqualToAnchor:topMostController().view.centerYAnchor constant:-180],
    [BasicView.leadingAnchor constraintEqualToAnchor:topMostController().view.centerXAnchor constant:-150],
    [BasicView.trailingAnchor constraintEqualToAnchor:topMostController().view.centerXAnchor constant:150],
    [BasicView.bottomAnchor constraintEqualToAnchor:topMostController().view.centerYAnchor constant:180],

    ]];

     [CMManager BlurView:BasicView];

        
    [CMManager InitPanGestureRecognizerOnObject:BasicView Target:self Action:@selector(Movable_View:)];
        
    NSArray *iOb = [CMManager InitButtonLabelWithName:@"OSLogger" InView:BasicView Target:self Action:@selector(C)];
        
    UILabel *OSLoggerLabel = [iOb objectAtIndex:1];
    OSLoggerLabel.textAlignment = NSTextAlignmentCenter;
    OSLoggerLabel.font = [UIFont boldSystemFontOfSize:20];
    OSLoggerLabel.numberOfLines = 1;
    OSLoggerLabel.minimumScaleFactor = 0.01;
    OSLoggerLabel.adjustsFontSizeToFitWidth = YES;
    OSLoggerLabel.layer.backgroundColor = UIColorFromHEX(0x5478E4).CGColor;

    [OSLoggerLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [NSLayoutConstraint activateConstraints:@[

    [OSLoggerLabel.topAnchor constraintEqualToAnchor:BasicView.topAnchor constant:0],
    [OSLoggerLabel.leadingAnchor constraintEqualToAnchor:BasicView.leadingAnchor constant:0],
    [OSLoggerLabel.trailingAnchor constraintEqualToAnchor:BasicView.trailingAnchor constant:-70],
    [OSLoggerLabel.bottomAnchor constraintEqualToAnchor:BasicView.topAnchor constant:50],

    ]];
        
    RecordButton = [CMManager InitButtonWithName:@"Recording" Frame:CGRectNull InView:BasicView Target:self Action:@selector(RecordState)];

    if (isRecording) {
    RecordButton.layer.backgroundColor = UIColorFromHEX(0xE94E3D).CGColor;
    [RecordButton setTitle:@"Recording" forState:UIControlStateNormal];
    } else {
    RecordButton.layer.backgroundColor = UIColorFromHEX(0x65BA4B).CGColor;
    [RecordButton setTitle:@"Start" forState:UIControlStateNormal];
    }


    RecordButton.titleLabel.font = [UIFont systemFontOfSize:13];

    [RecordButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [NSLayoutConstraint activateConstraints:@[

    [RecordButton.topAnchor constraintEqualToAnchor:BasicView.topAnchor constant:0],
    [RecordButton.leadingAnchor constraintEqualToAnchor:BasicView.trailingAnchor constant:-70],
    [RecordButton.trailingAnchor constraintEqualToAnchor:BasicView.trailingAnchor constant:0],
    [RecordButton.bottomAnchor constraintEqualToAnchor:BasicView.topAnchor constant:50],

    ]];
        
    TextView = [CMManager InitTextViewWithFrame:CGRectNull BackgroundColor:UIColor.clearColor TextColor:UIColorFromHEX(0x959595) InView:BasicView];

    TextView.text = TextHolder;
    TextView.font = [UIFont systemFontOfSize:15];
    [TextView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [NSLayoutConstraint activateConstraints:@[

    [TextView.topAnchor constraintEqualToAnchor:OSLoggerLabel.bottomAnchor constant:0],
    [TextView.leadingAnchor constraintEqualToAnchor:BasicView.leadingAnchor constant:5],
    [TextView.trailingAnchor constraintEqualToAnchor:BasicView.trailingAnchor constant:-5],
    [TextView.bottomAnchor constraintEqualToAnchor:BasicView.bottomAnchor constant:-10],

    ]];
        
    if (TextView.text.length > 0) {

    NSRange bottom = NSMakeRange(TextView.text.length -1, 1);
    [TextView scrollRangeToVisible:bottom];
    }

  UIButton *ClearButton = [CMManager InitButtonWithName:@"C" Frame:CGRectNull InView:BasicView Target:self Action:@selector(Clear)];

  ClearButton.layer.backgroundColor = UIColorFromHEX(0x656565).CGColor;
  ClearButton.layer.cornerRadius = 30;
  ClearButton.layer.maskedCorners = kCALayerMinXMinYCorner;
  ClearButton.alpha = 0.7f;
    
  [ClearButton setTranslatesAutoresizingMaskIntoConstraints:NO];
  [NSLayoutConstraint activateConstraints:@[

  [ClearButton.topAnchor constraintEqualToAnchor:BasicView.bottomAnchor constant:-43],
  [ClearButton.leadingAnchor constraintEqualToAnchor:BasicView.trailingAnchor constant:-43],
  [ClearButton.trailingAnchor constraintEqualToAnchor:BasicView.trailingAnchor constant:5],
  [ClearButton.bottomAnchor constraintEqualToAnchor:BasicView.bottomAnchor constant:5],

  ]];
    
    isBaseViewPresented = YES;
  }
        
}

%new
-(void) RecordState {
    
    if (isRecording) {
        
        RecordButton.layer.backgroundColor = UIColorFromHEX(0x65BA4B).CGColor;
        [RecordButton setTitle:@"Start" forState:UIControlStateNormal];
        isRecording = NO;
    } else {
        
        RecordButton.layer.backgroundColor = UIColorFromHEX(0xE94E3D).CGColor;
        [RecordButton setTitle:@"Recording" forState:UIControlStateNormal];
        isRecording = YES;
    }

}

%new
-(void) Clear {
    
    TextView.text = @"";
    TextHolder = @"";
}

%new
-(void) C {
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://twitter.com/CrazyMind90"] options:@{} completionHandler:nil];
}

%new
-(void) DismissBaseView {
    
    isBaseViewPresented = NO;
    [CMManager AnimatedDismissView:BasicView StartAnimationFrom:kCATransitionFade Duration:0.30 handler:^{
        
    }];
        
}

%end



 