//
//  ViewController.h
//  TestInfiniteScrollView
//
//  Created by Zonghui Zhang on 18/10/12.
//  Copyright (c) 2012 Zhang Zonghui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end
