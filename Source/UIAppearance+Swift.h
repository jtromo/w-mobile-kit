//
//  UIView+UIAppearance_Swift.h
//  WMobileKit

#import <UIKit/UIKit.h>

@interface UIView (UIViewAppearance_Swift)

// @param containers An array of Class < UIAppearanceContainer >
// http://stackoverflow.com/a/28765193
+ (instancetype)appearanceWhenContainedWithin:(NSArray *)containers;

@end