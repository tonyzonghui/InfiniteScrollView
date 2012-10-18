//
//  ViewController.m
//  TestInfiniteScrollView
//
//  Created by Zonghui Zhang on 18/10/12.
//  Copyright (c) 2012 Zhang Zonghui. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    UIView  *m_previousView;
    UIView  *m_currentView;
    UIView  *m_nextView;
    NSInteger m_colorIndexR;
    NSInteger m_colorIndexG;
    NSInteger m_colorIndexB;
}

@property (nonatomic, strong) UIView *previousView;
@property (nonatomic, strong) UIView *currentView;
@property (nonatomic, strong) UIView *nextView;

- (UIView *)newView;
- (UIColor *)getColor;

@end

@implementation ViewController
@synthesize previousView = m_previousView;
@synthesize currentView = m_currentView;
@synthesize nextView = m_nextView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    m_colorIndexR = arc4random() % 50;
    m_colorIndexG = arc4random() % 50;
    m_colorIndexB = arc4random() % 50;
    
    self.previousView = [self newView];
    self.currentView = [self newView];
    self.nextView = [self newView];
    
    [self.scrollView addSubview:self.previousView];
    [self.scrollView addSubview:self.currentView];
    [self.scrollView addSubview:self.nextView];
    
    [self.scrollView setContentSize:CGSizeMake(3 * self.view.frame.size.width, self.view.frame.size.height)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.previousView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    self.currentView.frame = CGRectMake(self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height);
    self.nextView.frame = CGRectMake(2 * self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height);
    self.scrollView.contentOffset = CGPointMake(self.view.frame.size.width, 0);
}

#pragma mark -
#pragma mark Private Methods
- (UIView *)newView
{
    UIView *view = [[UIView alloc] initWithFrame:self.view.frame];
    view.backgroundColor = [self getColor];
    return view;
}

- (UIColor *)getColor
{
    m_colorIndexR += arc4random() % 50;
    m_colorIndexG += arc4random() % 50;
    m_colorIndexB += arc4random() % 50;
    
    m_colorIndexR %= 255;
    m_colorIndexG %= 255;
    m_colorIndexB %= 255;
    
    NSLog(@"%d, %d, %d", m_colorIndexR, m_colorIndexG, m_colorIndexB);
    
    return [UIColor colorWithRed:m_colorIndexR / 255.0 green:m_colorIndexG / 255.0 blue:m_colorIndexB / 255.0 alpha:1.0];
}

#pragma mark -
#pragma mark UIScrollView Delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // next page
    if ( scrollView.contentOffset.x > self.view.frame.size.width )
    {
        self.previousView.backgroundColor = self.currentView.backgroundColor;
        self.currentView.backgroundColor = self.nextView.backgroundColor;
        self.nextView.backgroundColor = [self getColor];
    }
    // previous page
    if ( scrollView.contentOffset.x < self.view.frame.size.width )
    {
        self.currentView.backgroundColor = self.previousView.backgroundColor;
        self.nextView.backgroundColor = self.currentView.backgroundColor;
        self.previousView.backgroundColor = [self getColor];
    }
    
    [self.scrollView setContentOffset:CGPointMake(self.view.frame.size.width, 0)];
}


@end
