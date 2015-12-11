//
//  MHTextField.h
//
//  Created by Mehfuz Hossain on 4/11/13.
//  Copyright (c) 2013 Mehfuz Hossain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SYPickView.h"

@class MHTextField;

@protocol MHTextFieldDelegate <NSObject>

@required
- (MHTextField*) textFieldAtIndex:(int)index;
- (int) numberOfTextFields;
@end

@interface MHTextField : UITextField
{
    SYPickView *pickView;

}
@property (nonatomic) BOOL required;
@property (nonatomic, strong) UIToolbar *toolbar;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic) BOOL isPickView;
@property (nonatomic) BOOL isMulChooseView;
@property (nonatomic, setter = setDateField:) BOOL isDateField;
@property (nonatomic, setter = setTimeField:) BOOL isTimeField;
@property (nonatomic, setter = setDateTimeField: )BOOL isDateTimeField;
@property (nonatomic, setter= setUUDateField:) BOOL isUUDateField;
@property (nonatomic, setter = setEmailField:) BOOL isEmailField;
@property (nonatomic, setter = setCountryField:) BOOL isCountryField;
@property (nonatomic, setter = setLocationField:) BOOL isLocationField;
@property (nonatomic, setter = setLanguageField:) BOOL isLanguageField;
@property (nonatomic, setter = setPriceField:) BOOL isPriceField;
@property (nonatomic, setter = setSkinColorField:) BOOL isSkinColorField;
@property (nonatomic, setter=setHeightField:) BOOL isHeightField;
@property (nonatomic, setter=setSexField:)BOOL isSexField;
@property (nonatomic, setter=setStyleField:)BOOL isStyleField;
@property (nonatomic, setter=setTypeField:)BOOL isTypeField;
@property (nonatomic, setter=setHairField:)BOOL isHairField;
@property (nonatomic, setter=setEyeField:)BOOL isEyeField;
@property (nonatomic, setter=setExperienceField:)BOOL isExperienceField;
@property (nonatomic, setter=setThreeTextField:)BOOL isThreeTextField;
@property (nonatomic, setter=setOrderTextField:)BOOL isOrderTextField;
@property (nonatomic)BOOL isScreen;
@property (nonatomic, assign) id<MHTextFieldDelegate> textFieldDelegate;
@property (nonatomic, assign)NSInteger selectedItem;
@property (nonatomic,copy)NSString *mulSelectedItem;
- (BOOL) validate;




@end
