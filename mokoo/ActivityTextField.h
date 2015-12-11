//
//  ActivityTextField.h
//  mokoo
//
//  Created by Mac on 15/9/25.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivityTextField : UITextField
@property (nonatomic) BOOL required;
@property (nonatomic, strong) UIToolbar *toolbar;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic) BOOL isPickView;
@property (nonatomic) BOOL isMulChooseView;
@property (nonatomic, setter = setDateField:) BOOL isDateField;
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
//@property (nonatomic, assign) id<MHTextFieldDelegate> textFieldDelegate;
@property (nonatomic, assign)NSInteger selectedItem;
- (BOOL) validate;
@end
