//
//  Model.m
//  Labb2
//
//  Created by Samantha Morrison on 12/02/17.
//  Copyright © 2017 Samantha Morrison. All rights reserved.
//

#import "Model.h"

@interface Model ()

@property (nonatomic) int amountRoundsPlayed;
@property (nonatomic) int amountRoundsLeft;
@property (nonatomic) NSMutableArray* allQuestions;
@property (nonatomic) NSMutableArray* questions;
@end

@implementation Model

-(instancetype)init {
    self = [super init];
    if (self) {
        self.isGameActive = YES;
        self.amountCorrectGuesses = 0;
        self.amountRoundsPlayed = 0;
        self.amountRoundsLeft = 5;
        self.questions = [[NSMutableArray alloc] init];
        [self setUpAllQuestions];
        [self setUpRandomQuestions];
        self.currentQuestion = self.questions[0];
    }
    return self;
}


-(void)setUpAllQuestions {
    NSDictionary* q1 = @{@"Question":@"Vad heter huvudstaden i Nya Zeeland?",
                         @"Correct":@"Wellington",
                         @"Wrong1":@"Auckland",
                         @"Wrong2":@"Hamilton",
                         @"Wrong3":@"Christchurch"};
    NSDictionary* q2 = @{@"Question":@"Ungefär hur många slag slår ett människohjärta per minut?",
                         @"Correct":@"60-70",
                         @"Wrong1":@"30-40",
                         @"Wrong2":@"100-110",
                         @"Wrong3":@"150-160"};
    NSDictionary* q3 = @{@"Question":@" I vilken enhet mäts elektrisk spänning?",
                         @"Correct":@"Volt",
                         @"Wrong1":@"Ampere",
                         @"Wrong2":@"Watt",
                         @"Wrong3":@"Pascal"};
    NSDictionary* q4 = @{@"Question":@"Hur många mjölktänder har en tvååring?",
                         @"Correct":@"20",
                         @"Wrong1":@"16",
                         @"Wrong2":@"32",
                         @"Wrong3":@"10"};
    NSDictionary* q5 = @{@"Question":@"Hur många landskap har Sverige? ",
                         @"Correct":@"25",
                         @"Wrong1":@"28",
                         @"Wrong2":@"18",
                         @"Wrong3":@"22"};
    NSDictionary* q6 = @{@"Question":@"Vad är landkoden till Sverige?",
                         @"Correct":@"46",
                         @"Wrong1":@"45",
                         @"Wrong2":@"44",
                         @"Wrong3":@"47"};
    NSDictionary* q7 = @{@"Question":@"Hur långt är Sverige?",
                         @"Correct":@"1572 km",
                         @"Wrong1":@"2056 km",
                         @"Wrong2":@"1398 km",
                         @"Wrong3":@"1837 km"};
    NSDictionary* q8 = @{@"Question":@"Vem spelar den kvinniga huvudrollen i filmen 'Dirty Dancing' från 1987?",
                         @"Correct":@"Jennifer Grey",
                         @"Wrong1":@"Olivia Newton John",
                         @"Wrong2":@"Cynthia Rhodes",
                         @"Wrong3":@"Demi Moore"};
    NSDictionary* q9 = @{@"Question":@"Vad heter författaren till boken 'Flyga drake'?",
                         @"Correct":@"Khaled Hoseini",
                         @"Wrong1":@"Astrid Lindgren",
                         @"Wrong2":@"Jan Guillou",
                         @"Wrong3":@"Markus Zuzak"};
    NSDictionary* q10 = @{@"Question":@"Hur långt är ett varv runt Jorden?",
                          @"Correct":@"40 009 km",
                          @"Wrong1":@"50 032 km",
                          @"Wrong2":@"32 874 km",
                          @"Wrong3":@"61 249 km"};
    
    self.allQuestions = [NSMutableArray arrayWithObjects: q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, nil];
}

- (void)setUpRandomQuestions {
    
    for (int i = 0; i < self.amountRoundsLeft; i++) {
        int random = arc4random() % self.allQuestions.count;
        NSDictionary *randomQuestion = self.allQuestions[random];
        self.questions[i] = randomQuestion;
        [self.allQuestions removeObjectAtIndex:random];
    }
}


- (BOOL)isAnswerCorrect:(NSString*)answer {
    
    self.amountRoundsLeft--;
    self.amountRoundsPlayed++;
    
    if (self.amountRoundsLeft <= 0) {
        self.isGameActive = NO;
    }
    
    if ([self.currentQuestion[@"Correct"] isEqualToString:answer]){
        self.amountCorrectGuesses++;
        [self changeCurrentQuestion];
        return true;
    } else {
        self.amountIncorrectGuesses++;
        [self changeCurrentQuestion];
        return false;
    }
}

- (void)changeCurrentQuestion {
    if (self.isGameActive){
        self.currentQuestion = self.questions[self.amountRoundsPlayed];
    }
}

- (BOOL)isLastQuestion {
    return (self.amountRoundsLeft == 1);
}

@end
