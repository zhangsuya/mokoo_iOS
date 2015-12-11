//
//  ActivityTextField.m
//  mokoo
//
//  Created by Mac on 15/9/25.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import "ActivityTextField.h"
#import "SYPickView.h"
#import "MokooMacro.h"
#import "MBProgressHUD.h"
#import "SGActionView.h"
@interface ActivityTextField()<SYPickViewDelegate>
{
    UITextField *_textField;
    BOOL _disabled;
    SYPickView *pickView;
}
@property (nonatomic) BOOL keyboardIsShown;
@property (nonatomic) CGSize keyboardSize;
@property (nonatomic) BOOL hasScrollView;
@property (nonatomic) BOOL invalid;

@property (nonatomic, setter = setToolbarCommand:) BOOL isToolBarCommand;
@property (nonatomic, setter = setDoneCommand:) BOOL isDoneCommand;

@property (nonatomic , strong) UIBarButtonItem *previousBarButton;
@property (nonatomic , strong) UIBarButtonItem *nextBarButton;

@property (nonatomic, strong) NSMutableArray *textFields;
@end
@implementation ActivityTextField
@synthesize required;
@synthesize scrollView;
@synthesize toolbar;
@synthesize keyboardIsShown;
@synthesize keyboardSize;
@synthesize invalid;
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self){
        [self setup];
    }
    
    return self;
}

- (void) awakeFromNib{
    [super awakeFromNib];
    [self setup];
}
//- (void)layoutSubviews
//{
//    [super layoutSubviews];
//
//    [self markTextFieldsWithTagInView:self.superview];
//
////    _enabled = YES;
//
//}
- (void)setup
{
    [self setTintColor:[UIColor blackColor]];
    UITapGestureRecognizer *cancelTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(keyBoardHide:)];
    cancelTap.cancelsTouchesInView = NO;
    [self.superview.superview addGestureRecognizer:cancelTap];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidBeginEditing:) name:UITextFieldTextDidBeginEditingNotification object:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidEndEditing:) name:UITextFieldTextDidEndEditingNotification object:self];
    toolbar = [[UIToolbar alloc] init];
    toolbar.frame = CGRectMake(0, 0, self.window.frame.size.width, 44);
    // set style
    [toolbar setBarStyle:UIBarStyleDefault];
    
    //    self.previousBarButton = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(previousButtonIsClicked:)];
    //    self.nextBarButton = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStyleDone target:self action:@selector(nextButtonIsClicked:)];
    
    UIBarButtonItem *flexBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    UIBarButtonItem *doneBarButton =[[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(doneButtonIsClicked:)];
    //    UIBarButtonItem *doneBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonIsClicked:)];
    
    NSArray *barButtonItems = @[ flexBarButton, doneBarButton];
    
    toolbar.items = barButtonItems;
    
    //    if (_isPickView ) {
    //        toolbar.hidden =NO;
    //    }else
    //    {
    //        toolbar.hidden =YES;
    //    }
    self.textFields = [[NSMutableArray alloc]init];
    [self markTextFieldsWithTagInView:self.superview];
    
    //    [self markTextFieldsWithTagInView:self.superview.superview];
    
    
    
    
}

- (void)markTextFieldsWithTagInView:(UIView*)view
{
    int index = 0;
    if ([self.textFields count] == 0){
        for(UIView *subView in view.subviews){
            if ([subView isKindOfClass:[ActivityTextField class]]){
                ActivityTextField *textField = (ActivityTextField*)subView;
                textField.tag = index;
                [self.textFields addObject:textField];
                index++;
            }
        }
        //        for(UIView *subView in view.subviews){
        //            for (UIView *subSubView in subView.subviews) {
        //                if ([subSubView isKindOfClass:[MHTextField class]]){
        //                    MHTextField *textField = (MHTextField*)subView;
        //                    textField.tag = index;
        //                    [self.textFields addObject:textField];
        //                    index++;
        //                }
        //            }
        //
        //        }
    }
}

- (void) doneButtonIsClicked:(id)sender
{
    [self setDoneCommand:YES];
    //    [super layoutSublayersOfLayer:_textField.layer];
    //    _textField.layer.borderWidth = 0.5f;
    //    [_textField.layer setBorderColor: [UIColor blackColor].CGColor];
    [self resignFirstResponder];
    [self setToolbarCommand:YES];
}

-(void) keyboardDidShow:(NSNotification *) notification
{
    if (_textField == nil) return;
    if (keyboardIsShown) return;
    if (![_textField isKindOfClass:[ActivityTextField class]]) return;
    
    NSDictionary* info = [notification userInfo];
    
    NSValue *aValue = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
    keyboardSize = [aValue CGRectValue].size;
    
//    [self scrollToField];
    
    self.keyboardIsShown = YES;
    
}

-(void) keyboardWillHide:(NSNotification *) notification
{
//    NSTimeInterval duration = [[[notification userInfo] valueForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
//    
//    [UIView animateWithDuration:duration animations:^{
//        if (_isDoneCommand)
//            [self.scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
//    }];
//    
//    keyboardIsShown = NO;
//    
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:self];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:self];
}


//- (void) nextButtonIsClicked:(id)sender
//{
//    NSInteger tagIndex = self.tag;
//    MHTextField *textField =  [self.textFields objectAtIndex:++tagIndex];
//
//    while (!textField.isEnabled && tagIndex < [self.textFields count])
//        textField = [self.textFields objectAtIndex:++tagIndex];
//
//    [self becomeActive:textField];
//}

- (void) previousButtonIsClicked:(id)sender
{
    NSInteger tagIndex = self.tag;
    
    ActivityTextField *textField =  [self.textFields objectAtIndex:--tagIndex];
    
    while (!textField.isEnabled && tagIndex < [self.textFields count])
        textField = [self.textFields objectAtIndex:--tagIndex];
    
    [self becomeActive:textField];
}

- (void)becomeActive:(UITextField*)textField
{
    [self setToolbarCommand:YES];
    [self resignFirstResponder];
    [textField becomeFirstResponder];
}

//- (void)setBarButtonNeedsDisplayAtTag:(int)tag
//{
//    BOOL previousBarButtonEnabled = NO;
//    BOOL nexBarButtonEnabled = NO;
//
//    for (int index = 0; index < [self.textFields count]; index++) {
//
//        UITextField *textField = [self.textFields objectAtIndex:index];
//
//        if (index < tag)
//            previousBarButtonEnabled |= textField.isEnabled;
//        else if (index > tag)
//            nexBarButtonEnabled |= textField.isEnabled;
//    }
//
//    self.previousBarButton.enabled = previousBarButtonEnabled;
//}

- (void) selectInputView:(UITextField *)textField
{
    if (_isDateField){
        UIDatePicker *datePicker = [[UIDatePicker alloc] init];
        datePicker.datePickerMode = UIDatePickerModeDate;
        datePicker.locale = [NSLocale currentLocale];
        [datePicker addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
        
        if (![textField.text isEqualToString:@""]){
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"YYYY.MM.dd"];
            [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
            [dateFormatter setDateStyle:NSDateFormatterShortStyle];
            [datePicker setDate:[dateFormatter dateFromString:textField.text]];
        }
        [textField setInputView:datePicker];
    }else if (_isPickView)
    {
        pickView = [[SYPickView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, 160)];
        pickView.delegate = self;
        
        if (_isCountryField)
        {
            
            pickView.selectedArray = @[@"中国",@"美国",@"英国",@"澳大利亚",@"加拿大",@"法国",@"德国",@"日本",@"新西兰",@"俄国",@"意大利"];
            [textField setInputView:pickView];
        }else if(_isLanguageField)
        {
            pickView.selectedArray = @[@"中文",@"English"];
            [textField setInputView:pickView];
        }else if (_isLocationField)
        {
            pickView.selectedArray = @[@"北京",@"上海",@"广州",@"成都",@"重庆",@"西安"];
            [textField setInputView:pickView];
        }else if (_isPriceField)
        {
            pickView.selectedArray = @[@"500/小时",@"800/小时",@"1000/小时",@"1200/小时",@"1500/小时及以上",@"其他"];
            [textField setInputView:pickView];
        }else if (_isSkinColorField)
        {
            pickView.selectedArray = @[@"白色",@"黄色",@"黑色"];
            [textField setInputView:pickView];
        }else if (_isSexField)
        {
            pickView.selectedArray = @[@"男",@"女"];
            [textField setInputView:pickView];
        }else if (_isHeightField)
        {
            pickView.selectedArray = @[@"155cm以上",@"160cm以上",@"165cm以上",@"168cm以上",@"170cm以上",@"175cm以上",@"180cm以上",@"185cm以上"];
            [textField setInputView:pickView];
        }else if(_isHairField)
        {
            pickView.selectedArray = @[@"超短",@"齐耳",@"齐肩",@"齐胸",@"齐腰",@"齐臀"];
            [textField setInputView:pickView];
        }else if (_isEyeField)
        {
            pickView.selectedArray = @[@"黑色",@"蓝色",@"绿色",@"棕色",@"褐色",@"黄琥珀色",@"灰色黄琥珀色",@"浅紫色"];
            [textField setInputView:pickView];
        }
        
    }else if (_isMulChooseView)
    {
        
    }
}

- (void)datePickerValueChanged:(id)sender
{
    UIDatePicker *datePicker = (UIDatePicker*)sender;
    
    NSDate *selectedDate = datePicker.date;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [
     dateFormatter setDateFormat:@"YYYY.MM.dd"];
    
    [_textField setText:[dateFormatter stringFromDate:selectedDate]];
    
    [self validate];
}

- (void)scrollToField
{
    CGRect textFieldRect = _textField.frame;
    
    CGRect aRect = self.window.bounds;
    
    aRect.origin.y = -scrollView.contentOffset.y;
    aRect.size.height -= keyboardSize.height + self.toolbar.frame.size.height + 22;
    
    CGPoint textRectBoundary = CGPointMake(textFieldRect.origin.x, textFieldRect.origin.y + textFieldRect.size.height);
    
    if (!CGRectContainsPoint(aRect, textRectBoundary) || scrollView.contentOffset.y > 0) {
        CGPoint scrollPoint = CGPointMake(0.0, self.superview.frame.origin.y + _textField.frame.origin.y + _textField.frame.size.height - aRect.size.height);
        
        if (scrollPoint.y < 0) scrollPoint.y = 0;
        
        [scrollView setContentOffset:scrollPoint animated:YES];
    }
}

- (BOOL) validate
{
    self.backgroundColor = [UIColor colorWithRed:255 green:0 blue:0 alpha:0.5];
    
    if (required && [self.text isEqualToString:@""]){
        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self animated:YES];
        //            hud.labelText = ;
        // Configure for text only and offset down
        hud.mode = MBProgressHUDModeText;
        hud.labelText = [NSString stringWithFormat:@"请填写%@",_textField.placeholder];
        hud.margin = 10.f;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:1];
        return NO;
    }
    else if (_isEmailField){
        NSString *emailRegEx =
        @"(?:[A-Za-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[A-Za-z0-9!#$%\\&'*+/=?\\^_`{|}"
        @"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"
        @"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[A-Za-z0-9](?:[a-"
        @"z0-9-]*[A-Za-z0-9])?\\.)+[A-Za-z0-9](?:[A-Za-z0-9-]*[A-Za-z0-9])?|\\[(?:(?:25[0-5"
        @"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"
        @"9][0-9]?|[A-Za-z0-9-]*[A-Za-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"
        @"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])";
        
        NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
        
        if (![emailTest evaluateWithObject:self.text]){
            return NO;
        }
    }
    
    [self setBackgroundColor:[UIColor whiteColor]];
    
    return YES;
}

- (void)setEnabled:(BOOL)enabled
{
    [super setEnabled:enabled];
    
    if (!enabled)
        [self setBackgroundColor:[UIColor lightGrayColor]];
}

#pragma mark - UITextField notifications

- (void)textFieldDidBeginEditing:(NSNotification *) notification
{
    
    UITextField *textField = (UITextField*)[notification object];
    
    _textField = textField;
    
    if (_isMulChooseView) {
        [textField resignFirstResponder];
        if (_isStyleField) {
            [SGActionView sharedActionView].style = SGActionViewStyleLight ;
            NSArray *titleArray = @[ @"欧美", @"韩版", @"日系", @"英伦",
                                     @"OL风", @"学院", @"学院", @"淑女",@"性感",@"复古",@"街头",@"休闲",@"民族",@"甜美",@"运动",@"可爱",@"大码",@"中老年",@"儿童" ];
            
            //    ChooseGridView *chooseView = [[ChooseGridView alloc]initWithTitleArray:@[ @"Facebook", @"Twitter", @"Google+", @"Linkedin",@"weibo", @"wechat", @"Pocket", @"Dropbox" ]];
            [SGActionView showChooseMenuWithTitle:@"" itemTitles:titleArray limitNum:3 selectedHandle:^(NSArray *selectedArray){
                NSLog(@"%@",selectedArray);
                NSString *tmp= @"";
                for (int i = 0; i<[selectedArray count]; i++) {
                    if (i==0) {
                        tmp = [tmp stringByAppendingString:selectedArray[i]];
                    }else
                    {
                        tmp = [tmp stringByAppendingString:[NSString stringWithFormat:@"/%@",selectedArray[i]]];
                    }
                    
                }
                textField.text =tmp;
                //            textField.text =
            }];
            
        }else if (_isTypeField)
        {
            [SGActionView sharedActionView].style = SGActionViewStyleLight ;
            
            NSArray *titleArray = @[ @"走秀"
                                     ,@"车模"
                                     ,@"平面",
                                     @"展示",
                                     @"试衣",
                                     @"礼仪",
                                     @"外籍",
                                     @"腿模",
                                     @"手模",
                                     @"胸模",
                                     @"混血",
                                     @"歌手",
                                     @"演员",
                                     @"舞蹈",
                                     @"cosplay",
                                     @"showgirl",
                                     @"主持人",
                                     @"化妆师",
                                     @"造型师" ];
            //    ChooseGridView *chooseView = [[ChooseGridView alloc]initWithTitleArray:@[ @"Facebook", @"Twitter", @"Google+", @"Linkedin",@"weibo", @"wechat", @"Pocket", @"Dropbox" ]];
            [SGActionView showChooseMenuWithTitle:@"" itemTitles:titleArray limitNum:3 selectedHandle:^(NSArray *selectedArray){
                NSLog(@"%@",selectedArray);
                NSString *tmp= @"";
                for (int i = 0; i<[selectedArray count]; i++) {
                    if (i==0) {
                        tmp = [tmp stringByAppendingString:selectedArray[i]];
                    }else
                    {
                        tmp = [tmp stringByAppendingString:[NSString stringWithFormat:@"/%@",selectedArray[i]]];
                    }
                }
                textField.text =tmp;
            }];
            
            
        }
        
    }else
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
        
        //        [self setBarButtonNeedsDisplayAtTag:textField.tag];
        
        if ([self.superview isKindOfClass:[UIScrollView class]] && self.scrollView == nil)
        {
            self.scrollView = (UIScrollView*)self.superview;
        }
        //        else if([self.superview.superview isKindOfClass:[UIScrollView class]] && self.scrollView == nil)
        //        {
        //            self.scrollView = (UIScrollView*)self.superview.superview;
        //        }
        
        [self selectInputView:textField];
        if (_isPickView) {
            [self setInputAccessoryView:toolbar];
            
        }else
        {
            
        }
        
        
        [self setDoneCommand:NO];
        [self setToolbarCommand:NO];
    }
    
}

- (void)textFieldDidEndEditing:(NSNotification *) notification
{
    UITextField *textField = (UITextField*)[notification object];
    
    [self validate];
    
    _textField = nil;
    //    [_textField.layer setBorderColor: blackFontColor.CGColor];
    if (_isDateField && [textField.text isEqualToString:@""] && _isDoneCommand){
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        
        [dateFormatter setDateFormat:@"MM/dd/YY"];
        
        [textField setText:[dateFormatter stringFromDate:[NSDate date]]];
    }
    if ([textField.text isEqualToString:@""]) {
        //        [textField setBackground:[UIImage imageNamed:@""]];
    }
}
- (void)passValue:(NSString *)selectedItem
{
    [_textField setText:selectedItem];
}
- (void)passItem:(NSInteger)item
{
    
    _selectedItem = item;
    
}
- (void)keyBoardHide:(UITapGestureRecognizer*)tap
{
    [self setDoneCommand:YES];
    [self resignFirstResponder];
    [self setToolbarCommand:YES];
}

@end
