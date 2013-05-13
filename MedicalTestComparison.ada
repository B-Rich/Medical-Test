-- Homework 3
-- John Costantino
-- 3/5/13

with Ada.Text_IO, Ada.Float_Text_IO;
use Ada.Text_IO, Ada.Float_Text_IO;

procedure Medical_Test_Comparison is
-- Read a collection of data 
-- first line contains int N representing the number of patients in the list 
-- followed by N lines, each containign four integers, patient number 
-- followed by three numbers (1 or 0)

  size : float range 0.0..99.0;
	lines : float := 0.0;

	p_info: float range 0.0..99.0;
	diseased: float := 0.0;
	pos1: float := 0.0;
	pos2: float := 0.0;
	neg1: float := 0.0;
	neg2: float := 0.0;
	disPos1: float := 0.0;
	notNeg1: float := 0.0;
	disPos2: float := 0.0;
	notNeg2: float := 0.0;
	
	disPosTestPos1: float :=  0.0;
	disPosTestPos2: float := 0.0;
	notNegTestNeg1: float := 0.0;
	notNegTestNeg2: float := 0.0;


	procedure collect_data is
	--read a valid integer values
	begin
	
		get(p_info);	--patient number
		get(diseased);	--have disease?
		
		get(p_info);	--test1 result
	
		--sum of patients tested positive for test1
		if p_info > 0.0 then
			pos1 := pos1 + 1.0;
		else
		--sum of patients tested negative for test1
			neg1 := neg1 + 1.0;
		end if;
	
	
		--sum of patients with or without positive or negative results for test 1
		if diseased > 0.0 and p_info > 0.0 then
			disPos1 := disPos1 + 1.0;
		elsif diseased < 1.0 and p_info < 1.0 then
			notNeg1 := notNeg1 + 1.0;
		end if;
	
	
		get(p_info);
		--sum of patients tested positive for test2
		if p_info > 0.0 then
			pos2 := pos2 + 1.0;
		else
		--sum of patients tested negative for test2
			neg2 := neg2 + 1.0;
		end if;
	
		--sum of patients with or without positive or negative results for test 1
		if diseased > 0.0 and p_info > 0.0 then
			disPos2 := disPos2 + 1.0;
		elsif diseased < 1.0 and p_info < 1.0 then
			notNeg2 := notNeg2 + 1.0;
		end if;

	End collect_data;

begin
	put("Input:");
	get(size);

	while size > lines loop
		collect_data;		
		lines := lines + 1.0;
	end loop;
	
	new_line;
	
	put("Output:");
	
	disPosTestPos1 := disPos1 / pos1;
	disPosTestPos2 := disPos2 / pos2;
	notNegTestNeg1 := notNeg1 / neg1;
	notNegTestNeg2 := notNeg2 / neg2;
	
	new_line;
		put("P( D | Pos1) = ");
		if disPosTestPos1 = 1.00 then
			put("1");
		else
			put(item => disPosTestPos1, Aft => 2, Exp => 0);
		end if;
	new_line;
		put("P( D | Pos2) = ");
		if disPosTestPos2 = 1.00 then
			put("1");
		else
			put(item => disPosTestPos2, Aft => 2, Exp => 0);
		end if;
	new_line;
		put("P( H | Neg1) = ");
		if notNegTestNeg1 = 1.00 then
			put("1");
		else
			put(item => notNegTestNeg1, Aft => 2, Exp => 0);
		end if;
	new_line;
		put("P( H | Neg2) = ");
		if notNegTestNeg1 = 1.00 then
			put("1");
		else
		put(item => notNegTestNeg2, Aft => 2, Exp => 0);
		end if;
	new_line;
		if ((disPosTestPos1 > disPosTestPos2) and 
				(notNegTestNeg1 > notNegTestNeg2)) then
			put("Test 1 is better.");
		elsif ((disPosTestPos1 < disPosTestPos2) and 
				(notNegTestNeg1 < notNegTestNeg2)) then
			put("Test 2 is better.");
		else
			put("Neither test is better.");
		end if;
	
end Medical_Test_Comparison;
