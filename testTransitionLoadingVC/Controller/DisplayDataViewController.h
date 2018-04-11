//
//  DisplayDataViewController.h
//  testTransitionLoadingVC
//
//  Created by Bomi on 2018/1/29.
//  Copyright © 2018年 PrototypeC. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol displayDataViewControllerDelegate<NSObject>
@required
- (void)updateDataViewController: (UIViewController *)viewController;
@end

@interface DisplayDataViewController : UIViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil message: (NSString *)message;

@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (nonatomic, weak) id <displayDataViewControllerDelegate> delegate;

@end
