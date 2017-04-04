//
//  Model.h
//  Labb2
//
//  Created by Samantha Morrison on 12/02/17.
//  Copyright © 2017 Samantha Morrison. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface Model : NSObject

@property (nonatomic) int amountCorrectGuesses;
@property (nonatomic) int amountIncorrectGuesses;
@property (nonatomic) NSDictionary* currentQuestion;
@property (nonatomic) BOOL isGameActive;

- (BOOL)isAnswerCorrect:(NSString*)answer;
- (BOOL)isLastQuestion;

@end
