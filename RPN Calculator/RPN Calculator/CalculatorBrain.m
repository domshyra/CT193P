//
//  CalculatorBrain.m
//  RPN Calculator
//
//  Created by Philip Tseng 曾世謙 on 6/25/12.
//  Copyright (c) 2012 AppOven. All rights reserved.
//

#import "CalculatorBrain.h"

@interface CalculatorBrain()
@property (nonatomic, strong) NSMutableArray * operandStack;
@end

@implementation CalculatorBrain

@synthesize operandStack = _operandStack;

-(NSMutableArray *)operandStack  //Getter
{
    if (!_operandStack)
        _operandStack = [[NSMutableArray alloc] init ];
    return _operandStack;
}

- (void)pushOperand:(double)operand
{
    NSNumber * operandObject = [NSNumber numberWithDouble:operand];
    [self.operandStack addObject:operandObject];
}

-(double)popOperand
{
    NSNumber * operandObject = [self.operandStack lastObject];
    if (operandObject)
        [self.operandStack removeLastObject];
    return [operandObject doubleValue];
}

- (double)performOperation:(NSString *)operation
{
    double result = 0;
    
    if ([operation isEqualToString:@"+"])
    {
        result = [self popOperand] + [self popOperand];
    }
    else if ([operation isEqualToString:@"*"])
    {
        result = [self popOperand] * [self popOperand];
    }
    else if ([operation isEqualToString:@"-"])
    {
        double subtrahend = [self popOperand];
        result = [self popOperand] - subtrahend;
    }
    else if ([operation isEqualToString:@"/"])
    {
        double divisor = [self popOperand];
        if (divisor)
            result = [self popOperand] / divisor;
    }
    }
    else if ([operation isEqualToString:@"sin"])
    {
        double divisor = [self popOperand];
        if (divisor) result = sin(M_PI/180 * divisor);
        
    }
    else if ([operation isEqualToString:@"cos"])
    {
        double divisor = [self popOperand];
        if (divisor) result = cos(M_PI/180 * divisor);
    
    else if ([operation isEqualToString:@"sqrt"])
    {
        result = sqrt([self popOperand]);
    }
    
    [self pushOperand:result];
    
    return result;
}

- (void)clear
{
    [self.operandStack removeAllObjects];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"stack = %@", self.operandStack];
}

@end
