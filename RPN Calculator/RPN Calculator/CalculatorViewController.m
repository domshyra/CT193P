//
//  CalculatorViewController.m
//  RPN Calculator
//
//  Created by Philip Tseng 曾世謙 on 6/25/12.
//  Copyright (c) 2012 AppOven. All rights reserved.
//

#import "CalculatorViewController.h"
#import "CalculatorBrain.h"

@interface CalculatorViewController ()

@property (nonatomic) BOOL userIsInTheMiddleOfEnteringANumber;
@property (nonatomic, strong) CalculatorBrain * brain;

@end

@implementation CalculatorViewController

@synthesize display = _display;
@synthesize history = _history;
@synthesize userIsInTheMiddleOfEnteringANumber = _userIsInTheMiddleOfEnteringANumber;
@synthesize brain = _brain;

- (CalculatorBrain *)brain
{
    if (!_brain)
        _brain = [[CalculatorBrain alloc] init];
    return _brain;
}


- (IBAction)digitPressed:(UIButton *)sender //Method declaration
{
    NSRange decimal_check_in_display = [self.display.text rangeOfString:@"."];
    NSRange decimal_check_in_sender = [sender.currentTitle rangeOfString:@"."];
    
    if (decimal_check_in_display.location != NSNotFound && decimal_check_in_sender.location != NSNotFound && self.userIsInTheMiddleOfEnteringANumber == YES)
    {
        return;
    }
    else
    {
    if (self.userIsInTheMiddleOfEnteringANumber)
    {
        self.display.text = [self.display.text stringByAppendingString:sender.currentTitle];
    }
    else 
    {
        self.display.text = sender.currentTitle;
        self.userIsInTheMiddleOfEnteringANumber = YES;
    }
    }
}


- (IBAction)enterPressed 
{
    self.history.text = [self.history.text stringByAppendingFormat:@"%@ ",self.display.text];
    [self.brain pushOperand:[self.display.text doubleValue]];
    self.userIsInTheMiddleOfEnteringANumber = NO;
}



- (IBAction)operationPressed:(UIButton *)sender 
{
    if (self.userIsInTheMiddleOfEnteringANumber)
    {
        [self enterPressed];
    }
    NSString * operation = [sender currentTitle];
    double result = [self.brain performOperation:operation];
    self.display.text = [NSString stringWithFormat:@"%g", result];
    self.history.text = [self.history.text stringByAppendingFormat:@"%@ ", sender.currentTitle];
}

- (IBAction)piPressed 
{
    self.display.text = @"π";
    self.history.text = [self.history.text stringByAppendingFormat:@"%@ ",self.display.text];
    [self.brain pushOperand:M_PI];
}


- (IBAction)clearPressed 
{
    [self.brain clear];
    self.display.text = @"0";
    self.history.text = @"";
}

- (void)viewDidUnload {
    [self setHistory:nil];
    [super viewDidUnload];
}
@end
