/**
*	Original Author: Darío Ureña
*	E-Mail: darioaxel@gmail.com
*/

grammar powerscript;

@header {
package org.darioaxel.grammar.powerscript;
}

compilationUnit
    :  memberDeclaration* EOF
    ;

memberDeclaration
    : forwardDeclaration            	
    | typeDeclaration					
    | localVariableDeclarationBlock
    | globalVariableDeclarationBlock
    | variableDeclaration
    | constantDeclaration
    | functionDeclaration
    | functionDeclarationBlock
    | functionImplementation
    | onImplementation
    | eventDeclaration
    | eventImplementation
    ;

// 1. Forward Declaration
forwardDeclaration
	: forwardDeclarationBegin forwardDeclarationBody* forwardDeclarationEnd	  
	;
	
forwardDeclarationBegin
	: 'forward' delimiter
	;
	
forwardDeclarationEnd
	: 'end' 'forward' delimiter
	;
	
forwardDeclarationBody
	: variableDeclaration
	| typeDeclaration
	;

// 2. Type Declaration	ejemplo: /Ginpix7/Lib/g7xCS_01/n_cst_gestoravisos.sru
typeDeclaration
	: typeDeclarationBegin typeDeclarationBody? typeDeclarationEnd
	;

typeDeclarationBegin
	: scopeModificator? typeDeclarationBeginIdentifier  typeDeclarationParent delimiter
	;

typeDeclarationBeginIdentifier
	: 'type' Identifier 'from'
	;

typeDeclarationParent
	: typeDeclarationParentExpecification? Identifier 
	;

typeDeclarationParentExpecification
	: typeDeclarationParentExpecificationId 'within' 
	;

typeDeclarationParentExpecificationId
	: Identifier '`' Identifier
	| Identifier
	;	

typeDeclarationBody							
	: typeDeclarationDescriptor
	| variableDeclaration
	| eventDeclaration
	;

typeDeclarationDescriptor
	: 'descriptor' quotedIdentifier '=' quotedIdentifier delimiter
	;

quotedIdentifier
	: QUOTE Identifier QUOTE
	;

typeDeclarationEnd
	: 'end' 'type' delimiter?
	;

// 3. Local Variable Declaration Block
localVariableDeclarationBlock
	: localVariableDeclarationBegin  localVariableDeclarationBody localVariableDeclarationEnd
	;

localVariableDeclarationBody
	: variableDeclaration
        | constantDeclaration
	;
	
localVariableDeclarationBegin
	: 'type' 'variables' delimiter
	;

localVariableDeclarationEnd
	: 'end' 'variables' delimiter
	;

// 4. Global Variable Declaration Block
globalVariableDeclarationBlock
    : globalVariableDeclarationBlockBegin globalVariableDeclarationBlockBody globalVariableDeclarationBlockEnd
    ;

globalVariableDeclarationBlockBegin
    : globalScopeModificator 'variables' delimiter
    ;

globalVariableDeclarationBlockBody
    : variableDeclaration
    | constantDeclaration
    ;

globalVariableDeclarationBlockEnd
    : 'end' 'variables' delimiter
    ;

// 5. Variable Declaration
variableDeclaration
    :   extendedAccessType? type variableDeclarators delimiter
    ;

variableDeclarators
    :   variableDeclarator (',' variableDeclarator)*
    ;

variableDeclarator
    :   variableDeclaratorId ('=' variableInitializer)? 
    ;

variableInitializer 
    : expression
    ;

variableDeclaratorId
    :   Identifier ('[' ']')*
    ;	

// 6. Constants Declaration
constantDeclaration
    :   'constant' type constantDeclarator (',' constantDeclarator)* delimiter
    ;

constantDeclarator
    :   Identifier arrayLengthDeclarator* '=' variableInitializer
    ;

// 7. Function Declaration
functionDeclaration
    : functionDeclarationHeader parametersList functionDeclarationEnd delimiter
    ;

functionDeclarationHeader
    : accessType? scopeModificator? functionHeaderIdentification 
    ;

functionDeclarationEnd
    : functionDeclarationEndLibrary? functionDeclarationEndRPC? functionDeclarationEndThrows?
    ;

functionDeclarationEndLibrary
    : 'library' Identifier ('alias' 'for' Identifier)?
    ;

functionDeclarationEndRPC
    : 'rpcfunc' 'alias' 'for' Identifier
    ;

// 8. Function Declaration Block
functionDeclarationBlock
    : functionDeclarationBlockHeader functionDeclaration* functionDeclarationBlockEnd
    ;

functionDeclarationBlockHeader
    : functionBlockType 'prototypes' delimiter
    ;

functionDeclarationBlockBody
    : functionDeclaration
    ;

functionDeclarationBlockEnd
    : 'end' 'prototypes' delimiter
    ;
  
// 9. Function Implementation
functionImplementation
    : functionImplementationHeader functionImplementationBody* functionImplementationEnd delimiter
    ;
	
functionImplementationHeader
    : primaryAccessType scopeModificator? functionHeaderIdentification parametersList functionDeclarationEndThrows? ';'
    ;

functionHeaderIdentification
    : functionHeaderDefinition Identifier
    ;

functionHeaderDefinition
    : 'function' dataTypeName
    | 'subroutine'
    ;

functionDeclarationEndThrows
    : 'throws' Identifier
    ;

functionImplementationBody
    : statementBlock 
    ;

functionImplementationEnd
    : 'end' 'function'
    | 'end' 'subroutine'
    ;

functionBlockType
    : 'forward'
    | 'type'
    ;

// 10. On Implementation
onImplementation
    : onImplementationHead onImplementationBody onImplementationEnd
    ;

onImplementationHead
    : 'On' onImplementationIdentifier delimiter
    ;

onImplementationIdentifier
    : Identifier
    | 'open'
    | 'close'
    ;

onImplementationBody
    : statement*?
    ;

onImplementationEnd
    : 'end' 'on' delimiter
    ;

// 11. Event Declaration
eventDeclaration
    : 'event' eventTypeDeclaration Identifier? parametersList delimiter
    ;

eventTypeDeclaration
    : 'type'
    | creatorType
    ;

creatorType
    : 'create'
    | 'destroy'
    ;

// 12. Event Implementation
eventImplementation
    : eventImplementationHead eventImplementationBody eventImplementationEnd
    ;

eventImplementationHead
    : 'event' eventImplementationHeadType? eventImplementationHeadId? eventImplementationClosure parametersList?
    ;

eventImplementationHeadType
    : 'type' dataTypeName
    ;

eventImplementationHeadId
    : Identifier '::'
    ;

eventImplementationClosure
    : Identifier
    | 'open'
    | 'close'
    ;

eventImplementationBody 
    : statement*?
    ;

eventImplementationEnd
    : 'end' 'event' delimiter
    ;    
	
parametersList
    : '(' parametersDeclarators? ')'
    ;
	
parametersDeclarators 
    : parameterDeclarator (',' parameterDeclarator)*?
    ;

parameterDeclarator
    : 'readonly'? 'ref'? primitiveType Identifier arrayType?
    ;

arrayType
	: '[' ']'
	;

scopeModificator
    : 'global'
    | 'local'
    ;

globalScopeModificator
    : 'global'
    | 'shared'
    ;
	
statementBlock
    :   variableDeclaration
    |   statement
    ;

statement
    : expression
/*	| ifStatement
	| callStatement
	| tryCatchStatement
	| doLoopWhileStatement
	| forStatement
	| returnStatement
	| destroyStatement
	| throwStatement
	| goToStatement
	| basicStatement */
    ;

doLoopWhileStatement
    :   doWhileUntilLoop
    |   doLoopWhileUntil
    ;

doWhileUntilLoop
    :   'DO' ('UNTIL' | 'WHILE') expression delimiter statement* delimiter 'LOOP' delimiter
    ;

doLoopWhileUntil
    :   'DO' delimiter statement* delimiter 'LOOP' ('WHILE' | 'UNTIL') expression delimiter
    ;

tryCatchStatement
    : tryStatement catchStatement*? finallyStatement? endTryStatement
    ;

tryStatement 
    : 'TRY' delimiter statement* delimiter
    ;

catchStatement
    : 'CATCH' '(' variableDeclaration ')' delimiter statement* delimiter
    ;

finallyStatement
    : 'FINALLY' delimiter statement* delimiter
    ;

endTryStatement
    : 'END' 'TRY' delimiter
    ;

forStatement
	: forStatementBegin forStatementBody forStatementEnd
	;

forStatementBody
	: statement* delimiter
	;

forStatementEnd
	: 'NEXT' delimiter
	;

forStatementBegin
	: 'FOR' expression delimiter forStatementBeginTo?
	;

forStatementBeginTo
	: 'TO' expression forStatementBeginToStep delimiter
	;

forStatementBeginToStep
	: 'STEP' IntegerLiteral
	;

ifStatement
	: 'IF' expression ifStatementThen ifStatementBody+? ifStatementEnd 
	;

ifStatementBody
	: statement
	| ifStatementElseIf
	;

ifStatementElseIf
	: 'ELSEIF' expression ifStatementThen 
	| 'ELSE' statement+?
	;

ifStatementEnd
	: 'END' 'IF' delimiter
	;
	
ifStatementThen
	: 'THEN' delimiter
	;

goToStatement
	: 'GOTO' Identifier
	;

destroyStatement
	: 'DESTROY' Identifier
	;
	
returnStatement
	: 'RETURN' expression
	;

throwStatement
	: 'THROW' expression
	;

callStatement
	: 'CALL' Identifier callStatementSubControl? '::' Identifier 
	;

callStatementSubControl
	: '`' Identifier
	;	

basicStatement
	: 'EXIT'
	| 'HALT'
	| 'CONTINUE'
	;

qualifiedName
    :   Identifier ('.' Identifier)*
    ;

expression
    :   primary
    |   expression '.' Identifier
	|   expression '=' 'CREATE' 'USING'? Identifier	
    |   expression '(' expressionList? ')'
    |   '(' type ')' expression
    |   expression ('+=' | '-=')
    |   ('+'|'-'|'++'|'--') expression
    |   ('~'|'!') expression
    |   expression ('*'|'/'|'%') expression
    |   expression ('+'|'-') expression
    |   expression ('<' '<' | '>' '>' '>' | '>' '>') expression
    |   expression ('<=' | '>=' | '>' | '<') expression
    |   expression ('==' | '!=') expression
    |   expression '&' expression
    |   expression '^' expression
    |   expression '|' expression
    |   expression 'AND' expression
    |   expression 'OR' expression
    |   expression '?' expression ':' expression
    |   <assoc=right> expression
        (   '='
        |   '+='
        |   '-='
        |   '*='
        |   '/='
        |   '&='
        |   '|='
        |   '^='
        |   '>>='
        |   '>>>='
        |   '<<='
        |   '%='
        )
        expression
    ;
	
expressionList
    :   expression (',' expression)*
    ;

primary
    :  '(' expression ')'
    |  literal	
    |  Identifier
    ;

literal
    :   IntegerLiteral
    |   BooleanLiteral
    |	StringLiteral
    |   CharacterLiteral
	// | 	DecimalLiteral
    | 	DateTimeLiteral
    |   'null'
    ;

modifier
    :   'PUBLIC' ':'
    |   'PRIVATE' ':'
    |   'PROTECTED' ':'
    ;

accessType
	: primaryAccessType
	| extendedAccessType
	;

primaryAccessType
    :   'PUBLIC'
    |   'public'
    |   'PRIVATE'
    |   'private'
    |   'PROTECTED'
    |   'protected'
    ;

extendedAccessType
    :   'PROTECTEDREAD'
    |   'protectedread'
    |   'PRIVATEREAD'
    |   'privateread'
    |   'PROTECTEDWRITE'
    |   'protectedwrite'
    |   'PRIVATEWRITE'
    |   'privatewrite'
    ;

dataTypeName
    :   'ANY'
    |   'BLOB'
    |   'boolean'
    |   'byte'
    |   'character'
    |   'char'
    |   'date'
    |   'datetime'
    |   'decimal'
    |   'dec'
    |   'double'
    |   'integer'
    |   'int'
    |   'long'
    |   'longlong'
    |   'real'
    |   'string'
    |   'TIME'
    |   'UNSIGNEDINTEGER'
    |   'UINT'
    |   'UNSIGNEDLONG'
    |   'ULONG'
    |	'WINDOW'
    ;

type
    :   primitiveType 
	|   objectType
    ;

objectType
	:	Identifier ( '.' Identifier )*
	;

arrayLengthDeclarator
    : '[' arrayLengthValue* ']'
    ;

arrayLengthValue
    : arrayLengthRange (',' arrayLengthRange)*
    ;

arrayLengthRange
    :  IntegerLiteral ('TO' IntegerLiteral)*
    ;

delimiter
    :   '\n'+
    ;

primitiveType
    :   'boolean'
    |   'char'
    |   'byte'
    |   'short'
    |   'integer'
    |   'long'
    |   'float'
    |   'double'
    |   'real'
	|	'string'
	| 	'date'
    ;

// Integer Literals

IntegerLiteral
    :   DecimalIntegerLiteral
    ;

fragment
DecimalIntegerLiteral
    :   DecimalNumeral IntegerTypeSuffix?
    ;

fragment
IntegerTypeSuffix
    :   [lL]
    ;

// Boolean Literals

BooleanLiteral
    :   'true'
    |   'false'
    ;

// Character Literals

CharacterLiteral
    :   '\'' SingleCharacter '\''
    |   '\'' EscapeSequence '\''
    ;

fragment
SingleCharacter
    :   ~['\\]
    ;
	
// String Literals

StringLiteral
    :   '"' StringCharacters? '"'
    ;
fragment
StringCharacters
    :   StringCharacter+
    ;
fragment
StringCharacter
    :   ~["\\]
    |   EscapeSequence
    ;

fragment
EscapeSequence
    :   '\\' [btnfr"'\\]
    |   OctalEscape
    |   UnicodeEscape
    ;

fragment
DecimalNumeral
    :   '0'
    |   NonZeroDigit (Digits? | Underscores Digits)
    ;

fragment
Digits
    :   Digit (DigitOrUnderscore* Digit)?
    ;

fragment
Digit
    :   '0'
    |   NonZeroDigit
    ;

fragment
NonZeroDigit
    :   [1-9]
    ;

fragment
OctalEscape
    :   '\\' OctalDigit
    |   '\\' OctalDigit OctalDigit
    |   '\\' ZeroToThree OctalDigit OctalDigit
    ;

fragment
UnicodeEscape
    :   '\\' 'u' HexDigit HexDigit HexDigit HexDigit
    ;

fragment
HexDigits
    :   HexDigit (HexDigitOrUnderscore* HexDigit)?
    ;

fragment
HexDigitOrUnderscore
    :   HexDigit
    |   '_'
    ;

fragment
HexDigit
    :   [0-9a-fA-F]
    ;

fragment
OctalDigits
    :   OctalDigit (OctalDigitOrUnderscore* OctalDigit)?
    ;

fragment
OctalDigit
    :   [0-7]
    ;

fragment
OctalDigitOrUnderscore
    :   OctalDigit
    |   '_'
    ;

fragment
DigitOrUnderscore
    :   Digit
    |   '_'
    ;

fragment
Underscores
    :   '_'+
    ;

// DateTimeLiteral
DateTimeLiteral
	: DateTimeYear '-' DateTimeMonth '-' DateTimeDay
	;

fragment
DateTimeYear
	: ZeroToTwo Digit Digit Digit
	;

fragment
DateTimeMonth
	: ZeroToOne Digit
	;

fragment
DateTimeDay
	: ZeroToThree Digit
	;

fragment
ZeroToThree
	: [0-3]
	;
	
fragment
ZeroToTwo
	: [0-2]
	;

fragment
ZeroToOne
	: [0-1]
	;


// SEPARATORS

LPAREN          : '(';
RPAREN          : ')';
LBRACE          : '{';
RBRACE          : '}';
LBRACK          : '[';
RBRACK          : ']';
SEMI            : ';';
COMMA           : ',';
DOT             : '.';
QUOTE			: '"';

// §3.12 OPERATORS

ASSIGN          : '=';
GT              : '>';
LT              : '<';
BANG            : '!';
TILDE           : '~';
QUESTION        : '?';
COLON           : ':';
EQUAL           : '==';
LE              : '<=';
GE              : '>=';
NOTEQUAL        : '!=';
AND             : 'AND';
OR              : 'OR';
INC             : '++';
DEC             : '--';
ADD             : '+';
SUB             : '-';
MUL             : '*';
DIV             : '/';
BITAND          : '&';
BITOR           : '|';
CARET           : '^';
MOD             : '%';

ADD_ASSIGN      : '+=';
SUB_ASSIGN      : '-=';
MUL_ASSIGN      : '*=';
DIV_ASSIGN      : '/=';
AND_ASSIGN      : '&=';
OR_ASSIGN       : '|=';
XOR_ASSIGN      : '^=';
MOD_ASSIGN      : '%=';
LSHIFT_ASSIGN   : '<<=';
RSHIFT_ASSIGN   : '>>=';
URSHIFT_ASSIGN  : '>>>=';

// § INDENTIFIERS (must appear after all keywords in the grammar)

Identifier
    :   PBLetter PBLetterOrDigit*
    ;

fragment
PBLetter
    :   [a-zA-Z$-_%] 
    ;

fragment
PBLetterOrDigit
    :   [a-zA-Z0-9$-_%] 
    ;

// § COMMENTS & WHITESPACES
COMMENT
    :   '/*' .*? '*/' -> skip
    ;

LINE_COMMENT
    :   '//' ~[\r\n]* -> skip
    ;
	
WS: [ \n\t\r]+ -> skip;
