//
//  CalculatorBrain.h
//  RPN Calculator
//
//  Created by Philip Tseng 曾世謙 on 6/25/12.
//  Copyright (c) 2012 AppOven. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject

- (void)pushOperand:(double)operand;
- (double)performOperation:(NSString *)operation;
- (void)clear;

@end
