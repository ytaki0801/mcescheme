////
//// Meta-Circular Evaluator in JavaScript,
//// ported from mce.scm by using mcescm-js.js
////
//// This code is licensed under CC0.
//// https://creativecommons.org/publicdomain/zero/1.0/
////

((EVL,APY,APD,ALS,ASQ,ECD,EAG,S)=>
 EVL(S, [['car','car'],['cdr','cdr'],['cons','cons'], // initial env
	 ['eq?','eq?'],['pair?','pair?']],
     APD,ALS,ASQ,ECD,EAG,APY))(

    (U=>U(U))(U=>(S,E,APD,ALS,ASQ,ECD,EAG,APY)=> // EVL: eval
	      typeof(S) == 'string' ? ASQ(S,E)[1] :
	      S[0] == 'quote'  ? S[1] :
	      S[0] == 'cond'   ? ECD(S.slice(1),E,U,APD,ALS,ASQ,ECD,EAG,APY) :
	      S[0] == 'lambda' ? APD(S,[E]) :
	      APY(U(U)(S[0],E,APD,ALS,ASQ,ECD,EAG,APY),
		  EAG(S.slice(1),E,U,APD,ALS,ASQ,ECD,EAG,APY),
		  U,APD,ALS,ASQ,ECD,EAG,APY)),

    ((F,A,U,APD,ALS,ASQ,ECD,EAG,APY)=> // APY: apply
     typeof(F) == 'string' ?
     F == 'car'   ? A[0][0] :
     F == 'cdr'   ? A[0].slice(1) :
     F == 'cons'  ? [A[0]].concat(A[1]) :
     F == 'eq?'   ? (A[0] == A[1] || (A[0].length == 0 && A[1].length == 0)) :
     F == 'pair?' ? Array.isArray(A[0]) : [] :
     U(U)(F[2],APD(ALS(F[1],A),F[3]),APD,ALS,ASQ,ECD,EAG,APY)),

    (U=>U(U))(U=>(A,B)=> // APD: append equivalent
	      A.length == 0 ? B :
	      [A[0]].concat(U(U)(A.slice(1),B))),

    (U=>U(U))(U=>(A,B)=> // ALS: make alist
	      A.length == 0 ? [] :
	      B.length == 0 ? [] :
	      [[A[0],B[0]]].concat(U(U)(A.slice(1),B.slice(1)))),

    (U=>U(U))(U=>(K,V)=> // ASQ: assq equivalent
	      V.length == 0 ? [] :
	      K == V[0][0] ? V[0] :
	      U(U)(K,V.slice(1))),

    (M=>M(M))(M=>(P,E,U,APD,ALS,ASQ,ECD,EAG,APY)=> // ECD: eval cond-ret lists
	      P.length == 0 ? [] :
	      P[0][0] == 'else' ?
	      U(U)(P[0][1],E,APD,ALS,ASQ,ECD,EAG,APY) :
	      U(U)(P[0][0],E,APD,ALS,ASQ,ECD,EAG,APY) ?
	      U(U)(P[0][1],E,APD,ALS,ASQ,ECD,EAG,APY) :
	      M(M)(P.slice(1),E,U,APD,ALS,ASQ,ECD,EAG,APY)),

    (M=>M(M))(M=>(A,E,U,APD,ALS,ASQ,ECD,EAG,APY)=> // EAG: eval args
	      A.length == 0 ? [] :
	      [U(U)(A[0],E,APD,ALS,ASQ,ECD,EAG,APY)].concat(
		  M(M)(A.slice(1),E,U,APD,ALS,ASQ,ECD,EAG,APY))),

    // S: sample code
    
    ////////////////////////////////////////////////////////////

    [['lambda',['EVL','APY','APD','ALS','ASQ','ECD','EAG','S'],
      ['EVL','S',
       ['quote',
	[['car','car'],['cdr','cdr'],['cons','cons'],
	 ['eq?','eq?'],['pair?','pair?']]],
       'APD','ALS','ASQ','ECD','EAG','APY']],

     [['lambda',['U'],['U','U']],
      ['lambda',['U'],
       ['lambda',['S','E','APD','ALS','ASQ','ECD','EAG','APY'],
	['cond',
	 [['pair?','S'],
	  ['cond',
	   [['eq?',['car','S'],['quote','quote']],
	    ['car',['cdr','S']]],
	   [['eq?',['car','S'],['quote','cond']],
	    ['ECD',['cdr','S'],'E',
	     'U','APD','ALS','ASQ','ECD','EAG','APY']],
	   [['eq?',['car','S'],['quote','lambda']],
	    ['APD','S',['cons','E',['quote',[]]]]],
	   ['else',['APY',[['U','U'],['car','S'],'E',
			   'APD','ALS','ASQ','ECD','EAG','APY'],
		    ['EAG',['cdr','S'],'E',
		     'U','APD','ALS','ASQ','ECD','EAG','APY'],
		    'U','APD','ALS','ASQ','ECD','EAG','APY']]]],
         ['else',['car', // not cons but list
		  ['cdr',['ASQ','S','E']]]]]]]],

     ['lambda',['F','A','U','APD','ALS','ASQ','ECD','EAG','APY'],
      ['cond',
       [['pair?','F'],
	[['U','U'],['car',['cdr',['cdr','F']]],
	 ['APD',['ALS',['car',['cdr','F']],'A'],
	  ['car',['cdr',['cdr',['cdr','F']]]]],
	 'APD','ALS','ASQ','ECD','EAG','APY']],
       [['eq?','F',['quote','car']],['car',['car','A']]],
       [['eq?','F',['quote','cdr']],['cdr',['car','A']]],
       [['eq?','F',['quote','cons']],
	['cons',['car','A'],['car',['cdr','A']]]],
       [['eq?','F',['quote','eq?']],
	['eq?',['car','A'],['car',['cdr','A']]]],
       [['eq?','F',['quote','pair?']],['pair?',['car','A']]]]],
 
     [['lambda',['U'],['U','U']],
      ['lambda',['U'],
       ['lambda',['A','B'],
	['cond',
	 [['eq?','A',['quote',[]]],'B'],
	 ['else',['cons',['car','A'],[['U','U'],['cdr','A'],'B']]]]]]],
 
     [['lambda',['U'],['U','U']],
      ['lambda',['U'],
       ['lambda',['A','B'],
	['cond',
	 [['eq?','A',['quote',[]]],['quote',[]]],
	 [['eq?','B',['quote',[]]],['quote',[]]],
	 ['else',['cons',['cons',['car','A'], // not cons but list
			  ['cons',['car','B'],['quote',[]]]],
		  [['U','U'],['cdr','A'],['cdr','B']]]]]]]],

     [['lambda',['U'],['U','U']],
      ['lambda',['U'],
       ['lambda',['K','V'],
	['cond',
	 [['eq?','V',['quote',[]]],['quote',[]]],
	 [['eq?','K',['car',['car','V']]],['car','V']],
	 ['else',[['U','U'],'K',['cdr','V']]]]]]],

     [['lambda',['M'],['M','M']],
      ['lambda',['M'],
       ['lambda',['P','E','U','APD','ALS','ASQ','ECD','EAG','APY'],
	['cond',
	 [['eq?','P',['quote',[]]], ['quote',[]]],
	 [['eq?',['car',['car','P']],['quote','else']],
	  [['U','U'],['car',['cdr',['car','P']]],'E',
	   'APD','ALS','ASQ','ECD','EAG','APY']],
	 [[['U','U'],['car',['car','P']],'E',
	   'APD','ALS','ASQ','ECD','EAG','APY'],
	  [['U','U'],['car',['cdr',['car','P']]],'E',
	   'APD','ALS','ASQ','ECD','EAG','APY']],
	 ['else',[['M','M'],['cdr','P'],'E',
		  'U','APD','ALS','ASQ','ECD','EAG','APY']]]]]],
     
     [['lambda',['M'],['M','M']],
      ['lambda',['M'],
       ['lambda',['A','E','U','APD','ALS','ASQ','ECD','EAG','APY'],
	['cond',
	 [['eq?','A',['quote',[]]],['quote',[]]],
	 ['else',['cons',[['U','U'],['car','A'],'E',
			  'APD','ALS','ASQ','ECD','EAG','APY'],
		  [['M','M'],['cdr','A'],'E',
		   'U','APD','ALS','ASQ','ECD','EAG','APY']]]]]]],

     ['quote',

     [[['lambda',['U'],['U','U']],
       ['lambda',['U'],
	['lambda',['X','R'],
	 ['cond',
	  [['eq?','X',['quote',[]]],'R'],
	  ['else',[['U','U'],['cdr','X'],['cons','X','R']]]]]]],
      ['quote',['O','O','O','O','O']],
      ['quote',[]]]
      // => [ [ 'O' ],
      //      [ 'O', 'O' ],
      //      [ 'O', 'O', 'O' ],
      //      [ 'O', 'O', 'O', 'O' ],
      //      [ 'O', 'O', 'O', 'O', 'O' ] ]

     ]]

    ////////////////////////////////////////////////////////////
    
)

