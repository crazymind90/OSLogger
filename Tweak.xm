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
-(void) Scroll_TableView_Down;
-(UITableView *_Nullable) InitTableViewWithObjects:(NSArray *_Nullable)Objects Frame:(CGRect)Frame BackgroundColor:(UIColor *_Nullable)BGColor SeparatorColor:(UIColor *_Nullable)SepColor InView:(UIView *_Nullable)InView delegate:(id _Nullable )delegate;
-(void) CopyAlert;
@end

UILabel *NotificationsLabel;
UIImageView *ImageView;
UIView *ViewCont;
UITextView *TextView;
UIViewController *View_Controller;
UIView *BasicView;
NSString *TextHolder = nil;
BOOL isBaseViewPresented = NO;
BOOL isOSLoggerPresented = NO;
UIButton *RecordButton;
BOOL isRecording = YES;
UITableView *TableView;
NSMutableArray *MutArray;
 
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



NSArray *reArrangeArrays(NSArray *iObjects) {
    
    NSMutableArray *Words = [[NSMutableArray alloc] init];
    NSMutableArray *Colors = [[NSMutableArray alloc] init];
    
    CFIndex OneThree = 0;
    CFIndex TwoFour = 1;
    for (CFIndex iCounter = 0; iCounter < iObjects.count; iCounter ++) {
        
        [Words addObject:[iObjects objectAtIndex:OneThree]];
        [Colors addObject:[iObjects objectAtIndex:TwoFour]];
        
        OneThree = OneThree + 2;
        TwoFour = TwoFour + 2;
        
        if (OneThree > iObjects.count || TwoFour > iObjects.count)
            break;
    }
    
    return @[[NSArray arrayWithArray:Words],[NSArray arrayWithArray:Colors]];
}

NSMutableAttributedString *Colorizer(NSString *OriginalText,NSArray *WordsAndColors,UIColor *TheRestColor)  {
    
    NSArray *Text = [reArrangeArrays(WordsAndColors) objectAtIndex:0];
    NSArray *Color = [reArrangeArrays(WordsAndColors) objectAtIndex:1];

    NSMutableAttributedString *MutableAttString = [[NSMutableAttributedString alloc] initWithString:OriginalText attributes:@{NSForegroundColorAttributeName : TheRestColor}];

    NSString *text = OriginalText;

    if (OriginalText != nil) {

    for (NSUInteger Counter = 0; Counter < Color.count; Counter ++) {

    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:[NSString stringWithFormat:@"(%@)",[Text objectAtIndex:Counter]] options:kNilOptions error:nil];

    NSRange range = NSMakeRange(0 ,text.length);

    [regex enumerateMatchesInString:text options:kNilOptions range:range usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {

        NSRange subStringRange = [result rangeAtIndex:0];

        [MutableAttString addAttribute:NSForegroundColorAttributeName value:[Color objectAtIndex:Counter] range:subStringRange];

    }];


    }
}
    return MutableAttString;
}


%hook UIWindow 
%new 
- (void) OSLoggerNotification:(NSNotification *)Notification {

  if ([[Notification name] isEqual:@"OSLoggerNotification"]) { 
  
  dispatch_async(dispatch_get_main_queue(), ^{

  if (!isBaseViewPresented) { 
  NotificationsLabel.text = [NSString stringWithFormat:@"%li",(CFIndex)NotificationsLabel.text.integerValue + 1] ? : @"1";
  NotificationsLabel.hidden = NO;
  }
 
  [MutArray addObject:[Notification object]];
  [TableView reloadData];

  [self Scroll_TableView_Down];

    });
  }
}

%new
-(void) Scroll_TableView_Down {
    
    if (MutArray.count > 0)
    [TableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:MutArray.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];

}
 

- (void)_resizeWindowToFullScreenIfNecessary {  

  %orig;
        
  [CMManager InitLongPressGestureRecognizerInView:self PressDuration:1.0 NumberOfTouchesRequired:2 Target:self Actions:@selector(BeOSLogger)];

}




%new
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
 
    return MutArray.count;
}

%new
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
   NSIndexPath *Path = TableView.indexPathForSelectedRow;
   NSString *SelectedRow = MutArray[Path.row];
    
    [self CopyAlert];
    
    [CMManager CopyToClipboard:(UITableViewCell *)[tableView cellForRowAtIndexPath:indexPath].textLabel.text];
    
    [self performSelector:@selector(Reloader) withObject:nil afterDelay:0.1f];

 }

%new
-(void) Reloader {
    
    [TableView reloadData];
}



BOOL Colorize = NO;
%new
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellID = @"Cell";

    UITableViewCell *Cell;
    
    Cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellID];

    tableView.backgroundColor = UIColor.clearColor;
          
    Cell.textLabel.text = MutArray[indexPath.row];

    Cell.textLabel.textColor = UIColorFromHEX(0xFFFFFF);
    
    Cell.textLabel.numberOfLines = 0;
    
    if (Colorize) {
    Cell.backgroundColor = UIColorFromHEX(0x070707);
    Colorize = NO;
    } else if (!Colorize) {
    Cell.backgroundColor = UIColorFromHEX(0x212121);
    Colorize = YES;
    }


    if ([Cell.textLabel.text containsString:@"OSLogger"])
    Cell.textLabel.attributedText = Colorizer(Cell.textLabel.text,@[Cell.textLabel.text,UIColor.yellowColor], UIColor.whiteColor);
    
    
    return Cell;
}

 
%new
-(UITableView *_Nullable) InitTableViewWithObjects:(NSArray *_Nullable)Objects Frame:(CGRect)Frame BackgroundColor:(UIColor *_Nullable)BGColor SeparatorColor:(UIColor *_Nullable)SepColor InView:(UIView *_Nullable)InView delegate:(id _Nullable )delegate {
     
  TableView = [[UITableView alloc] initWithFrame:Frame style:UITableViewStyleGrouped];
  

  TableView.backgroundColor = BGColor;
  TableView.separatorColor = SepColor;
  TableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
  TableView.delegate = delegate;
  TableView.dataSource = delegate;

  [InView addSubview:TableView];

 
    return TableView;
    
}


%new
-(void) BeOSLogger {

if (!isOSLoggerPresented) { 

    MutArray = [[NSMutableArray alloc] init];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(OSLoggerNotification:) name:@"OSLoggerNotification" object:nil];

    ViewCont = [CMManager InitViewWithBGColor:UIColor.clearColor Frame:CGRectNull BackgroundImage:nil InView:topMostController().view];
        
    ViewCont.clipsToBounds = YES;
    ViewCont.alpha = 0.9f;
    ViewCont.backgroundColor = UIColor.clearColor;

    [ViewCont setTranslatesAutoresizingMaskIntoConstraints:NO];
    [NSLayoutConstraint activateConstraints:@[

    [ViewCont.topAnchor constraintEqualToAnchor:topMostController().view.topAnchor constant:215],
    [ViewCont.leadingAnchor constraintEqualToAnchor:topMostController().view.leadingAnchor constant:5],
    [ViewCont.trailingAnchor constraintEqualToAnchor:topMostController().view.leadingAnchor constant:75],
    [ViewCont.bottomAnchor constraintEqualToAnchor:topMostController().view.topAnchor constant:285],

    ]];

    NSArray *Obj = [CMManager InitButtonImage:[UIImage imageNamed:@"/Library/Application Support/OSLogger.bundle/OSL.png"] InView:ViewCont Target:self Action:@selector(Button_Tapped)];

    ImageView = [Obj objectAtIndex:1];
    ImageView.clipsToBounds = YES;
    ImageView.layer.cornerRadius = 35;
    ImageView.alpha = 0.7f;

    [ImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [NSLayoutConstraint activateConstraints:@[

    [ImageView.topAnchor constraintEqualToAnchor:ViewCont.topAnchor constant:0],
    [ImageView.leadingAnchor constraintEqualToAnchor:ViewCont.leadingAnchor constant:0],
    [ImageView.trailingAnchor constraintEqualToAnchor:ViewCont.trailingAnchor constant:0],
    [ImageView.bottomAnchor constraintEqualToAnchor:ViewCont.bottomAnchor constant:0],

    ]];

    NotificationsLabel = [CMManager InitLabelWithName:@"0" Frame:CGRectNull InView:ViewCont];
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

    [NotificationsLabel.topAnchor constraintEqualToAnchor:ViewCont.topAnchor constant:0],
    [NotificationsLabel.leadingAnchor constraintEqualToAnchor:ViewCont.leadingAnchor constant:0],
    [NotificationsLabel.trailingAnchor constraintEqualToAnchor:ViewCont.leadingAnchor constant:25],
    [NotificationsLabel.bottomAnchor constraintEqualToAnchor:ViewCont.topAnchor constant:25],

    ]];

    [CMManager InitLongPressGestureRecognizerInView:[Obj objectAtIndex:0] PressDuration:0.30 NumberOfTouchesRequired:1 Target:self Actions:@selector(DisOSLogger)];

    [CMManager InitPanGestureRecognizerOnObject:ViewCont Target:self Action:@selector(Movable_View:)];

    isOSLoggerPresented = YES;
    isRecording = YES;

  }
}

%new
-(void) DisOSLogger {

  [[NSNotificationCenter defaultCenter] removeObserver:self];

  [self DismissBaseView];

  [ViewCont setHidden:YES];
  [ViewCont removeFromSuperview];

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

    [BasicView.topAnchor constraintEqualToAnchor:topMostController().view.centerYAnchor constant:-230],
    [BasicView.leadingAnchor constraintEqualToAnchor:topMostController().view.centerXAnchor constant:-160],
    [BasicView.trailingAnchor constraintEqualToAnchor:topMostController().view.centerXAnchor constant:160],
    [BasicView.bottomAnchor constraintEqualToAnchor:topMostController().view.centerYAnchor constant:230],

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

 
TableView = [self InitTableViewWithObjects:nil Frame:CGRectNull BackgroundColor:UIColor.clearColor SeparatorColor:UIColor.clearColor InView:BasicView delegate:self];

TableView.alpha = 0.7f;
TableView.clipsToBounds = YES;
TableView.layer.cornerRadius = 31;
TableView.layer.maskedCorners = kCALayerMinXMaxYCorner | kCALayerMaxXMaxYCorner;
    
[TableView setTranslatesAutoresizingMaskIntoConstraints:NO];
[NSLayoutConstraint activateConstraints:@[

[TableView.topAnchor constraintEqualToAnchor:OSLoggerLabel.bottomAnchor constant:0],
[TableView.leadingAnchor constraintEqualToAnchor:BasicView.leadingAnchor constant:0],
[TableView.trailingAnchor constraintEqualToAnchor:BasicView.trailingAnchor constant:0],
[TableView.bottomAnchor constraintEqualToAnchor:BasicView.bottomAnchor constant:0],

]];  

[CMManager ActivateTheFollowingCodeAfter:0.10 handler:^{
[self Scroll_TableView_Down];
}];
    
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
    
    [MutArray removeAllObjects];
    [TableView reloadData];
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


%new
-(void) CopyAlert {
    
    UILabel *CopyLabelView = [CMManager InitLabelWithName:@"Copied" Frame:CGRectNull InView:topMostController().view];
    
    CopyLabelView.textAlignment = NSTextAlignmentCenter;
    CopyLabelView.textColor = UIColor.whiteColor;
    CopyLabelView.font = [UIFont systemFontOfSize:20];
    CopyLabelView.layer.backgroundColor = UIColorFromHEX(0x252525).CGColor;
    CopyLabelView.clipsToBounds = YES;
    CopyLabelView.layer.cornerRadius = 10;
    
    [CopyLabelView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [NSLayoutConstraint activateConstraints:@[
    
        [CopyLabelView.topAnchor constraintEqualToAnchor:topMostController().view.topAnchor constant:50],
        [CopyLabelView.leadingAnchor constraintEqualToAnchor:topMostController().view.centerXAnchor constant:-50],
        [CopyLabelView.trailingAnchor constraintEqualToAnchor:topMostController().view.centerXAnchor constant:50],
        [CopyLabelView.bottomAnchor constraintEqualToAnchor:topMostController().view.topAnchor constant:90],
        
    ]];
    
    [CMManager ViewToBeAnimated:CopyLabelView delegate:self Duration:0.35 StartAnimationFrom:kCATransitionFromBottom];
    
    [CMManager ActivateTheFollowingCodeAfter:2 handler:^{
        
        [CMManager AnimatedDismissView:CopyLabelView StartAnimationFrom:kCATransitionFromTop Duration:0.35 handler:^{
            
        }];
    }];
}

%end


 