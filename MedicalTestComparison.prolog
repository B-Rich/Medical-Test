% John Costantino and Kyle Hughes
% medical_test(+PatientData, -ProbDPos1, -ProbDPos2, -ProbHNeg1,
% -ProbHNeg2, -Best)
% PatientData = [PatientNum, HasDisease, PosOnTest1, PosOnTest2]
% HasDisease, PosOnTest1, PosOnTest2 == positive when equal to 1.

% Initial call to method PatientData is a list
% ----------------------------------------------------------------
medical_test(PatientData, ProbDPos1, ProbDPos2, ProbHNeg1, ProbHNeg2, Best) :-
        dpos1(PatientData, DP1, P1),
        dpos2(PatientData, DP2, P2),
        hneg1(PatientData, HN1, N1),
        hneg2(PatientData, HN2, N2),
  % ----------------------------
	% performs the computations for the output
	% ----------------------------
        ProbDPos1 is DP1/P1,
        ProbDPos2 is DP2/P2,
        ProbHNeg1 is HN1/N1,
        ProbHNeg2 is HN2/N2,

	% Finds the best of the 2 tests.
	% -------------------------------------------
        findBest(ProbDPos1, ProbDPos2, ProbHNeg1, ProbHNeg2, Best).

%//////////////////////////////////////////////////////////////
% Solves for the probability DPos1
% --------------------------------
dpos1([],0,0).

% If the patient is positive in index 1 and 2
% then the count for DP1 goes up by 1.
% and the count for P1 goes up by 1.
% DP1 = diseased and positive on test 1.
% P1 = positive on test 1.
% --------------------------------------------
dpos1([[_,1,1,_]|T], DP1, P1) :-
        dpos1(T, BothPos, PosTest),
        DP1 is 1 + BothPos,
        P1 is 1 + PosTest.

% If the patient is positive in just index 2.
% and the count for P1 goes up by 1.
% ---------------------------------------------
dpos1([[_,0,1,_]|T], DP1, P1) :-
        dpos1(T, DP1, PosTest),
        P1 is 1 + PosTest.
% If the patient is not positive in index 1 or 2
% then it checks the next sublist.
% -------------------------------------------
dpos1([[_,_,_,_]|T], DP1, P1) :-
        dpos1(T, DP1, P1).

%/////////////////////////////////////////////////////////////
% Solves for the probability of DPos2
% ---------------------------------
dpos2([],0,0).

% If the patient is positive in index 1 and 3
% then the count for DP2 goes up by 1.
% and the count for P2 goes up by 1.
% DP2 = diseased and positive on test 2
% P2 = positive on test 2
% -------------------------------------------
dpos2([[_,1,_,1]|T], DP2, P2) :-
        dpos2(T, BothPos, PosTest),
        DP2 is 1 + BothPos,
        P2 is 1 + PosTest.

% If the patient is positive in index 3
% then the count for P2 goes up by 1.
% -------------------------------------------
dpos2([[_,0,_,1]|T], DP2, P2) :-
        dpos2(T, DP2, PosTest),
        P2 is 1 + PosTest.

% If the patient is not positive in index 1 or 2
% then it searches the next sublist.
% -------------------------------------------
dpos2([[_,_,_,_]|T], DP2, P2) :-
        dpos2(T, DP2, P2).

% ///////////////////////////////////////////////////////////////
% Solves for the probability of HNeg1
% --------------------------
hneg1([],0,0).

% If the patient is negative in index 1 and 2
% then the count for HN1 goes up by 1.
% and the count for N1 goes up by 1.
% HN1 = healthy and negative for test 1
% N1 = negative for test 1
% -------------------------------------------
hneg1([[_,0,0,_]|T], HN1, N1) :-
        hneg1(T, BothNeg, NegTest),
        HN1 is 1 + BothNeg,
        N1 is 1 +  NegTest.

% If the patient is negative in index 2
% and the count for N1 goes up by 1.
% ---------------------------------------------
hneg1([[_,1,0,_]|T], HN1, N1) :-
        hneg1(T, HN1, NegTest),
        N1 is 1 + NegTest.

% If the patient is not negative in index 1 or 2
% then it searches the rest of the subArrays
% ---------------------------------------------
hneg1([[_,_,_,_]|T], HN1, N1) :-
        hneg1(T, HN1, N1).

% ///////////////////////////////////////////////////////////////
% Solves for the probability of HNeg1
% --------------------------
hneg2([],0,0).

% If the patient is negative in index 1 and 3
% then the count for HN2 goes up by 1.
% and the count for N2 goes up by 1.
% HN2 = healthy and negative for test 2
% N2 = negative for test 2
% -------------------------------------------
hneg2([[_,0,_,0]|T], HN2, N2) :-
        hneg2(T, BothNeg, NegTest),
        HN2 is 1 + BothNeg,
        N2 is 1 + NegTest.

% If the patient is negative in index 3
% and the count for N2 goes up by 1.
% -------------------------------------------
hneg2([[_,1,_,0]|T], HN2, N2) :-
        hneg2(T, HN2, NegTest),
        N2 is 1 + NegTest.

% If the patient is not negative in index 1 or 3
% then it searches the sub arrrays remaining.
% -------------------------------------------
hneg2([[_,_,_,_]|T], HN2,N2) :-
        hneg2(T, HN2, N2).

% //////////////////////////////////////////////////////////////
% Determines which test is the most accurate,
% if they are equal then it returns neither.

% Test one is better in this case
% -------------------------------------------------
findBest(ProbDPos1, ProbDPos2, ProbHNeg1, ProbHNeg2, Best) :-
        ProbDPos1 > ProbDPos2,
        ProbHNeg1 > ProbHNeg2,
        Best = test1.

% Test two is better in this case
% -------------------------------------------------
findBest(ProbDPos1, ProbDPos2, ProbHNeg1, ProbHNeg2, Best) :-
        ProbDPos1 < ProbDPos2,
        ProbHNeg1 < ProbHNeg2,
        Best = test2.

% Neither test is better
% -----------------------------
findBest(_,_,_,_, Best) :-
        Best = neither.
